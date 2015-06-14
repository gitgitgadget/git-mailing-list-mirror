From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Sun, 14 Jun 2015 22:05:26 +0200 (CEST)
Message-ID: <771291489.485827.1434312326536.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr> <323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 22:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4EC3-0006RK-22
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 22:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbbFNUEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 16:04:21 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:49868 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752AbbFNUET (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 16:04:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E1A3A27E9;
	Sun, 14 Jun 2015 22:04:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRSAI6a850VH; Sun, 14 Jun 2015 22:04:16 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CF7B627E0;
	Sun, 14 Jun 2015 22:04:16 +0200 (CEST)
In-Reply-To: <323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: XPuhuLRGQxyUMWU0O0Yjn/9SYi1S0f8+mm0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271649>

This message's goal is to explained where am I on the bisect 
functions. 

-git bisect replay now work with any terms. 
-I took account of most of the last reviews (coding style, 
double sed ...)
-'git bisect terms' without arguments now display the current 
terms 
-bisect_terms : if a bisection has already started, a more 
verbose message is displayed 
-I solved a merge conflict in bisect.c due to the update of 
master branch. 

To submit a v3 I would need answer about how we rebase the commit 
history and what do we do to simplify the life of the user with the 
terms (see my last mails). 
I was thinking of: 
-a config variable that would say :"as long as I don't reset keep 
the terms of the previous bisection" 
or we could decided that this is the default behaviour of bisect. 

-two config variables to choose default terms 

I may have less time in the next days but I would like to submit a v3. 
