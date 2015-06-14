From: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v2 4/7] bisect: add the terms old/new
Date: Sun, 14 Jun 2015 13:51:10 +0200 (CEST)
Message-ID: <230275426.551398.1434282670067.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433953472-32572-4-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <xmqqoakni8da.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 13:51:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z46RI-0006U6-Vf
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 13:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbFNLth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 07:49:37 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48089 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbbFNLtg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 07:49:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BF7A428D2;
	Sun, 14 Jun 2015 13:49:33 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTAJwRZDKVXf; Sun, 14 Jun 2015 13:49:33 +0200 (CEST)
Received: from zm-int-mbx2.grenet.fr (zm-int-mbx2.grenet.fr [130.190.242.141])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id AE38E28B4;
	Sun, 14 Jun 2015 13:49:33 +0200 (CEST)
In-Reply-To: <xmqqoakni8da.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: add the terms old/new
Thread-Index: 00o+nv4Bg44Mymt90HwQYq+nk0n2HQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271636>

I agree this makes no sense hardcoding old/new once bisect terms is
considerred. It would have been a lot better if we had started
implementing bisect terms immediatly (but we thought old/new would
already be an appreciable step for most of users).
