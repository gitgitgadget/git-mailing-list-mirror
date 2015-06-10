From: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 09:15:37 +0200 (CEST)
Message-ID: <1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqbngpl5zu.fsf@anie.imag.fr> <550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:14:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aDg-0003DV-Br
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbbFJHOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:14:35 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33896 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933186AbbFJHOe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 03:14:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7389627D0;
	Wed, 10 Jun 2015 09:14:33 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHcQSFhb64ti; Wed, 10 Jun 2015 09:14:33 +0200 (CEST)
Received: from zm-int-mbx2.grenet.fr (zm-int-mbx2.grenet.fr [130.190.242.141])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 61FAF27BC;
	Wed, 10 Jun 2015 09:14:33 +0200 (CEST)
In-Reply-To: <xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: simplify the add of new bisect terms
Thread-Index: 832BLxv7Zjrhg6qS/p7ZkN7vtw5mcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271261>

> That is very different from ENOENT, which is an expected error when
> you are not using a customized terms.

But in the current state, we are going to create bisect_terms even if
the bisection is in bad/good mode. Should we differentiate the erors
then ? and should we abort the bisection instead of doing it in
bad/good mode by default ?
