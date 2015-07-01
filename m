From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v7 07/10] send-email: reduce dependencies impact on
 parse_address_line
Date: Wed, 1 Jul 2015 09:51:52 +0200 (CEST)
Message-ID: <950442683.78443.1435737112063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr> <1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr> <xmqqfv59ca4b.fsf@gitster.dls.corp.google.com> <vpqoajx2dka.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 01 09:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAClj-0006ka-CC
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 09:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbbGAHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 03:49:15 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:36533 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbbGAHtN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2015 03:49:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 416258EBE;
	Wed,  1 Jul 2015 09:49:11 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4oR8XeswhXvR; Wed,  1 Jul 2015 09:49:11 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2FF9E84AB;
	Wed,  1 Jul 2015 09:49:11 +0200 (CEST)
In-Reply-To: <vpqoajx2dka.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependencies impact on parse_address_line
Thread-Index: YvID0Jsds+TD3HsHPPQ7AhdZ3zTkJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273135>

> I'd vote for keeping it simple and not having the copyright notice. Most
> t/*.sh do not have one. The Git history + mailing-list archives are much
> better than in-code comments to keep track of who wrote what.

> Remi: any objection on removing it?

Sorry for not having resent the patches myself, I currently have no
Internet access, neither at work nor at home... Here's a try on my
phone:
I though the copyright line was necessary, but I did not know what
to write after, and I forgot to ask, so I'm really happy with simply
removing it. :)

Thanks!
