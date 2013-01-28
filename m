From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 11:56:38 +0100
Message-ID: <vpqy5fd4luh.fsf@grenoble-inp.fr>
References: <51065540.1090007@renemoser.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Rene Moser <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzmOt-0008AR-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 11:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab3A1K4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 05:56:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44352 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729Ab3A1K4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 05:56:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0SAucNY015551
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jan 2013 11:56:38 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TzmOF-0002cj-4E; Mon, 28 Jan 2013 11:56:39 +0100
In-Reply-To: <51065540.1090007@renemoser.net> (Rene Moser's message of "Mon,
	28 Jan 2013 11:38:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Jan 2013 11:56:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0SAucNY015551
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359975402.50491@3m/HRRV5ULLDcXDThY34/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214829>

Rene Moser <mail@renemoser.net> writes:

> Hi
>
> Found a little issue in git version 1.7.9.5 if a file named "-", causing
> "git commit" to read from stdin.

Can't reproduce with Git version 1.8.1.1.440.g1d329bd, this probably has
been fixed already.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
