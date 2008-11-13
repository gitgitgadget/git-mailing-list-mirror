From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: bugreport: git does not like subseconds
Date: Thu, 13 Nov 2008 08:45:58 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811130842550.3468@nehalem.linux-foundation.org>
References: <alpine.LNX.1.10.0811131722360.13330@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0fME-0008R4-V7
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 17:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYKMQqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 11:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYKMQqf
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 11:46:35 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34216 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353AbYKMQqf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 11:46:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADGjx8p026223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 08:46:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADGjwRE017175;
	Thu, 13 Nov 2008 08:45:59 -0800
In-Reply-To: <alpine.LNX.1.10.0811131722360.13330@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.434 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100884>



On Thu, 13 Nov 2008, Jan Engelhardt wrote:
> 
> 
> Git does not like subseconds in $GIT_{AUTHOR,COMMITTER}_DATE,
> and somehow does time travel instead. Perhaps this is a Glibc
> limitation? Running openSUSE 11's glibc-2.8(which is actually
> a 2.7 snapshot I think: glibc-2.8-2008042513.tar.bz2).

This should have been fixed by 9f2b6d2936a7c4bb3155de8efec7b10869ca935e 
("date/time: do not get confused by fractional seconds").

But maybe that hasn't made it into any release yet? It's in master, but 
maybe it never made it into stable? Junio?

		Linus
