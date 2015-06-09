From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] status: factor two rebase-related messages together
Date: Tue, 09 Jun 2015 17:01:06 +0200
Message-ID: <vpqk2vd3ozx.fsf@anie.imag.fr>
References: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Tue Jun 09 17:01:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2L1l-0005M8-BG
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 17:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbbFIPBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 11:01:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57050 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbbFIPBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 11:01:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t59F14OI012458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 17:01:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t59F16cY032699;
	Tue, 9 Jun 2015 17:01:06 +0200
In-Reply-To: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Tue, 9 Jun 2015
 16:42:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 17:01:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t59F14OI012458
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434466867.9991@65VYr6VQFWfHcOv+kb6rNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271190>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> Signed-off-by: Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-in=
p.fr>
> ---
>  wt-status.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 33452f1..c239132 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1025,6 +1025,19 @@ static int split_commit_in_progress(struct wt_=
status *s)
>  	free(rebase_orig_head);
>  	return split_in_progress;
>  }
> +static void print_rebase_state(struct wt_status *s,

Please, skip a line between functions.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
