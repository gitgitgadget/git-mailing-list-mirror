From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cvsps wierdness
Date: Mon, 12 Jun 2006 14:30:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606121429510.5498@g5.osdl.org>
References: <200606122247.02727.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0606121406200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 23:31:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fptzr-0001xF-IP
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 23:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFLVaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWFLVaw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 17:30:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932350AbWFLVav (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 17:30:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CLUlgt002912
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 14:30:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CLUlUh004296;
	Mon, 12 Jun 2006 14:30:47 -0700
To: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
In-Reply-To: <Pine.LNX.4.64.0606121406200.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21741>



On Mon, 12 Jun 2006, Linus Torvalds wrote:
> 
> I don't think this is strictly correct, btw. I suspect you can still get 
> into strange situations where the changeset merging has resulted in one 
> file ordering one way, and another file ordering the other way. 

Btw, I also fear that this could make cvsps noticeably slower, since the 
patchset comparison code is pretty expensive (O(n*m) in files in each 
patch-set).

		Linus
