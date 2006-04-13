From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Common option parsing..
Date: Thu, 13 Apr 2006 07:46:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604130745160.14565@g5.osdl.org>
References: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org>
 <7vmzeq12zd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 16:47:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU360-0004PM-6q
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 16:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWDMOqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWDMOqh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 10:46:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964945AbWDMOqh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 10:46:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3DEkVtH013726
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Apr 2006 07:46:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3DEkTMd017990;
	Thu, 13 Apr 2006 07:46:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzeq12zd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18661>



On Wed, 12 Apr 2006, Junio C Hamano wrote:
> 
> However, I am not sure about the two-revs case.  I suspect the
> incoming items are sorted in the revs->commits list

Not by the argument parsing. That happens by "rev_parse_setup()" when we 
start to do the revision walking. 

So after setup_revisions() it's all good (although I think the list may be 
in "reverse order", I didn't check).

		Linus
