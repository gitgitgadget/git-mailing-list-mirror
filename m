From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: Implementation of git rebase --status
Date: Tue, 26 May 2015 20:21:33 +0200 (CEST)
Message-ID: <1778818097.1210126.1432664493400.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1086316854.1201217.1432650834727.JavaMail.zimbra@ensimag.grenoble-inp.fr> <2024498388.1201300.1432651081110.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqqiobfl38p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	Remi GALAN ALFONSO <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Louis-Alexandre STUBER 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine DELAITE <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 20:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxJRR-0002Q7-V6
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 20:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbEZSTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 14:19:00 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:45982 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbbEZSS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 14:18:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 664184881A;
	Tue, 26 May 2015 20:18:56 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCGReuaJFGGu; Tue, 26 May 2015 20:18:56 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4B8E148813;
	Tue, 26 May 2015 20:18:56 +0200 (CEST)
In-Reply-To: <xmqqiobfl38p.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: Implementation of git rebase --status
Thread-Index: Kr11amr5bXBAJEurOrBsqzFoOcJ0iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269961>


Junio C Hamano <gitster@pobox.com> writes:

>Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes: 

>> Do you think it could be useful or do you have any suggestion? 

>All of your examples say things like: 

>> You are in the middle of a rebase session. 
>> The line that paused this session is: 

>but what if there is no such "line"? 

>IOW, what does the user see when using this new option during a "git 
>rebase" (not "git rebase -i")? 

I guess it should display the sha1 of the patch that failed in this case.

>Other than that, sounds like a neat thing to do. 
