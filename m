From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Speed up reflog pruning of unreachable commits
Date: Tue, 31 Mar 2009 10:58:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903311056000.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain> <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain> <alpine.LFD.2.00.0903311010050.4093@localhost.localdomain> <7v63hp60vi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoiHS-0000B7-Sw
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664AbZCaSAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 14:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbZCaSAK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 14:00:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56536 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752948AbZCaSAI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 14:00:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VHwqBS019893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Mar 2009 10:59:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2VHwqun016805;
	Tue, 31 Mar 2009 10:58:52 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v63hp60vi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115294>



On Tue, 31 Mar 2009, Junio C Hamano wrote:
> 
> You seem to have lost "if (cb.ref_commit)" from the last round to protect
> mark_rechable().  It can be NULL.

I based it on your original patch, so yeah, it's missing all your updates 
since.

			Linus
