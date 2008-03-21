From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: [PATCH] gitweb: Add hash parameter in feed URL when a hash is specified in the current request
Date: Fri, 21 Mar 2008 20:14:16 +0100
Message-ID: <ae63f8b50803211214i59184fd7jde7d640d6a8580b8@mail.gmail.com>
References: <ae63f8b50803211138y6355fd11pa64cda50a1f53011@mail.gmail.com>
	 <m3skyjvrgr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 20:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcmhg-0005lx-0l
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 20:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbYCUTOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYCUTOS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 15:14:18 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:34242 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYCUTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 15:14:17 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2103211mue.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=gquIEC41EoC4NUlago6ERllmkDz8lhzQjugv5xuDvjs=;
        b=QyMPKf7M1FpgwUtv4CDsdZxkjsVONeqmXEef5fwn9I4aTAosnoGwG4scTIRBQVl0QRhltO6SFeWfB+DxHkdC8i24pvRhHIQusSPX0eMSkmQZ4QzWsPnAUsfoqPkK304UxX00eBMGG5tzBaz3lmWLhAFLk2DkwmDBo/UhE85X9/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ykci7n+ce+jOsCd04Xd+VlLWctWV8ElBuR+FiYlPq1g6o/xyUs6L0Ia3+xUg8MSmBUug3j+VGhtwMpRZzsCJAilqxHyLQf4Lq4i4/1mo5tcV2W6ZmO9isPYOwlO45R7UFxoX9yR55EDB/710y6H/ZyQVd8zdf7r5p7c4/XRIWt8=
Received: by 10.78.138.14 with SMTP id l14mr4502356hud.63.1206126856013;
        Fri, 21 Mar 2008 12:14:16 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Fri, 21 Mar 2008 12:14:16 -0700 (PDT)
In-Reply-To: <m3skyjvrgr.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 3a8eb332b9f91908
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77760>

I just read your initial post, and IMHO we should keep it simple.  I
tested the various links, and it appears to be good-enough to pass the
hash parameter for all URLs that do not specify the hash parameter
explicitly.  You can still pass it on a per-link basis if you think
it's too simplistic.

Maybe it's not the perfect solution, but at least it will improve the
current situation where some people are apparently deceived by not
having a per-branch RSS feed.  Not everyone forges URLs like we do :D

Oh, and about the title, just appending the hash is sufficient.
What's important is the contents of the feed.  Users will probably end
up editing the feed title in their reader after all.

Cheers,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
