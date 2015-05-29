From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a
 commit
Date: Fri, 29 May 2015 10:33:31 +0200 (CEST)
Message-ID: <1416141686.132444.1432888411621.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20150529082650.055A4487BA@zm-smtpout-1.grenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Philip Oakley <philipoakley@iee.org>
To: Git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 10:33:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyFjM-0006t9-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 10:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbbE2IdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 04:33:23 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42351 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752030AbbE2IdV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 04:33:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 20B50487DD;
	Fri, 29 May 2015 10:33:19 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MXKZUVIwjl4N; Fri, 29 May 2015 10:33:19 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 07530487BA;
	Fri, 29 May 2015 10:33:19 +0200 (CEST)
In-Reply-To: <1836557143.132299.1432888016868.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: Add key word "drop" to remove a commit
Thread-Index: e/o8QV3hVYd4EQToJQO38h8UYZMcJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270215>

At first we wanted a clear indication about removing a commit in
rebase -i. We didn't know about the noop command.
 - 'noop' does the same thing as 'drop' but for the user deleting a
   commit through 'noop' doesn't seem to be the proper way to use this
   command. Moreover 'noop' is not documented (especially it is not
   shown in the short help that is display in the editor during the
   rebase -i)
 - Commenting the line does the same but will cause problems with the
   second part of the patch (warn about removed commits) because the
   line is then not taken into consideration.

We wanted to add the 'drop' command because we wanted a way for
clearly deleting a commit (and also for the second part of the patch)
and there is no clear way so far.
