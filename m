From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: mention about remote.*.push when no
 refspec is given
Date: Wed, 06 Mar 2013 10:09:09 -0800
Message-ID: <7v8v60qu2i.fsf@alter.siamese.dyndns.org>
References: <1362573848-21793-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 19:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDIma-0005Ei-Io
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 19:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab3CFSJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 13:09:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3CFSJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 13:09:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEB55B24E;
	Wed,  6 Mar 2013 13:09:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IBCSBdqTAe00
	4OUYDyAoyEGzTMQ=; b=lUeHsJsEPZQot0DGTAFrSvl9bQAVlhL8U6cSVCWxpLHH
	1rWbKfqrHAPUy9sgtLjc0D8ffC86WWBG4mmtMafR5RQdKqE07A9qXeAhUcx5XxXn
	3zegxCp1ZJ8fxaGU9ZrzOzwnewyMKzYGfz52H1NE7cxrxaFvR3Mt1xI1p1W1SFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nfx0M0
	PKIlTLnZm+IBtexdDcBjquuG2wP1bhX5ozk/Iv6xU9W0tW/rkShcRep3CTY/YNQM
	icFz0L9PlvUnnphCHBVwhKpgMQoDf3Oq/l+R12nHCpXPEeWQTMotVkECRyfLC9oT
	6WIVKRoSdxuF9qSC+8bHfGADWD5zb3SFDZDaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D44BCB24D;
	Wed,  6 Mar 2013 13:09:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 106DDB24C; Wed,  6 Mar 2013
 13:09:10 -0500 (EST)
In-Reply-To: <1362573848-21793-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 6 Mar
 2013 19:44:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2256C60-8688-11E2-8709-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217533>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> remote.*.push is considered before push.default, but there's no
> mention about that, except a bit in the examples. The description
> of push.default does say something about this, but it would be easier
> to find out if it's described here.
>
> The first paragraph describing refspec format is moved down, so that
> the new first paragraph is about unspsecified refspec and the
> remaining paragraphs refspec format.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-push.txt | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 1398025..20bf2f5 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -33,13 +33,16 @@ OPTIONS[[OPTIONS]]
>  	of a remote (see the section <<REMOTES,REMOTES>> below).
> =20
>  <refspec>...::
> -	The format of a <refspec> parameter is an optional plus
> -	`+`, followed by the source ref <src>, followed
> -	by a colon `:`, followed by the destination ref <dst>.
> -	It is used to specify with what <src> object the <dst> ref
> -	in the remote repository is to be updated.  If not specified,
> -	the behavior of the command is controlled by the `push.default`
> -	configuration variable.
> +	Specify how how refs are pushed. If not specified and
> +	configuration variable `remote.<remote>.push` is set, the
> +	variable is used as default refspec. If not specified and the
> +	variable is not set, the behavior of the command is controlled
> +	by the `push.default` configuration variable.
> ++
> +The format of a <refspec> parameter is an optional plus `+`, followe=
d
> +by the source ref <src>, followed by a colon `:`, followed by the
> +destination ref <dst>.  It is used to specify with what <src> object
> +the <dst> ref in the remote repository is to be updated.

I agree that saying what it is, what it does or what it is for
upfront (i.e. "Specifies what are pushed") before how it is spelled
is an improvement.  I however think describing "If not specified"
here was a mistake, and you are making it worse by burying the
description of what happens when <refspec>... are missing in the
middle of the description for <refspec>...

I would rather see this done in the direction the attached "how
about doing it this way" patch illustrates.  The way how "where" and
"what" are determined when the command line does not specify is the
proparty of the entire command, not of an individual parameter.


 Documentation/git-push.txt | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 1398025..31dad19 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -23,6 +23,17 @@ You can make interesting things happen to a reposito=
ry
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
=20
+When the user does not specify where to push with
+<repository> argument, branch.*.remote configuration for the current
+branch is consulted to determine where to push.  If the
+configuration is missing, it defaults to 'origin'.
+
+When the user does not specify what to push with
+<refspec>... arguments or --all/--mirror/--tags options, the command f=
inds
+the default <refspec> by consulting remote.*.push configuration, and
+if it is not found, honors push.default configuration to decide what
+to push (See gitlink:git-config[1] for the meaning of push.default).
+
=20
 OPTIONS[[OPTIONS]]
 ------------------
@@ -33,13 +44,10 @@ OPTIONS[[OPTIONS]]
 	of a remote (see the section <<REMOTES,REMOTES>> below).
=20
 <refspec>...::
+	Specify what destination ref to update with what source object.
 	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source ref <src>, followed
+	`+`, followed by the source object <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
-	It is used to specify with what <src> object the <dst> ref
-	in the remote repository is to be updated.  If not specified,
-	the behavior of the command is controlled by the `push.default`
-	configuration variable.
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
@@ -66,10 +74,7 @@ the remote repository.
 The special refspec `:` (or `+:` to allow non-fast-forward updates)
 directs Git to push "matching" branches: for every branch that exists =
on
 the local side, the remote side is updated if a branch of the same nam=
e
-already exists on the remote side.  This is the default operation mode
-if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below) an=
d
-no `push.default` configuration variable is set.
+already exists on the remote side.
=20
 --all::
 	Instead of naming each ref to push, specifies that all
