From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 2/7] bisect: replace hardcoded "bad|good" by variables
Date: Mon, 22 Jun 2015 14:42:23 +0200 (CEST)
Message-ID: <134997869.703022.1434976943783.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433953472-32572-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpq1thi465i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 22 14:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z711j-0007tE-NE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 14:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933520AbbFVMkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 08:40:36 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:53613 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754070AbbFVMke (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 08:40:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2D1762059;
	Mon, 22 Jun 2015 14:40:32 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gjJlkJqxUv5M; Mon, 22 Jun 2015 14:40:32 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0F4F82058;
	Mon, 22 Jun 2015 14:40:32 +0200 (CEST)
In-Reply-To: <vpq1thi465i.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: replace hardcoded "bad|good" by variables
Thread-Index: amjoDe55bulxx1xlY1gBHV/mYtpdEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272336>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 

>Being an acceptable ref name is a constraint you have to check (Junio 
>already mentionned check-ref-format). I think quoting variables makes 
>sense too 

I don't get how 'git check-ref-format' works exactly. It says it needs 
at least one slash in the ref name. So it would not be good for bisect 
terms.
Then do we take the same format as branches ? 
( i.e 'git check-ref-format --branch' )

Thanks.
