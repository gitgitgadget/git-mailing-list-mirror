From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Mon, 8 Jun 2015 18:14:42 +0200 (CEST)
Message-ID: <1247043051.275297.1433780082550.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqk2ve9tfm.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 08 18:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zgk-0006iJ-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbbFHQOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:14:10 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:56803 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbbFHQOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 12:14:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EE4B44884F;
	Mon,  8 Jun 2015 18:14:06 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fLJw+htqRcg1; Mon,  8 Jun 2015 18:14:06 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D72E2487DB;
	Mon,  8 Jun 2015 18:14:06 +0200 (CEST)
In-Reply-To: <vpqk2ve9tfm.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: refactor address list process
Thread-Index: HqRnb4oZczYnnDKYHuphe0oPxnHO8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271062>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
> 
> > Simplify code by creating a function to transform list of email lists
> > (comma separated, with aliases ...)  into a simple list of valid email
> > addresses.
> 
> I would have found the series easier to read if this refactoring came
> earlier (and then PATCH 2/5 would fix the bug as a positive side effect
> of the refactoring). I think it's too late to change this, though.

Why is it to late? I can still change it if necessary.

> >  I'm not sure about the name of the function...
> 
> process_address_list() sounds good to me.

Ok nice. :)

Thanks
