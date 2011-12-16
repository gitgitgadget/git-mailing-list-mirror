From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Fri, 16 Dec 2011 17:59:08 -0600
Message-ID: <20111216235908.GA5858@elie.hsd1.il.comcast.net>
References: <4EEBC9D6.6010204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 17 00:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbhgS-0006Ue-AD
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 00:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1LPX7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 18:59:17 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57876 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab1LPX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 18:59:16 -0500
Received: by ghbz12 with SMTP id z12so2732195ghb.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 15:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IDX0McMdRW7/B8wEtPufCthkrMFuM8dwO3JTZ4Yic0g=;
        b=Xk4iN4bUiDB7VfVIm+r82uEj+7diZ0fTGR0fOgTH/+cYejrHL6GKEhiUuWVGyGsU6p
         yzu5ygtPv6/z70jE1BWz+GZ282wy+wA8HEFVkuNKd4Amseak43297g9ieYB00rqPdASA
         QVrOBe/gSgDEYB6Y7i4nWj8E2JagCtbpGVjWk=
Received: by 10.236.192.135 with SMTP id i7mr2425528yhn.13.1324079955716;
        Fri, 16 Dec 2011 15:59:15 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f17sm24308873ang.20.2011.12.16.15.59.14
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 15:59:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EEBC9D6.6010204@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187337>

Ramsay Jones wrote:

>         CC builtin/checkout.o
>     builtin/checkout.c: In function `cmd_checkout':
>     builtin/checkout.c:160: warning: 'mode' might be used uninitialized \
>         in this function
[...]
> [Note that only 2 out of the 3 versions of gcc I use issues this
> warning]

Which version of gcc is that?  Is gcc getting more sane, so we won't
have to worry about this after a while, or is the false positive a
new regression that should be reported to them?
