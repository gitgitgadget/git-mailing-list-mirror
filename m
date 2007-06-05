From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Git requires zip?
Date: Tue, 5 Jun 2007 09:16:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706050908520.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvbiY-0004qw-3Q
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762856AbXFEQQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764755AbXFEQQr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:16:47 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:40540 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932510AbXFEQQq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 12:16:46 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l55GGfs0010804;
	Tue, 5 Jun 2007 09:16:43 -0700
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.091 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49203>


It really shouldn't, but "make test" seems very unhappy if the machine 
doesn't have it, and I don't see anything that disables the tests for that 
case..

		Linus
