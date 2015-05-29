From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [BUG] potential error in parsing git checkout options?
Date: Fri, 29 May 2015 12:30:21 +0200 (CEST)
Message-ID: <854038739.144343.1432895421483.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <156258182.144342.1432895411512.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 12:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyHYP-0006Aj-9r
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbbE2KaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2015 06:30:13 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33194 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755514AbbE2KaL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 06:30:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3795927CD;
	Fri, 29 May 2015 12:30:08 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LC+MI8Ycd55N; Fri, 29 May 2015 12:30:08 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 265EF269F;
	Fri, 29 May 2015 12:30:08 +0200 (CEST)
In-Reply-To: <156258182.144342.1432895411512.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: potential error in parsing git checkout options?
Thread-Index: OLK+gIWQKb+u0IcDELAhgo7/nZmPhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270220>

Git version : 2.4.1.652.g8fd8657=20

When we run git checkout -babar, we would expect an error message like=20
"unknown switch 'a' " and we get "Switched to a new branch 'abar'". We=20
are not sure since we don't entirely understand the syntax -b <branch>=20
which is shown in the documentation, but as average users, we found it=20
a bit surprising.=20


Guillaume Pag=C3=A8s
