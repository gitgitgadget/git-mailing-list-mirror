From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 13:34:03 -0700
Message-ID: <20130714203403.GE8564@google.com>
References: <7vzjtspwvo.fsf@alter.siamese.dyndns.org>
 <51E03B18.5040502@kdbg.org>
 <7vli5bllsd.fsf@alter.siamese.dyndns.org>
 <51E0605E.9020902@kdbg.org>
 <7vy59biih4.fsf@alter.siamese.dyndns.org>
 <51E0F93A.8050201@kdbg.org>
 <7vwqougwec.fsf@alter.siamese.dyndns.org>
 <51E1B5DB.9080904@kdbg.org>
 <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
 <51E3084D.2040504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 14 22:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UySzl-0005bI-AN
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 22:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab3GNUeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 16:34:08 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62282 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab3GNUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 16:34:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so10472421pab.8
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LbQcFNZRCt3O0E/06qF7xnugMJsmAW5Z1hmTX6F74Dg=;
        b=gUbJnYqHPHmTSFhSnpGdgDrgwuiosvsSbuYcKk/qbpuYPIX+U5L5T2jTqz4gIcEQ0C
         XxI10La0C0KloHVHdaNM0ywX+5Gs1u1xf1DgTyeuL7TOQuDrN9I1TflrZPIW/fnCRiHq
         gX1X7G5thkF/6+mRj3QsRZOD/EYgT6r1grBLxAEZxmbW6ufjUdSRMlboOr5qPMw/8Xdg
         ThvOa4lkv4MofPnJgdq+/6j2fC12SHG4hhYZgUdENDcoMkpdDNf30Rddw1dtvIEDrwlM
         E7Oxi63uBYdAM30DbFxownbNhV5TGAzBmh0kGVt7iKJzdoniafZXWfi3vN3AYCe3omru
         v19A==
X-Received: by 10.66.119.35 with SMTP id kr3mr52837959pab.149.1373834046372;
        Sun, 14 Jul 2013 13:34:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id lk9sm42543652pab.2.2013.07.14.13.34.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 13:34:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E3084D.2040504@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230389>

Johannes Sixt wrote:

> Sorry, IMO, this goes into a totally wrong direction, in particular, I
> think that this is going to close to door to make --lockref the default
> some day in a way that helps everyone.

Would a '*' that acts like --lockref on a per ref basis address your
concerns?

I realize that that design would hurt a project of making '+' use
lockref automatically some day.  I think that's ok, and that '+'
meaning "push whatever I have, regardless of what's on the other end,
and I mean it" would be better semantics in the long term (which
doesn't match the current behavior either :/).

Jonathan
