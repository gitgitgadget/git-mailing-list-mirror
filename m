From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Wed, 10 Jan 2007 15:23:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> 
 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> 
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
  <20070107163112.GA9336@steel.home>  <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 00:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4mn0-000217-4B
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 00:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbXAJXXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 18:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbXAJXXX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 18:23:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35294 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965237AbXAJXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 18:23:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0ANNJWi032378
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Jan 2007 15:23:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0ANNIxv011210;
	Wed, 10 Jan 2007 15:23:18 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
X-Spam-Status: No, hits=-2.665 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36538>



On Thu, 11 Jan 2007, Alex Riesen wrote:
> 
> Yep. Tried the monster merge on it: 1m15sec on that small laptop.

Is that supposed to be good? That still sounds really slow to me. What 
kind of nasty project are you doing? Is this the 44k file project, and 
under cygwin? Or is it that bad even under Linux?

			Linus
