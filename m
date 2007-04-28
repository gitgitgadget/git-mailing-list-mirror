From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sat, 28 Apr 2007 13:02:01 -0300
Organization: Mandriva
Message-ID: <20070428130201.27630ed4@gnut>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
	<1177693212202-git-send-email-lcapitulino@mandriva.com.br>
	<Pine.LNX.4.64.0704280446180.12006@racer.site>
	<20070428115059.GA4888@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, junkio@cox.net,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 18:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhpQW-0004se-IV
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 18:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbXD1QFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 12:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbXD1QFd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 12:05:33 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:40511 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbXD1QEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 12:04:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id AB3091848C;
	Sat, 28 Apr 2007 13:04:52 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id idINaTXQcAO3; Sat, 28 Apr 2007 13:02:06 -0300 (BRT)
Received: from gnut (unknown [189.4.50.224])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B36CC18489;
	Sat, 28 Apr 2007 13:02:05 -0300 (BRT)
In-Reply-To: <20070428115059.GA4888@steel.home>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45779>

Em Sat, 28 Apr 2007 13:50:59 +0200
Alex Riesen <raa.lkml@gmail.com> escreveu:

| Johannes Schindelin, Sat, Apr 28, 2007 04:46:41 +0200:
| 
| > Furthermore, it is not like it was a huge piece of code that is being 
| > replaced by a shortcut. There are better places to do some libification 
| > than this.
| 
| It is not about libification. It is plain readability issue.

 Yes, it's just something I've thought would be worth doing, it's
not the libfication work.

| Look at what list_for_each_* macros did to the source of Linux kernel.

 BTW, I was considering using Linux kernel's linked list
implementation in git, since we have some linked lists around.

 But I think people won't like it.
