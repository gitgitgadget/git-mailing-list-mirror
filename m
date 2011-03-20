From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 9/9] branch: add --column
Date: Sun, 20 Mar 2011 21:52:36 +0200
Message-ID: <87oc557env.fsf@mithlond.arda>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
	<1300625873-18435-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 20:52:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Og9-0004AD-SZ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 20:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab1CTTwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 15:52:42 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:51458 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab1CTTwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 15:52:41 -0400
Received: from mithlond.arda (84.251.132.215) by kirsi1.inet.fi (8.5.133)
        id 4D072CA704827067; Sun, 20 Mar 2011 21:52:39 +0200
Received: from dtw by mithlond.arda with local (Exim 4.72)
	(envelope-from <tlikonen@iki.fi>)
	id 1Q1Og0-0005MP-Qn; Sun, 20 Mar 2011 21:52:36 +0200
In-Reply-To: <1300625873-18435-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 20
 Mar 2011 19:57:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169521>

* 2011-03-20 19:57 (+0700), Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy w=
rote:

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.=
txt
> index 9106d38..a7bf4a8 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt

> +--column[=3D<options>]::
> +--no-column::
> +	Override column.ui settings. See linkgit:git-config.txt[1] for
> +	syntax. `--column` and `--no-column` without options are
> +	equivalent to 'always' and 'never' respectively. This option
> +	is only applicable if `git tag` is used to list tags without
> +	annotation lines.
> +
                               =20
I admit that I have not been following the development of this feature
but I'll confirm this anyway: Do you really mean to speak of "git tag"
in the man page of "git branch"?
