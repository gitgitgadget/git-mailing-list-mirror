From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 21:04:39 +0200
Message-ID: <vpqehpl4qm0.fsf@bauges.imag.fr>
References: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 11 21:06:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9v2-0002mb-W3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875Ab2FKTEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 15:04:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59097 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2FKTEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:04:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BItZWc032114
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 20:55:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Se9uq-0003Mn-7E; Mon, 11 Jun 2012 21:04:40 +0200
In-Reply-To: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	(Javier Roucher-Iglesias's message of "Mon, 11 Jun 2012 20:44:54
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 20:55:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BItZWc032114
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340045737.86199@KdS5bg83mMiH1Zps0YqBMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199704>

> Subject: Re: [PATCH v3] add 'git credential' plumbing command

I guess you mean v2.

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> Changes in the version2 vs version1:

These should not go to the commit message, but below the --- below (and
before the diffstat).

> Adding to the next patch, version3:
> =B7 Tests files

If the todo-list isn't empty, then mark your patch as "RFC".

> --- /dev/null
> +++ b/Documentation/git-credential.txt
> @@ -0,0 +1,74 @@
> +git-credential(7)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-credential - Provides and store user credentials to git

Provides -> Provide

I'd remove the "to git" part.

Other than that, I prefer Jeff's version sent yesterday. Any reason not
to use it?

The command still isn't listed in "man git", aka Documentation/git.txt
(I already mentionned it)

> +	if (!strcmp(op, "fill")) {
> +		credential_fill(&c);
> +		if (c.username)
> +			printf("username=3D%s\n", c.username);
> +		if (c.password)
> +			printf("password=3D%s\n", c.password);
> +	}

See Jeff's remarks. It makes sense to output all fields here
(protocol, path, ...).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
