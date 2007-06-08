From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 12:06:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706081202580.4205@woody.linux-foundation.org>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
 <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
 <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
 <20070608182412.GQ2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 21:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwjnn-0001R3-ES
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 21:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185AbXFHTHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758733AbXFHTHI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 15:07:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42280 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757393AbXFHTHF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 15:07:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l58J6UCF003908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2007 12:06:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l58J6OUc008920;
	Fri, 8 Jun 2007 12:06:25 -0700
In-Reply-To: <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org>
Received-SPF: neutral (207.189.120.55 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-2.738 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49494>



On Fri, 8 Jun 2007, Linus Torvalds wrote:
> 
> I'll build with ElectricFence, and see if it says anything for me. It 
> passes all the tests, but fetching the kernel is almost certainly going to 
> do things that we don't test for..

It passes smaller clones fine with ElectricFence (and bigger ones fail 
because EF uses *so* much memory for its checking that you cannot actually 
complete them), so I don't think this is a git bug. Sounds like either the 
hw problems are real, or there is some zlib (or other library) issue..

		Linus
