From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 06 Jun 2016 18:17:38 +0200
Message-ID: <vpqwpm2fg0t.fsf@anie.imag.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:18:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xE1-000788-0I
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbcFFQR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:17:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36956 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbcFFQR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:17:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u56GHacM009099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 18:17:36 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56GHcUS003527;
	Mon, 6 Jun 2016 18:17:38 +0200
In-Reply-To: <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 6 Jun 2016 17:13:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 06 Jun 2016 18:17:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56GHacM009099
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465834657.35167@/r/+ZiN1w4zui8TrMyRrjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296526>

I'm waiting for the discussion "is this useful" to settle before I do a
final review, but I went quickly through the code and it seems OK.

Just to show I read till the end:

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> +test_expect_success 'check preallocated strbuf behavior in usual use cases' '
> +
> +	test-strbuf --preallocated_check_behavior

Useless blank line.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
