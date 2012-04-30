From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Glossary for bootstrapping Git translations
Date: Mon, 30 Apr 2012 17:47:11 +0200
Message-ID: <CACBZZX4cBO7QJ7JHTpiw0E61pb=Z176cVkjteY=qb+PGBr=jsg@mail.gmail.com>
References: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
 <CANYiYbH7g5JRvEQ_b9sEP72zR+yrAj+cQbemi_nsFTSa+QRgEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Hinrik_=C3=96rn_Sigur=C3=B0sson?= <hinrik.sig@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 17:47:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsp8-0003CO-9M
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab2D3Prd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:47:33 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48440 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab2D3Prd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 11:47:33 -0400
Received: by eekc41 with SMTP id c41so739913eek.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8FdmoTYPO6gWWU9T+KMFsl7w2Rz/5FxGeanPqp9Flyg=;
        b=zgINaz4jK/F8tham4Sl0xbtf4AaW+vKO7NmIi1awHD6D/CjTOTAC2/W5VsljbrxBpJ
         WxoPmhqZqTA0xpcc5FTfCmnNdjLlvLc5ucuhsQJNT7Nw12WyvuCJ+PT54QPEcdBT9rky
         GgUZVjYHDtORbriEkDHCkE0/l19TZu9vBOF8NiOUXUwKLDZmvGdzY7P8VaLidkY412Kb
         IqnhjAovu5e8Wonhx+ga8vXlf/e1kzAKryvfRCZsqUhTS0od8qLkO7m8pKWCybOeejlc
         1RVrYAS0/czJvdyqArEO40zRNLh3JDGfDi4j8LYFA3TXdHwcbe9ktMRkoWOiBeo3Yn5x
         S3sw==
Received: by 10.14.207.9 with SMTP id m9mr433565eeo.52.1335800851408; Mon, 30
 Apr 2012 08:47:31 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Mon, 30 Apr 2012 08:47:11 -0700 (PDT)
In-Reply-To: <CANYiYbH7g5JRvEQ_b9sEP72zR+yrAj+cQbemi_nsFTSa+QRgEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196572>

On Mon, Apr 30, 2012 at 15:17, Jiang Xin <worldhello.net@gmail.com> wro=
te:
> 2012/4/30 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
>> Over the weekend I started the Icelandic translation of Git beyond t=
he
>> current test messages that are there in po/is.po already.
>
> I just created new branch 'maint' in git-po repository on GitHub,
> and generated two different 'git.pot' files yesterday. The
> recommended workflow for a new language:
>
> 1. After fork the git-l10n/git-po on GitHub, checkout the 'maint'
> =C2=A0 =C2=A0branch, or create a new tracking branch based on it.
>
> 2. Create your initial XX.po file, tranlate, commit, and push to
> =C2=A0 =C2=A0your own fork.
>
> 3. Send a GitHub pull request to the 'maint' branch of git-l10n/git-p=
o.
>
> 4. The l10n coordinator merge your commit to the 'maint' branch,
> =C2=A0 =C2=A0so your translation may appear in git next maintainence =
version,
> =C2=A0 =C2=A0i. e. 1.7.10.1.
>
> 5. The l10n coordinator will do a second merge, so new commit in
> =C2=A0 =C2=A0'maint' branch will merge back to the 'master' branch.
>
> 6. Update your XX.po in 'master' branch, translate, commit, and
> =C2=A0 =C2=A0 send new pull request.
>
> 7. The l10n coordinator will merge your updates to 'master' branch,
> =C2=A0 =C2=A0 and your translations will come with git 1.7.11.
>
> L10N team leaders may already noticed these changes, as I @ all
> team leaders in the commit comments.

Thanks for the workflow advice. I'll be funneling translations though
you once I'm happy enough with is.po. For now I'm still mulling over
how to translate a few remaining things.
