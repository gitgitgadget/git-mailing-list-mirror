From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5] upload-pack.c: use parse-options API
Date: Mon, 30 May 2016 17:06:31 +0200
Message-ID: <vpqa8j77fgo.fsf@anie.imag.fr>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com,
	peff@peff.net, sunshine@sunshineco.com
To: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 17:06:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7OmH-0008LB-5Q
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 17:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbcE3PGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 11:06:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49651 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754874AbcE3PGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 11:06:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4UF6TPr026879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 17:06:29 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UF6VpD006902;
	Mon, 30 May 2016 17:06:31 +0200
In-Reply-To: <20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
	(Antoine Queru's message of "Mon, 30 May 2016 16:53:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 30 May 2016 17:06:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UF6TPr026879
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465225590.53344@tB1chUJ096U5SkxW5KGUtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295904>

Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:

> From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>

[ Insert here the sentence I've been repeating a lot lately about this
  useless From ;-) ]

> Documentation/git-upload-pack.txt | 16 +++++++++--
>  upload-pack.c                     | 59 +++++++++++++++++----------------------
>  2 files changed, 38 insertions(+), 37 deletions(-)

The patch contains a few whitespace errors:

Documentation/git-upload-pack.txt:41: space before tab in indent.
+       immediately. This fits with the HTTP GET request model, where
Documentation/git-upload-pack.txt:42: space before tab in indent.
+       no request content is received but a response must be produced.
upload-pack.c:846: trailing whitespace.
+       

You should notice them immediately if you use "git add -p" (big red
warning in the patch hunk), and you can see all of them with "git diff
--check" or "git show --check".

Not sure if it deserves a reroll. Junio?

Other than that, the patch is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
