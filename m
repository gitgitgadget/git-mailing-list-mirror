From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Branches & directories
Date: Mon, 03 Oct 2011 09:41:29 +0200
Message-ID: <vpqmxdiikt2.fsf@bauges.imag.fr>
References: <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com>
	<CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
	<20111003030723.GA24523@sigill.intra.peff.net>
	<CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
	<vpqaa9ijzt4.fsf@bauges.imag.fr>
	<20111003073456.GA10054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAd9p-0002St-Et
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab1JCHlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:41:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44153 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab1JCHln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:41:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p937d1YO014888
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2011 09:39:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RAd9V-0003Eu-Tx; Mon, 03 Oct 2011 09:41:29 +0200
In-Reply-To: <20111003073456.GA10054@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 3 Oct 2011 03:34:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 03 Oct 2011 09:39:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p937d1YO014888
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318232348.47071@bpktOeDNNEbrNeAxp3/OEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182633>

Jeff King <peff@peff.net> writes:

> Speaking of which; does anybody know of a git-aware ccache-like tool?
> We already have a nice index of the sha1 of each file in the repository
> (along with a stat cache showing us whether it's up-to-date or not).
> Something like ccache could avoid even looking in the C files at all if
> it relied on git's index.

It would be a bit harder than that I think. IIRC, ccache hashes the
preprocessed file, hence it will notice if a .h file changed, even if
it's outside the project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
