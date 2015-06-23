From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a
 commit
Date: Tue, 23 Jun 2015 22:47:00 +0200 (CEST)
Message-ID: <460841845.733813.1435092420048.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com> <1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpq1th2p7ka.fsf@anie.imag.fr> <392249968.731834.1435087097209.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpq8ubamaz0.fsf@anie.imag.fr> <xmqqa8vqcg7h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:45:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7V4L-0001FF-RI
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933535AbbFWUpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 16:45:17 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:52369 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933503AbbFWUpG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:45:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 02D8B37DE;
	Tue, 23 Jun 2015 22:45:05 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fabXx5qy7034; Tue, 23 Jun 2015 22:45:04 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id BC2B6373E;
	Tue, 23 Jun 2015 22:45:03 +0200 (CEST)
In-Reply-To: <xmqqa8vqcg7h.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: O2xXfMcjJqAz0aPVXP876MBWO2EnqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272515>

Junio C Hamano <gitster@pobox.com> writes:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>=20
> > Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> wri=
tes:
> >
> >> I think that the indentation on its own is enough to avoid confusi=
on
> >>> test_rebase_end () {
> >>>         test_when_finished "git checkout master &&
> >>>                 git branch -D $1 &&
> >>>                 test_might_fail git rebase --abort" &&
> >>>         git checkout -b $1 master
> >>> }
> >> but your idea is fine as well, so I'm ok with either way.
> >
> > Read too quickly, it looks like a mis-indentation (I could laugh at=
 Eric
> > here, but I made the same confusion when reading the code at first)=
=2E By
> > "avoid the confusion" I mean "make it clear it's not a mis-indentat=
ion".
>=20
> Yes, that stray " fooled me as well.  If it were following your
> suggestion in the earlier message on this thread, i.e.
>=20
>         test_when_finished "
>                 ... &&
>                 ...
>         " &&
>         git checkout
>=20
> I wouldn't have to waste time commenting on it ;-)

I will do it this way then. ;)

Thanks,
R=C3=A9mi
