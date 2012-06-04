From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv7 2/4] t7512-status-help.sh: better advices for git status
Date: Mon, 04 Jun 2012 23:02:04 +0200
Message-ID: <vpq8vg2n643.fsf@bauges.imag.fr>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338830399-31504-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbePs-0000e3-HB
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab2FDVCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 17:02:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41373 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab2FDVCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 17:02:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54KrN5n007541
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 22:53:23 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbePd-00012R-Bt; Mon, 04 Jun 2012 23:02:05 +0200
In-Reply-To: <1338830399-31504-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Mon, 4 Jun 2012 19:19:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 22:53:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54KrN5n007541
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339448005.15322@K/gRpzJyWf8SXrcZvs9Jgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199188>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +test_expect_success 'status when conflicts resolved before commit' '
> +	test_when_finished "
> +		git commit -m "end_merge" &&

The " are respectively closing quote for the one on the line before, and
opening quote. Avoid nesting quotes, avoid quotes ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
