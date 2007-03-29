From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] An attempt to resolve a rename/rename conflict in recursive merge
Date: Fri, 30 Mar 2007 01:13:08 +0200
Message-ID: <20070329231308.GF2809@steel.home>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <20070329185501.GC2809@steel.home> <20070329230156.GE2809@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 01:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX3o9-00064z-TB
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 01:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbXC2XNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 19:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbXC2XNL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 19:13:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:35377 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422673AbXC2XNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 19:13:10 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (fruni mo50) (RZmta 5.5)
	with ESMTP id B039bdj2TM896K ; Fri, 30 Mar 2007 01:13:08 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9A26E277B6;
	Fri, 30 Mar 2007 01:13:08 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 810B1D150; Fri, 30 Mar 2007 01:13:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070329230156.GE2809@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43489>

Alex Riesen, Fri, Mar 30, 2007 01:01:56 +0200:
> 
> I just left all three entries in the index for the virtual commit to
> pick them up: it'll usually(always?) generate a conflict which has to
> be resolved manually. Many times, perhaps.
> 

Nah, doesn't do anything good. Does not crash, though.
