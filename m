From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v2 2/2] git-am: add am.threeWay config variable
Date: Tue, 02 Jun 2015 16:13:13 +0200
Message-ID: <vpqmw0ijj0m.fsf@anie.imag.fr>
References: <1433251472-29460-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzmwW-00023V-73
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758926AbbFBONT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:13:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53982 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756284AbbFBONS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:13:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t52EDCiL020712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2015 16:13:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t52EDDXe013214;
	Tue, 2 Jun 2015 16:13:13 +0200
In-Reply-To: <1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 2 Jun 2015 15:24:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Jun 2015 16:13:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t52EDCiL020712
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433859194.17048@rkYKjlhhDMEQ/zDoU9mIOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270538>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Add the am.threeWay configuration variable to use the -3 or --3way
> option of git am by default. When am.threeway is set and not desired
> for a specific git am command, the --no-3way option can be used to
> override it.
>
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>  Documentation/config.txt |  7 +++++++
>  Documentation/git-am.txt |  6 ++++--
>  git-am.sh                |  7 +++++++
>  t/t4150-am.sh            | 19 +++++++++++++++++++
>  4 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d44bc85..8e42752 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -769,6 +769,13 @@ am.keepcr::
>  	by giving '--no-keep-cr' from the command line.
>  	See linkgit:git-am[1], linkgit:git-mailsplit[1].
>  
> +am.threeWay::
> +	If true, git-am will fall back on 3-way merge when the patch

git-am should be spelled `git am` or 'git am' (the second is used a lot
in git-am.txt, but Documentation/CodingGuidelines says:

 Literal examples (e.g. use of command-line options, command names, and
 configuration variables) are typeset in monospace, and if you can use
 `backticks around word phrases`, do so.
   `--pretty=oneline`
   `git rev-list`
   `remote.pushDefault`
) so I guess the first is the right way to typeset it.

FYI, the syntax git-am actually existed in the past (before git 1.6).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
