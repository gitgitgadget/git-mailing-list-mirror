From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Sun, 13 Nov 2005 09:46:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
References: <4376C797.3050600@matysik.co.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 18:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbLwg-0002JL-4Z
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 18:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVKMRrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 12:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKMRrH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 12:47:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751344AbVKMRrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 12:47:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jADHl0nO001795
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 13 Nov 2005 09:47:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jADHkwHn011087;
	Sun, 13 Nov 2005 09:46:59 -0800
To: Thomas Matysik <thomas@matysik.co.nz>
In-Reply-To: <4376C797.3050600@matysik.co.nz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11743>



Quite frankly, I'd really prefer to see the git-core-http as a separate 
package.

I think it's ludicrous that people want to split out gitk (because it 
wants tcl/tk), but that we then add all of these really obscure 
dependencies for the http part. 

There are probably more boxes with tcl/tk on them than there are boxes 
with curl and expat (on one box I use, I already have to compile with 
NO_CURL=1 to avoid getting the http programs.

		Linus
