From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/6] Fix thinko in subproject entry sorting
Date: Wed, 11 Apr 2007 14:51:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111451090.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704111423420.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbkjl-0003lN-1p
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbXDKVvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbXDKVvz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:51:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33991 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161274AbXDKVvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:51:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BLpoVZ023763
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 14:51:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BLpnlH015369;
	Wed, 11 Apr 2007 14:51:50 -0700
In-Reply-To: <Pine.LNX.4.64.0704111423420.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44263>



On Wed, 11 Apr 2007, Linus Torvalds wrote:
> 
> In contrast, it you have two files "proj/file" and "proj.c", the "proj.c" 
> will sort alphabetically before "proj/file" in the index. The index 
> itself, of course, does not actually contain an entry "proj/", but in the 
> *tree* that gets written out, the tree entry "proj" will sort before the 
                                                                ^^^^^^
> file entry "proj.c", which is the only real magic sorting rule.

That "before" should be "after", of course, otherwise the whole 
explanation makes no sense..

		Linus
