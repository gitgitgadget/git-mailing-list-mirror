From: "Melton Low (devl)" <softw.devl@gmail.com>
Subject: Re: How to update git on Mac OS X Mountain Lion 10.8.4
Date: Fri, 28 Jun 2013 15:06:37 -0600
Message-ID: <51CDFADD.8000707@gmail.com>
References: <CAN_-5Z94-OV7rHYf+mUuf_xanxu0+odwovv0mpB4GRHVsjccDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Olivier de Broqueville <olivier.debroqueville@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 23:06:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsfsU-0002pJ-3e
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 23:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab3F1VGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 17:06:42 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45838 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3F1VGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 17:06:41 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so2717639pbc.9
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NM81ajlrIoSzD9aNGIdK7kDlEHWhFrghdd16rzlJXmY=;
        b=QjOI++/0SPtioRZnk5PIfLt1Zb5C7uxgq9szn19lK42jNxz0M9jDQ/uJ7OVsFdg2sF
         MJ6t50+iQgDIKFisAbRLsXZOZN/N5xWxg04Jd/FDv21ZzpheF+UpAMudYA9W8iO9J+3U
         lPTMK8Fazcwxk1yduFKorW90LAqtvKfD+OkvcvBvK/zOfdtgg2wBNiXG9F8VbELDLfvg
         3+GbwFx6qsdNHmgcDsMdOqgagizqe8kdQZSf+96/RPncgQ+zZ/TowqL9wPIxNfZqODZc
         LpVwjb2ec0lFjJDwSdrfTxR2Sx8nlikTs+jkErrpiuMhWmSx3z+wntHd5onoitg5bvaz
         3kpg==
X-Received: by 10.68.171.226 with SMTP id ax2mr13184119pbc.201.1372453601064;
        Fri, 28 Jun 2013 14:06:41 -0700 (PDT)
Received: from BigBook-2.local (S010620c9d00fc430.cg.shawcable.net. [70.72.44.173])
        by mx.google.com with ESMTPSA id sq5sm10562913pab.11.2013.06.28.14.06.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 14:06:40 -0700 (PDT)
User-Agent: Postbox 3.0.8 (Macintosh/20130427)
In-Reply-To: <CAN_-5Z94-OV7rHYf+mUuf_xanxu0+odwovv0mpB4GRHVsjccDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229240>

Hi,

Did you do a "sudo make install" as the last step?

As a general rule of thumb on OS X, don't update or otherwise do 
anything to stuff installed by Apple.  You have to install the newer 
version from the Git repository to a different directory, eg /usr/local 
or /usr/local/git .

./configure --prefix=/usr/local
or
./configure --prefix=/usr/local/git

make all
sudo make install

Then change your login profile, from the terminal, to reflect the new 
bin location, eg /usr/local/bin or /usr/local/git/bin .

Hope this help.

Mel

Olivier de Broqueville wrote:
> Hello,
>
> I've learnt that Xcode installs git by default on the Mac. My current
> version of git is 1.7.12.4 and it's located in /usr/bin/git.
>
> I wanted to update git to the latest stable version available:
> 1.8.3.1. I proceeded with the instructions on:
> http://git-scm.com/downloads and typed:
>
> git clone https://github.com/git/git.git
>
> (rather than using the .dmg file because I don't want to install a new
> version of git in addition to the existing one used by Xcode.
> Furthermore, I have no idea where the new version would end up being
> installed and I've read that users have had trouble doing this!)
>
> This rendered the following results:
> Oliviers-iMac:~ odebroqueville$ git clone https://github.com/git/git.git
> Cloning into 'git'...
> remote: Counting objects: 157697, done.
> remote: Compressing objects: 100% (53116/53116), done.
> remote: Total 157697 (delta 114700), reused 143715 (delta 102625)
> Receiving objects: 100% (157697/157697), 39.56 MiB | 2.01 MiB/s, done.
> Resolving deltas: 100% (114700/114700), done.
> Oliviers-iMac:~ odebroqueville$ which git
> /usr/bin/git
> Oliviers-iMac:~ odebroqueville$ git --version
> git version 1.7.12.4 (Apple Git-37)
>
> As you can see, nothing seems to have changed!
>
> Would you have any explanations?
>
> Thank you in advance for your help.
> Best regards,
> Olivier de Broqueville.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
