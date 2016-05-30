From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v4] upload-pack.c: use of parse-options API
Date: Mon, 30 May 2016 16:27:43 +0200 (CEST)
Message-ID: <607762163.175275.1464618463522.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160523130231.8725-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr> <CAPig+cRipGvwqXQhY1koOLR2h=VcHqrTMhp_zbphYtaabQ0qAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 30 16:21:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7O3r-0005Ms-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933260AbcE3OUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:20:51 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47335 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932210AbcE3OUv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 10:20:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id AC94E20AA;
	Mon, 30 May 2016 16:20:48 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9XeAPra53dCM; Mon, 30 May 2016 16:20:48 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 942792073;
	Mon, 30 May 2016 16:20:48 +0200 (CEST)
In-Reply-To: <CAPig+cRipGvwqXQhY1koOLR2h=VcHqrTMhp_zbphYtaabQ0qAw@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use of parse-options API
Thread-Index: LHrIaLiUm24m66QucJEL0Ofn5lQc5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295899>

Hello Eric,
Thank you for answer. Your remarks have been added in the next version.
> > +               OPT_BOOL(0, "strict", &strict,
> > +                        N_("do not try <directory>/.git/ if <directory> is
> > no Git directory")),
> 
> Use of OPT_BOOL introduces a --no-strict option which didn't exist
> before. Does this need to be documented? (Genuine question.)
> 
You're right. I've added it in the documentation.

Antoine
   
