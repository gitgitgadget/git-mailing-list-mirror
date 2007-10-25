From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/6] Cleaned-up rename detection patch-series
Date: Thu, 25 Oct 2007 11:15:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:21:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7Kq-0003nd-UE
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbXJYSVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbXJYSVW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:21:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51471 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752771AbXJYSVV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:21:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIFHEe017533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:15:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIFG68007477;
	Thu, 25 Oct 2007 11:15:17 -0700
X-Spam-Status: No, hits=-3.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62348>


Ok, here's the patch-series to do rename detection of exact renames in 
linear time, except it's cleaned up into a nice series of 6 patches. The 
end result is identical to the previous patches (which got smushed down 
into just two patches in Junio's tree), apart from a fixed dependency in 
the Makefile that caused me grief and a broken test-suite due to some 
object files simply not being correctly recompiled.

The end result should be more understandable this way.

		Linus
