From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 10:19:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907231018300.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907222204310.21520@localhost.localdomain> <7veis83q0e.fsf@alter.siamese.dyndns.org> <7vy6qg2aus.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU1xK-0004MB-3F
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 19:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbZGWRTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 13:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZGWRTh
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 13:19:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34979 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795AbZGWRTg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 13:19:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NHJUMx013890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 10:19:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NHJTCk024595;
	Thu, 23 Jul 2009 10:19:29 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vy6qg2aus.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123883>



On Wed, 22 Jul 2009, Junio C Hamano wrote:
>
> Subject: do_one_ref(): null_sha1 check is not about broken ref

Ack. If we want to make it conditional at some point, we'd want to use a 
different flag. 

I do wonder if we should simply remove the code entirely?

		Linus
