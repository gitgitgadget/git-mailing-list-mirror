From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Wed, 3 Jun 2015 22:09:10 +0200 (CEST)
Message-ID: <1105867541.79324.1433362150592.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cR=xKy-WSZSRgC8UbEbyY+=t7yDZo3O-2GquWXWWPrGVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:09:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0EyM-0003Zl-ET
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 22:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbbFCUJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 16:09:06 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:48763 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872AbbFCUJE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 16:09:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8D23048853;
	Wed,  3 Jun 2015 22:09:01 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tkn0zk1pk6GL; Wed,  3 Jun 2015 22:09:01 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 712DB4863D;
	Wed,  3 Jun 2015 22:09:01 +0200 (CEST)
In-Reply-To: <CAPig+cR=xKy-WSZSRgC8UbEbyY+=t7yDZo3O-2GquWXWWPrGVA@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: zJk/N+s91ORNEvdEaM4sP14oBAFgdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270732>

Eric Sunshine <sunshine@sunshineco.com> writes:

> > +test_expect_success 'rebase -i respects rebase.missingCommitsCheck=
=3Dignore' '
> > +       test_config rebase.missingCommitsCheck ignore &&
> > +       test_when_finished "git checkout master &&
> > +               git branch -D tmp2" &&
>=20
> Strange indentation.

Considering that 'git branch -D tmp2' is a part of test_when_finished,
I wasn't sure of how it was supposed to be indented, so I did it this
way to show that it was still within test_when_finished and not a
separate command.
> 	test_when_finished "git checkout master &&
> 	git branch -D tmp2" &&
Doesn't seem as clear, especially if you quickly read the lines.

=46or now, I have removed the tab.
Also the other points have been corrected.

Thank you,
R=C3=A9mi
