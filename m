From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 1 Jan 2009 11:45:21 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 01 20:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LITVX-0003h6-Vk
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 20:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbZAATpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 14:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbZAATpm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 14:45:42 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52012 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241AbZAATpl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 14:45:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n01JjNwd030011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Jan 2009 11:45:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n01JjLco027889;
	Thu, 1 Jan 2009 11:45:22 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104312>



On Thu, 1 Jan 2009, Johannes Schindelin wrote:
> 
> Nothing fancy, really, just a straight-forward implementation of the
> heavily under-documented and under-analyzed paience diff algorithm.

Exactly because the patience diff is so under-documented, could you 
perhaps give a few examples of how it differs in the result, and why it's 
so wonderful? Yes, yes, I can google, and no, no, nothing useful shows up 
except for *totally* content-free fanboisms. 

So could we have some actual real data on it?

			Linus
