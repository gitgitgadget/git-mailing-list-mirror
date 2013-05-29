From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 23:56:58 +0530
Message-ID: <CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com> <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhl67-0005gZ-9r
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384Ab3E2S1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 14:27:40 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53601 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965160Ab3E2S1i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 14:27:38 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so11771327iee.11
        for <git@vger.kernel.org>; Wed, 29 May 2013 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zjcdEIbP9ss/lh7m/I5SWnQ/H2QJlGNq/Kv73uar0Lc=;
        b=nRhQL6kNnynARRlgsxe7biQt5BzbH1vhA3PjdUoyoGxhhECdBjoPE7R72Ui2oGzex0
         ypt5IQfY/EBeJodePluuLTMt73H+f/HDhjtCGTbaOT5gLL77/UeG1Xgp/e/K0H6eR0xg
         FAC34hPxWCbQX4KrH64rcvDC1LsCM3qb8ERaMUPN0MEGVrh8dW5OwbjhQ9Y3b78Sq992
         UMu5+P6EG7uTKIQgnzNdW5stmM/XVW8hyqqanw98Z7+kf7BKf/jpKAvr7klmS+PI+B4E
         Yz05iAk24WN1Ukg/3z8zpDLmQtGmmLnlc7XmjleZyEpdd9oWGZygOjkmihu2Ido3ge9d
         S9HA==
X-Received: by 10.50.41.99 with SMTP id e3mr9960944igl.104.1369852058360; Wed,
 29 May 2013 11:27:38 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 11:26:58 -0700 (PDT)
In-Reply-To: <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225861>

Br=C3=A1ulio Bhavamitra wrote:
>   root =3D rev-parse --show-toplevel

What is your usecase for this?

>  upstream =3D !git for-each-ref --format=3D'%(upstream:short)' $(git
> symbolic-ref -q HEAD)

Again, what is the usecase?  What doesn't @{u} do?

>  upstream-remote =3D !git upstream | sed -e 's/\\/.*$//g'

Windows back-slashes?

>  out =3D !git fetch `git upstream-remote` && git l `git upstream`..HE=
AD

I didn't understand this at all.  What are you doing?

>  in =3D pull --dry-run

Why?

>  unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
>  untracked =3D ls-files --other --exclude-standard
>  staged =3D ls-files --staged
>  modified =3D ls-files --modified
>  deleted =3D ls-files --deleted

What is wrong with git status showing a unified output?

>   head =3D !git l -1

What is git l again?

>  current =3D rev-parse --abbrev-ref HEAD

Why don't you use a prompt?  Use the one in contrib/completion/git-prom=
pt.sh.
