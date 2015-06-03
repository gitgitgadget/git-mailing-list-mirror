From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv3 2/2] git rebase -i: warn about removed commits
Date: Wed, 03 Jun 2015 08:42:59 +0200
Message-ID: <vpqiob5fg24.fsf@anie.imag.fr>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<vpqzj4ignwe.fsf@anie.imag.fr>
	<133653833.39653.1433262736640.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:43:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Oe-0007sc-G1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbbFCGnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:43:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54721 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbFCGnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:43:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t536gw3J019320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 08:42:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t536gxSW026321;
	Wed, 3 Jun 2015 08:42:59 +0200
In-Reply-To: <133653833.39653.1433262736640.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 2 Jun 2015 18:32:16 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jun 2015 08:42:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t536gw3J019320
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433918579.21777@DVwAOrc+aC7FFePO7rwPBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270635>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Checking that the warning was correctly displayed like in the test for
> "warn" if I understood correctly. About that, is checking that the
> first line is "Warning: some commits may have been dropped
> accidentally." (like in the test for "warn") enough, or should I check
> that the commit displayed as removed is the correct one?

Ideally, you would check the list of commits displayed too. If the
commits sha1 are stable, this should be easy to do. If it's too hard to
test, I'd say its not worth the trouble, but others may disagree.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
