From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 2/3] git rebase -i: warn about removed commits
Date: Wed, 10 Jun 2015 17:59:29 +0200 (CEST)
Message-ID: <868859991.334769.1433951969453.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433931035-20011-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpqvbevty1f.fsf@anie.imag.fr> <1634653813.334490.1433951239962.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqlhfr4kxn.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 10 17:58:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iP4-0000b7-He
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933394AbbFJP6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 11:58:51 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:60771 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966402AbbFJP6p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:58:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C23513621;
	Wed, 10 Jun 2015 17:58:43 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t6upYwNKYujX; Wed, 10 Jun 2015 17:58:43 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AFCD3361A;
	Wed, 10 Jun 2015 17:58:43 +0200 (CEST)
In-Reply-To: <vpqlhfr4kxn.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: qdsXoB/fw1bWGG1uoN8nqht0qMwuRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271313>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> write=
s:
>=20
> > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> >> > +                        warn_file "$todo".miss
> >>
> >> I would find it more elegant with less intermediate files, like
> >>
> >> git rev-list $opt <"$todo".miss | while read -r line
> >> do
> >>         warn " - $line"
> >> done
> >
> > I am not really sure since I also use warn_file to display the bad
> > commands and SHA-1 in 3/3.
>=20
> I noticed this later indeed. But had the function been eg. warn_pipe,
> you could have written
>=20
> git rev-list $opt <"$todo".miss | warn_pipe

Interesting, I'll try to do something similar to this.

R=C3=A9mi
