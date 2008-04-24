From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: Different Versions
Date: Thu, 24 Apr 2008 10:57:19 -0400
Message-ID: <1c5969370804240757i1349432at55fb2a7aeae1da63@mail.gmail.com>
References: <899199.2868131209043100219.JavaMail.servlet@kundenserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rjtaylor@havocinspired.co.uk
X-From: git-owner@vger.kernel.org Thu Apr 24 16:59:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp2tn-0008QK-UM
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 16:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYDXO5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 10:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYDXO5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 10:57:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:21416 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYDXO5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 10:57:24 -0400
Received: by yw-out-2324.google.com with SMTP id 5so324222ywh.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5MRQCoC1vGe3drmry92h3r7ZT3B56TKMXifNblEoZ3I=;
        b=mosjnUSL1Fcxt/+qPe/27GxlY7M98FI1pKm658+En6kPneQfZMFjEuDYAy1KpePjQJCuL0tkByBhKHajUnqRuEOxE6IzWDolxVdxAzOvTIuID6n+cefoy2deU/wXkxYtl5I+HSkznqLfsb0iCqVxoAr/DJHyejUlWEKQgUlk4l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U+2oG6EFleEXVRLUAgBwyjgkfOkoBeTH0Exc+SLFbzpvVQ/W5V5rXZig6u8If7kf9nfVdT2RmRs4uIj9hROijWt0kEzAJAkxp+FZODXm+j7HyWz7FGPJiIEwos6HSzKJf8l6plty7bgdakLhMLzapPHzM8iKOiYVu6JyXP8u/Uw=
Received: by 10.142.115.10 with SMTP id n10mr485200wfc.8.1209049039147;
        Thu, 24 Apr 2008 07:57:19 -0700 (PDT)
Received: by 10.142.170.10 with HTTP; Thu, 24 Apr 2008 07:57:19 -0700 (PDT)
In-Reply-To: <899199.2868131209043100219.JavaMail.servlet@kundenserver>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80305>

I've always had trouble when dev servers and live servers have
differences.  Apart from how well 1.4 and 1.5 might work with
eachother, I'd recommend building from latest stable (1.5.5.1) on both
machines anyway.  I build on 7.10 and the 2-line default instructions
at the top of git/INSTALL work pretty well.

I get an error if I try to build the info, so just leave out the info
and install-info, and it should be ok.


On Thu, Apr 24, 2008 at 9:18 AM,  <rjtaylor@havocinspired.co.uk> wrote:
> Hi,
>
>  First post, hope this is going to the right place.
>
>  I'm in a fairly restricted situation were I have a Live Web Server and a Dev Web Server. Now the Live box is running Ubuntu 7.04, and installs git version 1.4.* through apt-get. On the Dev box I've got Ubuntu 7.10, and this installs git version 1.5.*.
>
>  Each seem to use slightly different commands, e.g. to initialise a repository.
>
>  My question is am I ok to use git versions 1.4.* and 1.5.* together, or am I going to have problems? Should I down great my Dev box to Ubuntu 7.04 to get git version 1.4* so they are the same?
>
>  I can't take down the Live box, or upgrade git on it, hence the fairly restricted situation.
>
>  Any advice would be appreciated.
>
>  Regards
>
>  Ryan
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
