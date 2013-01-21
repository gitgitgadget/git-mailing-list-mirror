From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 09:37:06 +0100
Message-ID: <vpqwqv753v1.fsf@grenoble-inp.fr>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
	<vpq622s9jk1.fsf@grenoble-inp.fr>
	<7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:37:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCsu-0001TE-2s
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3AUIhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:37:17 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45533 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293Ab3AUIhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:37:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0L8b6N0026455
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 09:37:06 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxCsM-0007so-Sx; Mon, 21 Jan 2013 09:37:06 +0100
In-Reply-To: <CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
	(Piotr Krukowiecki's message of "Mon, 21 Jan 2013 09:09:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jan 2013 09:37:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0L8b6N0026455
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359362229.94228@OvXop1gTCeHUu3M7mhbi+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214093>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Do you mean "git add" will be disallowed without "." or ":/" argument?
> Or will this change in future and "git add" without argument will me
> "whole tree", same as ":/" ?

Let's talk conditional, not future, for now.

If the idea is to change the semantics without argument, it has to be
done carefully, and implies disallowing the argumentless version for a
while (or some better idea) to avoid confusion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
