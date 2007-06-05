From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] git-merge-file: refuse to merge binary files
Date: Mon, 4 Jun 2007 21:00:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706042059420.23741@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0706050337010.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:01:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQEr-0006b1-An
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbXFEEA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbXFEEA7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:00:59 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44431 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752347AbXFEEA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 00:00:58 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5540pTc016678;
	Mon, 4 Jun 2007 21:00:52 -0700
In-Reply-To: <Pine.LNX.4.64.0706050337010.4046@racer.site>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.592 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49153>



I really think this would be better off using the crlf-like heuristics.

It's entirely possible that the "NUL character in the first X bytes" 
heuristic is wrong for some cases, so I find it a bit nasty to hardcoding 
it as the only rule for "it must be binary"

		Linus
