From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 12:14:36 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902251213350.3111@localhost.localdomain>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com> <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain> <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0902251106070.3111@localhost.localdomain>
 <7vk57e1du3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:17:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQBo-0004ej-U8
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249AbZBYUPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 15:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756673AbZBYUPh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:15:37 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33717 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893AbZBYUPh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 15:15:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1PKEcCe016046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 12:14:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1PKEaTN005584;
	Wed, 25 Feb 2009 12:14:37 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vk57e1du3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.451 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111494>



On Wed, 25 Feb 2009, Junio C Hamano wrote:
> 
> "git merge" has always had this "stash away local changes before starting,
> and unstash once done" safety when we try to run multiple strategies.
> A patch to trigger it even for a single strategy case may be trivial.

Well, I'd feel better if it was actually in the low-level merge code, the 
way the current "I refuse to merge if the file is dirty" logic is.

			Linus
