From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Wed, 17 Jun 2009 15:45:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:46:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH3td-0005Zo-PZ
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 00:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbZFQWpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 18:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762655AbZFQWpg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 18:45:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35627 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762750AbZFQWpf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 18:45:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5HMjHur026392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2009 15:45:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5HMjGoa005612;
	Wed, 17 Jun 2009 15:45:16 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <E1MH3bD-0004g2-97@fencepost.gnu.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.472 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121783>



On Wed, 17 Jun 2009, Alfred M. Szmidt wrote:
> 
> I would suggest the following update to the DCO, it makes it more
> general both to free software hackers, and open source hackers alike.

And I would suggest that Junio just not take patches from people who 
aren't able to read the existing DCO. It's not worth the pain. 

		Linus
