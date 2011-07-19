From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: newbie - missing file from untracked list
Date: Tue, 19 Jul 2011 10:56:53 +0800
Message-ID: <4E24F275.3030906@gmail.com>
References: <1311040156386-6597192.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: govinda <govinda.webdnatalk@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 05:01:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj0Ya-0004fv-Hc
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 05:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab1GSC5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 22:57:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40992 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab1GSC5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 22:57:00 -0400
Received: by iyb12 with SMTP id 12so3671699iyb.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Z4kY01+LeDmq0tuKIIyty5gppNj7JKCU1MgBUnL2EPI=;
        b=IQawkGYAOOIIiu/yYTuQFz3xq5mJyz5IVfOORNxfjEJQGSGaxjnoYHd7aoo6fOVQMg
         r6Z0nY5JLHDL2kz1NUfyCmXiDNG0XDViK29nGPliQ3l5YW/9rKhVh3yFnvj6EV5ymv83
         M5co59ex4YZMYTZ+ao+TheVTf7CZj4eOR5YHQ=
Received: by 10.42.154.69 with SMTP id p5mr7973746icw.246.1311044219948;
        Mon, 18 Jul 2011 19:56:59 -0700 (PDT)
Received: from [192.168.0.100] ([123.115.148.152])
        by mx.google.com with ESMTPS id v16sm3296307ibf.42.2011.07.18.19.56.56
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 19:56:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1311040156386-6597192.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177434>

=E4=BA=8E 11-7-19 =E4=B8=8A=E5=8D=889:49, govinda =E5=86=99=E9=81=93:
> [Govindas-iMac-2:SS_site_root] Govind% git add mainline_finishes.html
> [Govindas-iMac-2:SS_site_root] Govind% git status
> # On branch Gov_SS_2011-07-16
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   VL_ShowMan.html
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> [snip]
> #	Intranet_IE/CSI_Admin.html
> #	Intranet_IE/DealerUpdate_Approve.html
> [snip]
>=20
> ^^^ *where* is 'mainline_finishes.html'?!
>=20

If the file 'mainline_finishes.html' is already in the repository,
add it again without any modifications, the file will not show in
git-status output.

You can see files aready in HEAD:

    $ git ls-tree HEAD

or files in stage.

    $ git ls-files -s


> I would sort that untracked file listing for ease of reading.. but I =
do not
> know how (if it is even possible)... is there an option for 'git stat=
us -?'
> that causes the list to sort alphabetically?  At the moment is seems =
to try
> to sort ..but breaks the lists into a couple/few separate clumps of
> otherwise alphabetized file names. (That makes no sense to me.)

$ git status -s | grep "^?" | sort

--=20
Jiang Xin
