From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-receive-pack doesn't understand objects/info/alternates?
Date: Mon, 16 Apr 2007 11:57:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161157080.5473@woody.linux-foundation.org>
References: <E1HdQDl-0005ia-Bn@candygram.thunk.org>
 <8aa486160704160613t3ac17e4co9177ad91fda8eb36@mail.gmail.com>
 <20070416153040.GG27533@thunk.org> <7v3b30usth.fsf@assigned-by-dhcp.cox.net>
 <20070416184851.GH27533@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdWOe-0006uC-3f
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 20:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbXDPS5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbXDPS5s
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 14:57:48 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45963 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220AbXDPS5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 14:57:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GIvfIs031901
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 11:57:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GIveNT009439;
	Mon, 16 Apr 2007 11:57:40 -0700
In-Reply-To: <20070416184851.GH27533@thunk.org>
X-Spam-Status: No, hits=-0.449 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44687>



On Mon, 16 Apr 2007, Theodore Tso wrote:
> 
> Right, but I thought we weren't supposed to do running pack-refs
> --prune on master.kernel.org since that would break users using old
> git 1.4.x clients and who are accessing the repository over the http
> transport.

I've been packing refs for many months already..

		Linus
