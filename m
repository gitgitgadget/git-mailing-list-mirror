From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Sun, 7 Jun 2015 01:45:34 +0200 (CEST)
Message-ID: <876005532.186122.1433634334986.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cR=xKy-WSZSRgC8UbEbyY+=t7yDZo3O-2GquWXWWPrGVA@mail.gmail.com> <1105867541.79324.1433362150592.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 01:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1NmA-0003PG-Ug
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 01:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbbFFXpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2015 19:45:14 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46757 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752652AbbFFXpM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 6 Jun 2015 19:45:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B04B348821;
	Sun,  7 Jun 2015 01:45:09 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3l63iTcme6z; Sun,  7 Jun 2015 01:45:09 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8EADD48814;
	Sun,  7 Jun 2015 01:45:09 +0200 (CEST)
In-Reply-To: <1105867541.79324.1433362150592.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: zJk/N+s91ORNEvdEaM4sP14oBAFgdc+zw2kJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270955>

I'm going to try to change the die_abort in this patch by a die, so
that the user can use rebase --edit-todo afterward. This way, adding
the checking on the SHA-1 for the 'drop' command (discussed in 1/2)
(and also maybe the other commands requiring a correct SHA-1
corresponding to a commit) to the 2/2 part would make a bit more
sense. Though I still see some other issues with this, I agree that it
makes more sense in 2/2 rather than in 1/2 (some more checking in a
future patch would be a good idea).

(So far I've tried rather quickly, but it doesn't seem as easy as I
originally though, working on it though)

R=C3=A9mi
