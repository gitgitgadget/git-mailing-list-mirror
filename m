From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 17:25:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703221720481.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703221257020.18328@xanadu.home>
 <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
 <20070322221340.GA13867@segfault.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUXbj-0002D3-TP
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 01:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbXCWAZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 20:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXCWAZ6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 20:25:58 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58623 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbXCWAZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 20:25:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2N0Pceq027059
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 17:25:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2N0PbBR001881;
	Thu, 22 Mar 2007 17:25:37 -0700
In-Reply-To: <20070322221340.GA13867@segfault.peff.net>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42888>



On Thu, 22 Mar 2007, Jeff King wrote:
> 
> Try EF_DISABLE_BANNER=1

That does nothing for me. Nor does

	strings -- /usr/lib64/libefence.so | grep EF_

show that string or anything else half-way promising..

Googling for that shows that some versions of efence have had that flag 
(not necessarily as a environment variable, though). But certainly not the 
version I have.

		Linus
