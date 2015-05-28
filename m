From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase
 --status
Date: Thu, 28 May 2015 17:43:09 +0200 (CEST)
Message-ID: <1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 17:43:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxzxd-0004M9-5b
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 17:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbbE1PnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 11:43:05 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46886 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbbE1PnE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 11:43:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 26A9F4885B;
	Thu, 28 May 2015 17:43:00 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1n6S7-DnZaF; Thu, 28 May 2015 17:43:00 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0D68748849;
	Thu, 28 May 2015 17:43:00 +0200 (CEST)
In-Reply-To: <CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: create a skeleton for the command git rebase --status
Thread-Index: EMvh6FRIc+1/mLeT7khnpwEN9VQSxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270155>


Hi,=20

"Paul Tan" <pyokagan@gmail.com> :=20
> I haven't kept up with the discussion, but I'm wondering: since you=20
> need the functionality in wt-status.c, why not implement it in git=20
> status? In fact, git-status already shows if there is a rebase in=20
> progress, so why not extend it to say which patch/todo line the rebas=
e=20
> stopped on? It feels much more natural to me to use git-status to=20
> check the status of the rebase, instead of git rebase --status.=20
> Thanks, Paul=20

It's a question I have asked myself but since git rebase --status will=20
certainly display more information maybe it's better to separate the=20
two commands, and to indicate the user that git rebase --status exists=20
in git status during a rebase. If we choose to use git status, it=20
could be an option to display the full information since it currently=20
gives very few information. I'm not sure what -verbose does but it=20
could be its role.=20

Thanks,=20

Guillaume Pag=C3=A8s=20
