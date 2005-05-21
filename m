From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 01:15:36 -0400
Message-ID: <20050521051536.GA9387@havoc.gtf.org>
References: <4870.10.10.10.24.1116646732.squirrel@linux1> <7voeb5np30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 07:15:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZMK6-00026a-Rc
	for gcvg-git@gmane.org; Sat, 21 May 2005 07:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVEUFPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 01:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVEUFPw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 01:15:52 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:10205 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261664AbVEUFPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 01:15:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bastet.signetmail.com (RXG Elite Mail Server) with ESMTP
	id A5568A884E; Fri, 20 May 2005 23:55:56 -0400 (EDT)
Received: from bastet.signetmail.com ([127.0.0.1])
 by localhost (atlmail.prod.rxgsys.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17934-05; Fri, 20 May 2005 23:55:55 -0400 (EDT)
Received: from havoc.gtf.org (havoc.gtf.org [63.115.148.101])
	by bastet.signetmail.com (RXG Elite Mail Server) with ESMTP
	id 567D4A8849; Fri, 20 May 2005 23:55:52 -0400 (EDT)
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by havoc.gtf.org (Postfix) with ESMTP id 2C3141C1E94E;
	Sat, 21 May 2005 01:15:37 -0400 (EDT)
Received: (from garzik@localhost)
	by havoc.gtf.org (8.13.1/8.13.1/Submit) id j4L5FaPt009461;
	Sat, 21 May 2005 01:15:36 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voeb5np30.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: by EMS at localhost.localdomain
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2005 at 10:08:19PM -0700, Junio C Hamano wrote:
> The patch looks good.  Before you proceed to convert the rest,
> could I ask you to first let us see the list of new set of
> options and semantics changes, if any ("checkout-cache -f -a" vs
> "checkout-cache -a -f" immediately comes to mind)?

Typical implementation is agnostic on the ordering of options,
but with a few lines of code in parse_opt() that need not always be the
case.

FWIW most users (including me!) would expect that order of options is
-not- significant.

	Jeff



