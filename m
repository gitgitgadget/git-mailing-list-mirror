From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Tue, 2 Jun 2015 15:51:03 +0200 (CEST)
Message-ID: <829387582.31753.1433253063381.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com> <53678876.5326.1433230965582.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CAPig+cQF6irJqYFZ=2YSevjF+ySUn25udYMKSg+VzXP0p0-eAw@mail.gmail.com>
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
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzmay-0003QK-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 15:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759144AbbFBNvE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 09:51:04 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:51785 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753607AbbFBNvC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 09:51:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0CC813613;
	Tue,  2 Jun 2015 15:51:01 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x+WkbIS0BToG; Tue,  2 Jun 2015 15:51:00 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E75E22BAA;
	Tue,  2 Jun 2015 15:51:00 +0200 (CEST)
In-Reply-To: <CAPig+cQF6irJqYFZ=2YSevjF+ySUn25udYMKSg+VzXP0p0-eAw@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: 1iioG7i1h3MUxXzOCgXEWQ68fxqcWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270534>

Eric Sunshine <sunshine@sunshineco.com> writes:=20
> Although the underlying behavior of "ignore" may be the same as the=20
> default, you also want to check that higher-level machinery for=20
> recognizing the "ignore" option is working correctly, which is why=20
> checking "ignore" explicitly is a reasonable thing to do.=20

Noted, I'm adding a test for "ignore".=20

Thank you,=20

R=C3=A9mi=20
