From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 17:38:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702191737150.20368@woody.linux-foundation.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
 <7v7iud4nyo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 02:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJxa-0003Sg-8v
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 02:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbXBTBiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 20:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbXBTBiX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 20:38:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46113 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932754AbXBTBiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 20:38:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1K1cIhB020290
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Feb 2007 17:38:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1K1cHvl027300;
	Mon, 19 Feb 2007 17:38:17 -0800
In-Reply-To: <7v7iud4nyo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.457 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40193>



On Mon, 19 Feb 2007, Junio C Hamano wrote:
> 
> I think use_patch() has always took care of that.

Ahh, right you are. 

		Linus
