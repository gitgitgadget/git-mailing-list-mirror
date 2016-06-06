From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] doc: clearer rule about formatting literals
Date: Mon, 06 Jun 2016 15:36:22 +0200
Message-ID: <vpqmvmyo2w9.fsf@anie.imag.fr>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-2-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:36:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9ui2-00031W-EW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbcFFNgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 09:36:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59357 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbcFFNgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 09:36:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u56DaLou011238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 15:36:21 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56DaM2S031751;
	Mon, 6 Jun 2016 15:36:22 +0200
In-Reply-To: <20160606100905.23006-2-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Mon, 6 Jun 2016 12:09:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 06 Jun 2016 15:36:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56DaLou011238
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465824983.89043@zQef/Q/T2LqAhRTwtxbfgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296508>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -526,12 +526,13 @@ Writing Documentation:
>   modifying paragraphs or option/command explanations that contain options
>   or commands:
>  
> - Literal examples (e.g. use of command-line options, command names, and
> - configuration variables) are typeset in monospace, and if you can use
> - `backticks around word phrases`, do so.
> + Literal examples (e.g. use of command-line options, command names,
> + configuration and environment variables) must be typeset in monospace (i.e.
> + wrapped with backticks):
>     `--pretty=oneline`
>     `git rev-list`
>     `remote.pushDefault`
> +   `GIT_DIR`

Don't you want `$GIT_DIR` here?

>   Word phrases enclosed in `backtick characters` are rendered literally
>   and will not be further expanded. The use of `backticks` to achieve the

It might make sense to mention that they will appear bold in manpages
too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
