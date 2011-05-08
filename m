From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: [PATCH 36/48] i18n: git-stash "unknown option" message
Date: Sun, 8 May 2011 16:29:49 +0100
Message-ID: <20110508152948.GB11604@jakstys.lt>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
 <1304857280-14773-37-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 17:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ5vj-0004Kb-GU
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 17:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab1EHP3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 11:29:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55740 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1EHP3y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 11:29:54 -0400
Received: by wya21 with SMTP id 21so3364406wya.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MK4oB4Ebuz4QSZE8asDxVb0vm3lNAuEZvk2boN1hVaw=;
        b=tBBQtHJ8e9qywLXh6fY8t3LbNgUSUdL36QrFz4JQv4VBEE7PKVLFM0Ggzs3sf4kETc
         yW+/h8ZKBi8WCDrQV1zPIMcwBOIk43/rJ/qFofX37qd02Kt8efp0rG3bSbUyR97HwHMp
         ANetVMQQc4RCkpLo9KXnWu80raBjDr/R6vF6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qyDz8Iykfhsdg/tbbQ70soqQvCjIvCo5Rnff2ZEynbHCK5yZCnYiwTNtA43P+CIrW4
         yeuvBOZbIcqKi0dKrQbo1Rpb9JsqQmWHt79vSjsKTUe9oHBkAVbLj53hUHFszHZqyCBy
         +auHqnITcjgdsGx8vxMw/xEX/e4Ywj64pFKLM=
Received: by 10.227.176.72 with SMTP id bd8mr5957233wbb.72.1304868592476;
        Sun, 08 May 2011 08:29:52 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id o6sm3202518wbo.37.2011.05.08.08.29.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 08:29:51 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
	id 50B4BB078A; Sun,  8 May 2011 18:29:49 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <1304857280-14773-37-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173158>

On Sun, May 08, 2011 at 12:21:08PM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> Gettextize the "unknown option for 'stash save'" message that's shown
> on:
>=20
>     $ git stash save --blah-blah
>     error: unknown option for 'stash save': --blah-blah
>            To provide a message, use git stash save -- '--blah-blah'
>     Usage: git stash list [<options>]
>=20
> In a translation the second line should be aligned with the first
> one. I've added a TRANSLATORS comment to indicate this.

I think the commit message should be included to the message for the
translators. Like this:

>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>  git-stash.sh |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/git-stash.sh b/git-stash.sh
> index bf4868a..73fa2ce 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -152,8 +152,14 @@ save_stash () {
>  			break
>  			;;
>  		-*)
> -			echo "error: unknown option for 'stash save': $1"
> -			echo "       To provide a message, use git stash save -- '$1'"
> +			option=3D"$1"
> +			# TRANSLATORS: $option is an invalid option, like
> +			# `--blah-blah'. The 7 spaces at the beginning of the
> +			# second line correspond to "error: ". So you should line
> +			# up the second line with however many characters the
> +			# translation of "error: " takes in your language. In other
> +         # words, second line should be aligned with the first one.
> +			eval_gettext "$("error: unknown option for 'stash save': \$option
> +       To provide a message, use git stash save -- '\$option'")"; ec=
ho
>  			usage
>  			;;
>  		*)
> --=20
> 1.7.4.4

Motiejus
