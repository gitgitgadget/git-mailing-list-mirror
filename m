From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 10/10] send-email: suppress meaningless whitespaces
 in from field
Date: Wed, 17 Jun 2015 17:11:56 +0200 (CEST)
Message-ID: <1753377376.582128.1434553916066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434551525-24709-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqr3pal71v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:10:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ez7-000399-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbbFQPKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 11:10:33 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:52781 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932366AbbFQPKc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 11:10:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1DAE22850;
	Wed, 17 Jun 2015 17:10:31 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gkce+Mi5IwYK; Wed, 17 Jun 2015 17:10:31 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0CC85284B;
	Wed, 17 Jun 2015 17:10:31 +0200 (CEST)
In-Reply-To: <vpqr3pal71v.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: send-email: suppress meaningless whitespaces in from field
Thread-Index: h4G19O0lLbQBPCo9GspRioQw3A3r6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271854>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes: 

> > if (defined $sender) { 
> > + $sender =~ s/^\s+|\s$//g; 

> I would say \s+ also for the second \s. Not really different, but it 
> feels wrong to iterate the substitution as many times as there are 
> trailing spaces to remove. 

Oops should have read it one more time... Thanks.
