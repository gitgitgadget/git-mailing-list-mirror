From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a
 commit
Date: Mon, 1 Jun 2015 19:45:20 +0200 (CEST)
Message-ID: <563732680.250935.1433180720935.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
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
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:45:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTlj-0003Qe-5U
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbbFARoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 13:44:55 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:57550 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752935AbbFARoy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 13:44:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6B37526FF;
	Mon,  1 Jun 2015 19:44:50 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7u-uns8VmI7; Mon,  1 Jun 2015 19:44:50 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 580C7260A;
	Mon,  1 Jun 2015 19:44:50 +0200 (CEST)
In-Reply-To: <xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: mhmJ3+xjm3oLqsoleRA1BNX2RBABuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270446>

Junio C Hamano <gitster@pobox.com> writes:
> Is this sufficient?

> If you are going to do something in 2/2 that relies on the format of
> this line being correct (as opposed to "noop" or "#" that can have
> any garbage on the remainder of the line), wouldn't you want to at
> least check $sha1 is sensible?

That's also something that I was wondering, I wrote about it in the
0/2 part of this patch, I wanted some opinion about it.
If there is no opposition on the subject, I will have it ready for
the v3 of the patch.

Quote of that part of the 0/2 for more clarity:
Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
> For the 'drop' command, maybe instead of just doing the same thing as
> noop, checking if the SHA-1 that supposedly follow does exist could b=
e
> a good idea.
