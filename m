From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 16:49:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201647490.10477@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
 <Pine.LNX.4.63.0510210140400.12723@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junio@twinsun.com>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:50:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkAB-0003NF-A4
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVJTXtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVJTXtc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:49:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932556AbVJTXtb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 19:49:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KNnMFC002386
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 16:49:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KNnLoO015366;
	Thu, 20 Oct 2005 16:49:21 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510210140400.12723@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10389>



On Fri, 21 Oct 2005, Johannes Schindelin wrote:
> 
> Also, people having merged with (A) would not have to undo that merge as 
> was suggested. The new (C) commit would contain the revert of (A).

Oh, they'll need to revert if they want to match Junios history. Otherwise 
they'll always generate yet another merge when they pull.

Doesn't matter that the _tree_ state may be the same, the only thing that 
matters is that their history will be different, and thus they will never 
be able to fast-forwared to Junio's tree unless they revert their local 
merge.

		Linus
