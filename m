From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] run-command: encode signal death as a positive integer
Date: Sat, 5 Jan 2013 15:58:44 -0800
Message-ID: <20130105235844.GC5686@elie.Belkin>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
 <20130105140316.GA7272@sigill.intra.peff.net>
 <20130105144949.GA24479@sigill.intra.peff.net>
 <20130105221909.GA3247@elie.Belkin>
 <20130105231248.GA4140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:59:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trddu-00046I-0z
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab3AEX6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:58:51 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58161 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab3AEX6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:58:50 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so9878409pbc.33
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mr+GH3NF1vnhr34GjAuEyTVk1fDCxwPjnP/2jL7DUXk=;
        b=vN7lj8iIcCq9DkY26Xv27FGkwbNDLXh/zgTFN18D3dBa+6uO1HAYblUHcOVd87IOzh
         AELTDL3IOiIGUHkOsxwmAE/jyM+SmiVrcgMxiijrVPWX5If5/pSIeZqZBAdJ4jiWvHbD
         dhQT6WSTtwXA/T/GaeBj/bjmiVDi5BDf6rw6UzvZtaZdugBh5rv/dYGa/spRU9COqrR6
         HAGl5ff8StjfujKWL4jnyf0jMa8KYeHvoYVmb/QkBnRiFDts6kXyWmq9to6QFkqRCrUO
         Uo0+SbnOYEQ7h4f1+3QKeku6201SDnBhTPuNg03I7A9x2Ce1VyHdKguqwOIcdEko4yR7
         wbZQ==
X-Received: by 10.66.85.70 with SMTP id f6mr157269695paz.76.1357430329869;
        Sat, 05 Jan 2013 15:58:49 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id us7sm34792501pbc.40.2013.01.05.15.58.47
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 15:58:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105231248.GA4140@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212743>

Jeff King wrote:

>                        I'd expecting cooking this patch for a while
> would flush out any I missed.

Heh, probably not. ;-)  But I tried to examine all the callsites (and
only found the two messages I mentioned), and among the reviewers, I'm
guessing we hit them all.

Ciao,
Jonathan
