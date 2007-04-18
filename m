From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:33:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704171831380.31155@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
 <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
 <20070417235649.GE31488@curie-int.orbis-terrarum.net>
 <7vps62lfbw.fsf@assigned-by-dhcp.cox.net> <20070418002658.GA18683@fieldses.org>
 <Pine.LNX.4.64.0704171800290.5473@woody.linux-foundation.org>
 <7v647ulbcv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdz3w-00082A-Px
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030970AbXDRBeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030981AbXDRBeB
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:34:01 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43541 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030970AbXDRBeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:34:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3I1XlYC025568
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 18:33:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3I1Xjv4013210;
	Tue, 17 Apr 2007 18:33:46 -0700
In-Reply-To: <7v647ulbcv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44851>



On Tue, 17 Apr 2007, Junio C Hamano wrote:
> 
> The use case the thread you are responding to assumes that you
> do *not* have a preimage before the change.

Sure. However, see my other script to actually find the "closest version". 
It's pretty easy.

In fact, even if you don't know which file it is, we could easily first 
have a separate "try to guess filename" (based on the same kind of 
heurstics) and then dig deeper on that filename.

So I think there are better ways to get the same effect without embedding 
any information.

		Linus
