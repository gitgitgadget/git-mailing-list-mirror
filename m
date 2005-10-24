From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 18:37:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510231836020.10477@g5.osdl.org>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
 <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> <7v8xwjx2f9.fsf@assigned-by-dhcp.cox.net>
 <435C3427.30803@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:38:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrHA-0001tv-JF
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVJXBhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVJXBhV
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:37:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750855AbVJXBhT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 21:37:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9O1bEFC031264
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Oct 2005 18:37:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9O1bCUi005605;
	Sun, 23 Oct 2005 18:37:13 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <435C3427.30803@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10521>



On Sun, 23 Oct 2005, H. Peter Anvin wrote:
> 
> If this is meant to dequote shell-quoted paths, it really should be modal.

It _only_ accepts quoted strings, so it "is" modal. It has one mode: 
string. And it's a bitch about enforcing it, too (it just dies if it 
wasn't one).

		Linus
