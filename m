From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv3 2/2] git rebase -i: warn about removed commits
Date: Wed, 3 Jun 2015 09:33:20 +0200 (CEST)
Message-ID: <921357851.51732.1433316800782.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpqzj4ignwe.fsf@anie.imag.fr> <133653833.39653.1433262736640.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqiob5fg24.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 09:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z03Aw-00029g-KB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 09:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbbFCHdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 03:33:19 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59587 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052AbbFCHdR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 03:33:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 992E33616;
	Wed,  3 Jun 2015 09:33:14 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utewGl3N5VwC; Wed,  3 Jun 2015 09:33:14 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 801613614;
	Wed,  3 Jun 2015 09:33:14 +0200 (CEST)
In-Reply-To: <vpqiob5fg24.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: hUZlBYl74SCtaA8ImK/vDmsuO/TrKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270660>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Ideally, you would check the list of commits displayed too. If the
> commits sha1 are stable, this should be easy to do. If it's too hard =
to
> test, I'd say its not worth the trouble, but others may disagree.

Originally I chose not to check if the SHA-1 were corrects since
check_commits was called right after expand_todo_ids and I thought
that expand_todo_ids checked them, but from what I understand, it
doesn't seem to check if the SHA-1 are commits, I could be wrong
though.

R=C3=A9mi
