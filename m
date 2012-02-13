From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 15:12:50 +0800
Message-ID: <CANYiYbFYmGNE09fAeHL_uk+0s+yBapTs4BeGch7iCtWR_v9LXQ@mail.gmail.com>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
	<CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
	<7vy5s7idxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?KOI8-R?B?QWxleGFuZGVyIFNob3BvdiAo4czFy9PBzsTf0iD7z9DP1yk=?= 
	<lists@kambanaria.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 08:12:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwq5p-0005Gm-CD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 08:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab2BMHMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 02:12:52 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35331 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab2BMHMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 02:12:51 -0500
Received: by ggnh1 with SMTP id h1so2185218ggn.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 23:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=i+C1/LtgVwICFzuBzpmyXKh+eoROjO9ixZ30PHGLDYY=;
        b=WRaoSyFoG0azeCogNKuXtQH8wRiuXbJV6s9nF0aH7xC5ibWG5A9hYb8DB45uOV7jqr
         rCd7I0LqzecdU2JxTjJv2Qp0aolNGGJPeoWQSlbAeXQ5Plf7oWRz8PKvW68UVFtRPajL
         AUExG5Wvi5IfxEDsfiqHurRzIOYUahzxWwIGI=
Received: by 10.236.139.193 with SMTP id c41mr17966448yhj.24.1329117170464;
 Sun, 12 Feb 2012 23:12:50 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Sun, 12 Feb 2012 23:12:50 -0800 (PST)
In-Reply-To: <7vy5s7idxb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190615>

2012/2/13 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Junio has a suggestion on how to contrib l10n for git, and you can s=
ee the
>> discussion here: http://article.gmane.org/gmane.comp.version-control=
=2Egit/189584.
>>
>> Seems that the suggested git-po repo has not been setup yet, so let =
me
>> have a try.
>>
>> 1. Repositiry git-po is hosted on GitHub: https://github.com/gotgit/=
git-po/
>>
>> 2. I made a commit on the maint branch with a initial version of 'po=
/git.pot'
>> =A0 =A0 https://github.com/gotgit/git-po/commit/4247a7a9d39e2a74ce1d=
58e5eb1f5e5d87977989

This commit is based on current maint branch. Since the translated po f=
iles will
first in 1.7.10, so the initial pot file should be generated from maste=
r branch.
The pot file from the master branch has 10 new messages than from the m=
aint
branch.

=46or clarity, I removed the maint and other branches except the master=
 branch,
and made a new commit.

> Somebody needs to eyeball this commit before anything else happens on=
 top
> of it, so that if there is a glaring mistake it can be caught before =
it
> spreads to affect work by translators for various languages.

So please check this commit with the updated pot file:
https://github.com/gotgit/git-po/commit/816049b7ec0e5f452c77a4c4e71e2cb=
40a0ccb45
Please note In this commit I removed one line from the 'po/.gitignore' =
file.

As a translater for Chinese, I also made a commit with the translated p=
o file
'po/zh_CN.po' in branch master-zh-cn (merged back to master branch).

>>
>> I have a question, which version of po should be maintained? master
>> branch or maint branch.
>
> I would say for this round the git-po repository and its pot file sho=
uld
> pick up whatever new translatable strings are added to 'master'.
>
> After this is merged in 1.7.10, we may want to maintain separate trac=
ks,
> but at this moment there is no point maintaining something mergeable =
to
> 1.7.9.x maintenance track.
>


--=20
Jiang Xin
