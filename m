From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/3] doc: more consistency in environment variables format
Date: Wed, 08 Jun 2016 08:26:42 +0200
Message-ID: <vpqk2i02o2l.fsf@anie.imag.fr>
References: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
	<20160607223507.18061-1-tom.russello@grenoble-inp.org>
	<20160607223507.18061-4-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	gitster@pobox.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 08:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAWx3-0003Rk-TK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 08:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161737AbcFHG0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 02:26:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50896 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbcFHG0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 02:26:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u586QgxF029892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jun 2016 08:26:42 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u586Qg9I003907;
	Wed, 8 Jun 2016 08:26:42 +0200
In-Reply-To: <20160607223507.18061-4-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Wed, 8 Jun 2016 00:35:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 08 Jun 2016 08:26:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u586QgxF029892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465972003.08699@7ugFwgh6sT00XiUogz7AaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296757>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> Wrap with backticks (monospaced font) unwrapped or single-quotes wrapped
> (italic type) environment variables which are followed by the word
> "environment". It was obtained with:
>
> perl -pi -e "s/\'?(\\\$?[0-9A-Z\_]+)\'?(?= environment ?)/\`\1\`/g" *.txt

I suggested a "grep" because I was afraid of having false positive, but
I carefully reviewed the patch and there is none.

Reading the context of the changes, it's clear that there are still a
lot of inconsistencies, but it's outside the topic of this patch.

Did you drop the "configuration variables" patch on purpose? Or will you
resend it separately?

Anyway, this new patch and the new version of the first two are

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
