From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sun, 16 May 2010 11:57:05 +0530
Message-ID: <AANLkTinSJTzYOk_MRp2ddlLnbd5dC65q-c4zQbv8Oubj@mail.gmail.com>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 08:27:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODXJm-000396-Uj
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 08:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab0EPG1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 02:27:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52871 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab0EPG1J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 02:27:09 -0400
Received: by gwaa20 with SMTP id a20so3714gwa.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wBRsBI1B5UggwwTxKpD2IyjnhPjCrEE+MSUASk1BNuA=;
        b=J91gm/Nv5Sal5nQs1lGHKhZct2huUU7LAJcCQKJ5FrUnx430PKTUr5vVcw+nImv3QC
         iDHA5O23v3qdFo4t0p6+Sgry+BG+YMJli53DKPGE8Ns1hrSxX4lS/psx9W0YccRsHusJ
         BxvJJ3dq8iAB/uyTvoQpJgSY0P84Xi3SmVMC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l45c+CS17/sItarekzMYUWiQfN53wgBf95T2lfl77DuIbHgbIa/Z5Mya20Pai/eHYe
         YKcoP5MGTLC32iCznfWPrvucKbmdQlRujbjg27crWLI+gYs6sjNwSTnLc8f6up9yrIZU
         EFtZsQlniyMd7/cE2utVognauaxVnECyrYDDM=
Received: by 10.91.39.19 with SMTP id r19mr1583945agj.130.1273991225726; Sat, 
	15 May 2010 23:27:05 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Sat, 15 May 2010 23:27:05 -0700 (PDT)
In-Reply-To: <1273958566-7328-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147177>

Generally I use the format-patch command as:

git format-patch -M origin/master -o outgoing/

So, my patches will be in subdirectory outgoing.
But the regex rule in this patch won't be able to hide them.

What do u want to do in that case ?

- Pavan

On Sun, May 16, 2010 at 2:52 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> Change Git's own .gitignore so that patches produced with git
> format-patch don't show up as untracked.
>
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
> =A0.gitignore | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index dbf1b90..039d99c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -203,3 +203,4 @@
> =A0*.pdb
> =A0/Debug/
> =A0/Release/
> +[0-9][0-9][0-9][0-9]-*.patch
> --
> 1.7.1.84.gd92f8
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
