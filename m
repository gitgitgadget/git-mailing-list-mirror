From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 19:25:34 +0100
Message-ID: <vpq8v7dw4f5.fsf@grenoble-inp.fr>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
	<1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
	<51067353.2090006@drmicha.warpmail.net>
	<7v4ni1xjuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:26:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztPF-00012B-IY
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882Ab3A1SZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:25:47 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36636 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab3A1SZq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:25:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0SIPXH1006384
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jan 2013 19:25:33 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TztOh-0003hE-9S; Mon, 28 Jan 2013 19:25:35 +0100
In-Reply-To: <7v4ni1xjuc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2013 10:07:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jan 2013 19:25:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0SIPXH1006384
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360002337.28757@ANanMBvIglkqhMctSF2uZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214848>

Junio C Hamano <gitster@pobox.com> writes:

> I think "add -u && commit" vs "commit -a" you brought up is a good
> thing to mention, so let's do this.

I'm OK with your proposal. Let me know if you want me to resend.

>     The inconsistency of 'git add -u' and 'git add -A' are particularly

Nitpick: this should be "inconsistencies" (or "is particularly").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
