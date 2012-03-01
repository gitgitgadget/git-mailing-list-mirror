From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Update l10n guide
Date: Thu, 1 Mar 2012 12:05:19 +0800
Message-ID: <CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
	<7v1upew6d0.fsf@alter.siamese.dyndns.org>
	<7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 05:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2xGh-0002kk-4f
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 05:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab2CAEFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 23:05:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59740 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2CAEFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 23:05:20 -0500
Received: by yenl12 with SMTP id l12so57459yen.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 20:05:20 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.181.193 as permitted sender) client-ip=10.236.181.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.181.193 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.181.193])
        by 10.236.181.193 with SMTP id l41mr4575893yhm.38.1330574720254 (num_hops = 1);
        Wed, 29 Feb 2012 20:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yXo2hDPKaxOoSwE03ZcdMncFOc2tzcOBTo6ZTYR0I2E=;
        b=lZRgx0qxbBV77ZfvP/IhFogU88TluBxGm0C1hWRAJEsH87wUmLtiZ1VlggJI4ZcnOe
         AcBE8b3IVNJ450I4ReS+/N1VuUQhgzU8ERWTT7a2i5l/+jiUfLM+A6xOshlHyOtw1JH/
         t81x7EVYJnP8PzE8llqjFryIbnSkGSyyqWqwo=
Received: by 10.236.181.193 with SMTP id l41mr3592705yhm.38.1330574720003;
 Wed, 29 Feb 2012 20:05:20 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Wed, 29 Feb 2012 20:05:19 -0800 (PST)
In-Reply-To: <7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191892>

2012/2/29 Junio C Hamano <gitster@pobox.com>:

> @@ -1,33 +1,78 @@
> +The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmail=
=2Ecom>,
> +coordinates our localization effort in his repository:
> +
> + =A0 =A0 =A0 =A0https://github.com/gotgit/git-po/

I create a new dedicated team, named git-l10n, and transfer this repo t=
o the
new place: https://github.com/git-l10n/git-po/ for the following reason=
s:

 - git-po is a long-term repo, so has a dedicated, stabilized URL is be=
tter.
   The repo URL may not change if l10n coordinator change.

 - git-l10n is a github organization account, and has a dedicated owner=
s
   group, who can assign new l10n coordinator.

 - Owners group of git-l10n organization will not receive pull requests=
 to
   git-po. I add gister, avar to the owners team.

 - Members of the git-l10n-coordinators team of git-l10n organization
   will receive pull requests.

 - Some Chinese guys used to send pull request to gotgit/git-po, so you
   can find some closed pull requests written in Chinese. It won't happ=
en
   after the repo transfer to git-l10n/git-po.

> +As a contributor for a language XX, you would fork this repository,

As a contributor for a language XX, you should first check TEAMS file i=
n
this directory to see whether a dedicated repository for your language =
XX
exists. Fork the dedicated repository and start to work if it exists.

If you are the first contributor for the language XX, please fork this
repository,

> +prepare and/or update the translated message file po/XX.po (describe=
d
> +later), and ask the l10n coordinator to pull your work.

Shall we remind the contributors for l10n to write commit log in Englis=
h,
but not language XX? It's a common mistake for translators.

> diff --git a/po/TEAMS b/po/TEAMS
> new file mode 100644
> index 0000000..8ee6199
> --- /dev/null
> +++ b/po/TEAMS
> @@ -0,0 +1,10 @@
> +Core Git translation language teams
> +(please keep the list sorted alphabetically on language field)
> +
> +Language: =A0 =A0 =A0is (Icelandic)
> +Leader: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=C6var Arnfj=F6r=F0 Bjarmason=
 <avarab@gmail.com>
> +

I think we should add the URL of the dedicated repository for language =
XX here.
Example:

Language: =A0 =A0 =A0zh_CN (Simplified Chinese)
Leader: =A0 =A0 =A0 =A0 =A0 Jiang Xin <worldhello.net@gmail.com>
Homepage:     https://github.com/jiangxin/git-po-zh_CN/


> +Members: =A0 =A0 =A0 Yichao Yu <yyc1992@gmail.com>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Riku <lu.riku@gmail.com>

Contributors and members can add to the header of the XX.po file.
Add here may cause the TEAMS file grows rapidly.


--=20
Jiang Xin
