From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv3 1/2] git-rebase -i: add command "drop" to remove a
 commit
Date: Tue, 2 Jun 2015 16:32:27 +0200 (CEST)
Message-ID: <49957049.34247.1433255547565.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpqeglujisv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:32:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YznF4-00070p-Nf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbbFBOc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 10:32:29 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:33168 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759265AbbFBOc1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 10:32:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1B8553627;
	Tue,  2 Jun 2015 16:32:25 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QO9KVdQ7arE; Tue,  2 Jun 2015 16:32:25 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 025AC3623;
	Tue,  2 Jun 2015 16:32:25 +0200 (CEST)
In-Reply-To: <vpqeglujisv.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: dr9yr2+WgobL04GzV3sNMtjeMswgSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270550>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> : writes
> > +test_expect_success 'drop' '
>=20
> Please, be more descriptive in the first argument of
> test_expect_success. It's usually a good thing to say not only what t=
he
> test stresses but also what the expected behavior is.
>=20
> test_expect_success 'drop actually drops the lines' '

=46or this one I've based myself on the first argument of some other
tests that tests commands for git rebase -i :
> t3404-rebase-interactive.sh:240
> test_expect_success 'squash' '
> t3404-rebase-interactive.sh:679
> test_expect_success 'reword' '

R=C3=A9mi
