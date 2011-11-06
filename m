From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] pull: introduce a pull.rebase option to enable --rebase
Date: Sun, 06 Nov 2011 20:53:17 +0100
Message-ID: <4EB6E5AD.7060605@kdbg.org>
References: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org> <1320573010-12296-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 20:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN8mV-0007jY-6y
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 20:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab1KFTxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 14:53:22 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:47867 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751581Ab1KFTxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 14:53:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 62E182C4009;
	Sun,  6 Nov 2011 20:53:30 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AC5E919F5CE;
	Sun,  6 Nov 2011 20:53:17 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <1320573010-12296-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184929>

Am 06.11.2011 10:50, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5a841da..b2d7d92 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -677,7 +677,9 @@ branch.<name>.mergeoptions::
>  branch.<name>.rebase::
>  	When true, rebase the branch <name> on top of the fetched branch,
>  	instead of merging the default branch from the default remote when
> -	"git pull" is run.
> +	"git pull" is run. See "pull.rebase" for doing this in a non
> +	branch-specific manner.
> +
>  	*NOTE*: this is a possibly dangerous operation; do *not* use
>  	it unless you understand the implications (see linkgit:git-rebase[1=
]
>  	for details).

When you continue an indented item in a separate paragraph, then you
must not use an empty line, but have line with '+' and un-indented
continuation paragraphs. See examples in this file.

-- Hannes
