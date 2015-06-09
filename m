From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] status: differentiate interactive from non-interactive rebases
Date: Tue, 09 Jun 2015 17:02:17 +0200
Message-ID: <vpqbngp3oxy.fsf@anie.imag.fr>
References: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433860962-13222-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 17:02:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2L2t-0006SE-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 17:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbbFIPC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 11:02:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57099 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbbFIPCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 11:02:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t59F2FNY012907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 17:02:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t59F2HQ2032726;
	Tue, 9 Jun 2015 17:02:17 +0200
In-Reply-To: <1433860962-13222-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Tue, 9 Jun 2015
 16:42:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 17:02:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t59F2FNY012907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434466938.23231@ev3RDJhHqIlIsMo9ixxhsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271191>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> Signed-off-by: Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-in=
p.fr>
> ---
>  t/t7512-status-help.sh | 28 ++++++++++++++--------------
>  wt-status.c            |  5 ++++-

Are there any change since the last version? Please, help reviewers by
anticipating this question and versionning your patches ([PATCH v3 2/4]
in the subject, git send-email -v3 does this for you).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
