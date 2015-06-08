From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Mon, 8 Jun 2015 19:36:31 +0200 (CEST)
Message-ID: <1154859541.277990.1433784991860.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqk2ve9tfm.fsf@anie.imag.fr> <1247043051.275297.1433780082550.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqmw0a2mst.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 08 19:36:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20xv-0007a8-K7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbbFHRf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:35:59 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55277 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082AbbFHRf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 13:35:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A035F2870;
	Mon,  8 Jun 2015 19:35:55 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2meEBNLnZFIT; Mon,  8 Jun 2015 19:35:55 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8FD0B2826;
	Mon,  8 Jun 2015 19:35:55 +0200 (CEST)
In-Reply-To: <vpqmw0a2mst.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: refactor address list process
Thread-Index: +soh1i2cnphM0HOiWnSGaZDLrpfzhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271093>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> To me, the series is ready now, and I don't think re-rolling it would be
> a good time investment. Plus, I spent time reviewing this series and
> with my proposal I'd need to review a relatively different one.

Ok, thanks.
