From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Tue, 2 Jun 2015 11:23:48 +0200 (CEST)
Message-ID: <991806665.10972.1433237028896.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpq7frmy5nl.fsf@anie.imag.fr>
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
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 11:24:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YziQW-0000Nn-8h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 11:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbbFBJXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 05:23:54 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:43721 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756289AbbFBJXv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 05:23:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8A9D027FB;
	Tue,  2 Jun 2015 11:23:47 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0VtfUkQU1fL; Tue,  2 Jun 2015 11:23:47 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7917E2793;
	Tue,  2 Jun 2015 11:23:47 +0200 (CEST)
In-Reply-To: <vpq7frmy5nl.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: QepsBckq7Z2fuf/BD4oAiQH5NJDOxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270510>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>=20
> > Check if commits were removed (i.e. a line was deleted) and print
> > warnings or abort git rebase according to the value of the
> > configuration variable rebase.checkLevel.
>=20
> checkLevel does not seem to be a good name, because it doesn't say
> _what_ is checked. I don't have really good proposal in mind, but may=
be
>=20
> rebase.todoListCheckLevel
> rebase.missinLinesCheckLevel
>=20
> ?

I agree that we could use a better name.

I'm thinking about
   > rebase.missingLinesCheckLevel
   or
   rebase.missingCommitsCheckLevel
but I am worried that these names are too long.
Maybe
   rebase.dropCheckLevel

I don't really have better propositions right now.

R=C3=A9mi
