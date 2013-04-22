From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Mon, 22 Apr 2013 09:30:30 +0200 (CEST)
Message-ID: <2120794796.1800558.1366615830636.JavaMail.root@openwide.fr>
References: <7vip3hx88x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 09:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUBCv-0003WI-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 09:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab3DVHad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 03:30:33 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:48757 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab3DVHac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 03:30:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 2DE8E28013;
	Mon, 22 Apr 2013 09:30:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9J8dWnsjbuA; Mon, 22 Apr 2013 09:30:30 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id B747028004;
	Mon, 22 Apr 2013 09:30:30 +0200 (CEST)
In-Reply-To: <7vip3hx88x.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221998>

> >
> > Would it make sense to integrate this in git shortlog, which
> > already
> > does something similar?
> 
> Conceptually, yes, but the end result will be much larger in scope.
> I am not sure if "shortlog" is still a good label for it.
> 

since we are throwing ideas around...

The first place where I would logically look for such a feature would be
in git-blame --cc-list or something like that.

git-blame seems to me as a logical place for all "look at history and give
me a list of names" type commands
