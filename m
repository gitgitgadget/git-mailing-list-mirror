From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 18:44:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211843160.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001212131230.1726@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:45:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9WO-0007p7-23
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab0AVCpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755734Ab0AVCpJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:45:09 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33592 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752640Ab0AVCpI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 21:45:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M2ibAq011844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 18:44:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M2ibke012254;
	Thu, 21 Jan 2010 18:44:37 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001212131230.1726@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137726>



On Thu, 21 Jan 2010, Nicolas Pitre wrote:
> 
> So I really think that Linus' patch (which is missing hex.c btw) is a 
> good thing to do, even if only for the cleanup value.

Gaah. hex.c was the obvious code movement with just a "cache.h" include at 
the top. However, I already threw away that whole tree in favor of the 
built-in version, and now I'm too lazy to re-create it.

		Linus
