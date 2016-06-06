From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] doc: change environment variables format
Date: Mon, 06 Jun 2016 16:08:31 +0200
Message-ID: <vpqinxmmmu8.fsf@anie.imag.fr>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-3-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:09:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9vD4-0000hj-R1
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 16:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbcFFOIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 10:08:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42050 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbcFFOIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 10:08:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56E8U49001421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 16:08:30 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56E8Vn3000320;
	Mon, 6 Jun 2016 16:08:31 +0200
In-Reply-To: <20160606100905.23006-3-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Mon, 6 Jun 2016 12:09:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 16:08:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56E8U49001421
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465826911.48701@268RdxASNXk6b5FnKgsdpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296512>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> As a first step, this change GIT_* variables that where in
> italic style to monospace font according to the guideline. It was obtained
> with
>
> 	perl -pi -e "s/\'(GIT_.*?)\'/\`\1\`/g" *.txt

Good.

I'd add to the commit message that one of the goals of this patch is to
make the use "mostly consistent" with CodingGuidelines, so that people
writting new doc by mimicking the existing one later get a good
probability of getting it right even if they didn't read
CodingGuidelines.

> @@ -619,7 +619,7 @@ core.excludesFile::
>  core.askPass::
>  	Some commands (e.g. svn and http interfaces) that interactively
>  	ask for a password can be told to use an external program given
> -	via the value of this variable. Can be overridden by the 'GIT_ASKPASS'
> +	via the value of this variable. Can be overridden by the `GIT_ASKPASS`
>  	environment variable. If not set, fall back to the value of the
>  	'SSH_ASKPASS' environment variable or, failing that, a simple password
>  	prompt. The external program shall be given a suitable prompt as

We now have a minor inconsistency between GIT_ASKPASS and SSH_ASKPASS.

You can catch this one and a handful others with

  git grep "'[A-Z_]*' environment"

(That would be a separate patch)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
