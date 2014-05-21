From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 15:27:01 -0700
Message-ID: <20140521222701.GA24537@hudson.localdomain>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
 <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
 <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
 <20140521215059.GB13956@hudson.localdomain>
 <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
 <20140521220250.GA11970@sigill.intra.peff.net>
 <xmqqfvk2ok10.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:27:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEye-0003Kw-RT
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbaEUW1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:27:08 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:45926 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbaEUW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:27:07 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1808656pdi.13
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iTqa02UUlYAGeQxqduw8DTWpWlfE7wfFoyOfD9TCuAc=;
        b=UWIX+GOn5Hpm0W3HXC1rTERiboU4rlqQxRrg9Z1npc5F9edGO+EFxhoMDoIiUXVbip
         qJ8XhPlequHd4YQsV+5NwXxHLyNIZi6R2Zu2rIn4yxxRciUatGR7qKcXHfNldRhmOxHV
         VQvyuzyJyt8kmaCYyYHeX9qJrZyxlw3DK+U+gUMKcNkloqA/9LK7MJFWQKQBT34hJHGk
         cjBJjAxL1ON/CQV/7iRHqkIQf0mPhUlT6uXVThNqr5XRahHt3l2RdgNMPNGByvhIN58N
         3/+0ydWJQGxSQjGqkWm0KZs3I7cePcVNj011iS36h1Tv4XlLCu0zDdUPspOU1jcZ2Vfa
         s86Q==
X-Received: by 10.68.171.4 with SMTP id aq4mr62847167pbc.150.1400711226043;
        Wed, 21 May 2014 15:27:06 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id ox3sm9727225pbb.88.2014.05.21.15.27.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:27:04 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 15:27:01 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqfvk2ok10.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249854>

On Wed, May 21, 2014 at 03:15:55PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> Yeah, placing it in its own setup may be the best.  There are quite
> a many set-ups outside the tests in this script from the olden days,
> so I am OK if left it as-is and have a separate clean-up patch after
> this topic settles.  I am also OK to add a new one "the new right way"
> so that a later clean-up patch does not have to change what is added
> in this step.

I like the idea of limiting the scope of this data so it couldn't
inadvertently impact later tests.

But placing the same data inside multiple test cases creates duplication.

Is there a way to define data once for a limited set of tests?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
