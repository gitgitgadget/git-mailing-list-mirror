From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: recipe to use git for deployment
Date: Wed, 16 May 2012 15:08:00 -0500
Message-ID: <4FB40920.6010106@gmail.com>
References: <jo283q$kna$1@dough.gmane.org> <1336190286-sup-3813@nixos> <4FA4BAF3.10601@gmail.com> <CAMK1S_i0bsO0fp69Ae_75dySsN9r=z1+c2psEMm4urw+UpYGXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Weber <marco-oweber@gmx.de>, git <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 22:08:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUkW3-0007aY-2T
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 22:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281Ab2EPUIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 16:08:06 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41340 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760597Ab2EPUIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 16:08:04 -0400
Received: by gglu4 with SMTP id u4so1114075ggl.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1CXCfxCgwmAXLxpLiWnEEgRY+dRl50eaCREF7RArODA=;
        b=EVw0Oyxf+mtfPElwqER0GsDh5m34zNOKOgIC+M/6xnuxDqHuFWDys/LbYeHvxLC0E0
         JLBd7U9CbA+r2rDUNxCbuvoqKhp1gdGdcaoLfqvmBhYpeA9gpg98hC0R3/DWyGK71HsP
         YLvAGGGqw0eGAVEVOGv9eeewzNKT/kq7w8lecSVLZbGRYgTQt0EXvAcaf6CmLsWb+WCW
         QOOk1/wvq48K2bA4txiwcsdsPjJ6PzepVhoXdK2UTfysp/kh6os3dJFlAExIMlZvuqLO
         0sIVkQUJ9xBWikKqQmzkEKYH2D+HijYJdL/DwOGzEZjLv3c+pCyXHmU/tSu26vEZRpJM
         AfpQ==
Received: by 10.60.14.41 with SMTP id m9mr4025508oec.57.1337198882716;
        Wed, 16 May 2012 13:08:02 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id a6sm2531875oeg.7.2012.05.16.13.08.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 13:08:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAMK1S_i0bsO0fp69Ae_75dySsN9r=z1+c2psEMm4urw+UpYGXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197896>

On 5/5/2012 7:14 AM, Sitaram Chamarty wrote:
> On Sat, May 5, 2012 at 11:00 AM, Neal Kreitzinger
> <nkreitzinger@gmail.com>  wrote:
>
>> Interestingly, git-archive was not intended for deployment, but it does
>> pretty good at it.
> Except it doesn't delete files that should be deleted (the way 'git
> checkout' does or rsync would if you gave it --delete).
>
Oh, yeah.  Thats why I move everything to a backup directory before 
untarring it.  That also satisfies our pre-git practice of saving off 
the old version before replacing it so we have a quick recovery point if 
the new version turns out to be worse than the old one!

v/r,
neal
