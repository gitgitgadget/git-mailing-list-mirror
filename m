From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 6/7] send-email: suppress leading and trailing
 whitespaces in addresses
Date: Wed, 10 Jun 2015 10:33:54 +0200 (CEST)
Message-ID: <1862589361.335676.1433925234231.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqr3pk9dv3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:33:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2bRq-00006j-9r
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 10:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbbFJIdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 04:33:13 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:53127 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751206AbbFJIdL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 04:33:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 357F827E5;
	Wed, 10 Jun 2015 10:33:09 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TffR06PGNUbc; Wed, 10 Jun 2015 10:33:09 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2273D2792;
	Wed, 10 Jun 2015 10:33:09 +0200 (CEST)
In-Reply-To: <vpqr3pk9dv3.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: suppress leading and trailing whitespaces in addresses
Thread-Index: 2zdpzS6ZLgynuyxFMbMpKURj37nVdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271277>

> Nothing serious, but you did something weird while sending. This message
> does not have a References: or an In-reply-to: field, so it breaks
> threading. See how it's displayed on
> 
>   http://thread.gmane.org/gmane.comp.version-control.git

Yes, send-email was aborted after 5/7, I realized and retry
sending 6/7 and 7/7 but I didn't noticed that. I'll be
careful next time, thanks.
