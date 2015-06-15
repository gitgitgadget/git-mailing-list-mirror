From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] send-email quote issues
Date: Mon, 15 Jun 2015 15:52:04 +0200
Message-ID: <vpqd20xxenv.fsf@anie.imag.fr>
References: <330077615.505681.1434367014434.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqmw011a22.fsf@anie.imag.fr>
	<999870154.509851.1434373434414.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 15:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4UoU-0005br-FW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 15:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbbFONwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 09:52:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34869 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbbFONw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 09:52:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5FDq2cl020992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2015 15:52:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5FDq44b020178;
	Mon, 15 Jun 2015 15:52:04 +0200
In-Reply-To: <999870154.509851.1434373434414.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Mon, 15 Jun 2015 15:03:54 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jun 2015 15:52:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5FDq2cl020992
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434981125.10523@J3fLqeKeryydJJmiB/327Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271684>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Ok, but I don't know what fixed means in these particular cases.
> Actually the problem when we have a quote in a name is: Is this a
> delimiter or is this an ascii char?

To me, the answer should be: do whatever the RFC says in email headers.
I'd expect anything that works in the To: header to work in the --to
option of git send-email.

If I read correctly, this is address-list in RFC 2822.

Now, when the address list is invalid wrt the RFC, we can either reject
it or try to guess.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
