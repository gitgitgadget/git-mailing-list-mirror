From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 18:19:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181816460.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 03:19:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW1Lo-0003SH-4h
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 03:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDSBTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 21:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWDSBTT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 21:19:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750855AbWDSBTS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 21:19:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J1JFtH029238
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 18:19:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J1JEP8002906;
	Tue, 18 Apr 2006 18:19:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18897>



On Tue, 18 Apr 2006, Linus Torvalds wrote:
> 
> So if we added the test for "are the objects two commits" to git-diff-tree 
> and diffed them directly, it would all "just work".

That "two commits" should obviously be "two blobs".

"Dave, my mind is going.. I can feel it.."

		Linus
