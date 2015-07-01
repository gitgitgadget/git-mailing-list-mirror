From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Wed, 01 Jul 2015 10:33:11 +0200
Message-ID: <vpqy4j0xooo.fsf@anie.imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqfv59ca4b.fsf@gitster.dls.corp.google.com>
	<vpqoajx2dka.fsf@anie.imag.fr>
	<950442683.78443.1435737112063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:33:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZADST-0001de-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 10:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbbGAId0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 04:33:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50465 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146AbbGAIdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 04:33:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t618XAck004167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jul 2015 10:33:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t618XB61010127;
	Wed, 1 Jul 2015 10:33:11 +0200
In-Reply-To: <950442683.78443.1435737112063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Wed, 1 Jul 2015 09:51:52 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 Jul 2015 10:33:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t618XAck004167
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436344392.02123@h0soxzYL8XoidNr9e7tBqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273142>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

>> I'd vote for keeping it simple and not having the copyright notice. Most
>> t/*.sh do not have one. The Git history + mailing-list archives are much
>> better than in-code comments to keep track of who wrote what.
>
>> Remi: any objection on removing it?
>
> Sorry for not having resent the patches myself, I currently have no
> Internet access, neither at work nor at home... Here's a try on my
> phone:
> I though the copyright line was necessary, but I did not know what
> to write after, and I forgot to ask, so I'm really happy with simply
> removing it. :)

OK, so Junio, you can just remove it.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
