From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 10:34:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703181033060.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172228220.18328@xanadu.home>
 <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
 <200703181153.59768.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 18:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSzHt-0005AU-I2
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 18:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbXCRRfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 13:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXCRRfU
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 13:35:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46536 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbXCRRfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 13:35:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2IHYqcD023357
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 10:34:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2IHYpFO027204;
	Sun, 18 Mar 2007 09:34:51 -0800
In-Reply-To: <200703181153.59768.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-0.98 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42507>



On Sun, 18 Mar 2007, Robin Rosenberg wrote:
> 
> I don't have the KDE repo, but I do have an Eclipse import. 
> 
> The eclipse repo is about 140k commits in the master branch and 
> has a 3GB pack file (fromcvs import). 

Do you happen to have a fast internet connection that you can expose this 
thing on?

3GB will take me a while to download, but it sounds like a great 
test-case. A 3GB pack-file is what we're supposed to be able to handle 
fairly comfortably right now, so it sounds like the ideal project to do 
performance testing on. 

		Linus
