From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed, 1 Dec 2010 14:01:43 -0800
Message-ID: <26B3CE3C-0C45-4D0B-8588-3769467AF527@sb.org>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net> <1291230820.11917.25.camel@drew-northup.unet.maine.edu> <877hftuvvz.fsf@picasso.cante.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:01:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNukJ-0002xS-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab0LAWBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:01:47 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43873 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0LAWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:01:46 -0500
Received: by pva4 with SMTP id 4so1152568pva.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:01:46 -0800 (PST)
Received: by 10.142.253.21 with SMTP id a21mr9551146wfi.219.1291240905997;
        Wed, 01 Dec 2010 14:01:45 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm526030wfa.23.2010.12.01.14.01.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 14:01:45 -0800 (PST)
In-Reply-To: <877hftuvvz.fsf@picasso.cante.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162619>

On Dec 1, 2010, at 11:37 AM, Jari Aalto wrote:

> 2010-12-01 21:13 Drew Northup <drew.northup@maine.edu>:
>> "~" examples is actually a disservice to the documentation reader in a
> 
> Well. What I can say. I have witnessed close hand for thousands of
> learners. Unfortunately they don't get educated that way. Bright people
> may. But I'd rather address average Joe who is switching from SVN or the
> like.
> 
> What people appreciate, while learning, is constency. Sticking to one
> notation is better than giving multiple choices. And the "^" isn't
> exactly readable, don't you agree?
> 
>    HEAD^^^^^^^^
> 
> Right. How many was there again?

Your patch isn't touching any example of HEAD^^^^^^^. Every single one that
you've changed was a simple HEAD^. And this, I feel, is absolutely wrong.
HEAD^ is far more common notation than HEAD~1, and should be preserved as
such in the manpage. I also agree with Drew that giving examples with
different notation is useful to show alternative syntax. If the manpages
all use a single notation when there are several options, it gives the
impression that this one notation is what you should always use. And that's
not what the manpage is trying to say.

-Kevin Ballard
