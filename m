From: Linus Torvalds <torvalds@osdl.org>
Subject: "git diff a..b" broken
Date: Tue, 7 Feb 2006 10:23:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602071020120.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 07 19:26:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6XV2-0004yx-5w
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 19:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWBGSXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWBGSXd
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 13:23:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964836AbWBGSXd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 13:23:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k17INQDZ031841
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Feb 2006 10:23:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k17INN8I009304;
	Tue, 7 Feb 2006 10:23:26 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15704>


There's a funny breakage from the recent "--cc" changes.

If you do 

	git-diff-tree --cc version version2

and "version2" is a merge, it will do something really strange. I haven't 
figured out quite _what_ it does, but it's definitely the wrong thing.

Just a heads up. I'll try to track down what the breakage is.

		Linus
