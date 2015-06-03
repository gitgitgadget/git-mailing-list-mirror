From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv4 2/2] git rebase -i: warn about removed commits
Date: Wed, 3 Jun 2015 19:53:26 +0200 (CEST)
Message-ID: <758899838.77480.1433354006473.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpq1thsbsko.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 19:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Cr0-0004QR-Qx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbbFCRxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 13:53:22 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42707 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753284AbbFCRxU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 13:53:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DD7853637;
	Wed,  3 Jun 2015 19:53:17 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7EG8pRw5RbO; Wed,  3 Jun 2015 19:53:17 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C3077362D;
	Wed,  3 Jun 2015 19:53:17 +0200 (CEST)
In-Reply-To: <vpq1thsbsko.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: ZuwCGCeNgksLFWkEnF1wZPrkaRsgeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270713>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> You're using $1 and $2 only to redirect input and output. I would fin=
d
> it more elegant to write todo_list_to_sha_list as a filter, and do th=
e
> redirection in the call site (to keep the option of using
> todo_list_to_sha_list in a pipe).

If I understood correctly, then the calling line would look like:
> todo_list_to_sha_list <"$todo".backup >"$todo".oldsha1
?

Should I do the same for the function warn_file ?
Meaning
> warn_file <"$todo".miss
instead of
> warn_file "$todo".miss

The other points mentioned have been corrected.

Thanks,
R=C3=A9mi
