From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 11:09:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705241105210.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 20:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHv1-0004Ol-MX
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbXEXSUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbXEXSUG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:20:06 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44895 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751AbXEXSUE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2007 14:20:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4OI9cFk011724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2007 11:09:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4OI9b7U031906;
	Thu, 24 May 2007 11:09:37 -0700
In-Reply-To: <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
X-Spam-Status: No, hits=-2.569 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48286>



On Thu, 24 May 2007, Sven Verdoolaege wrote:
> 
> If you allow an override, then I don't see how having the initial
> information in the tree is any better.
> When new information gets in from the tree, you're going to ignore it anyway.

Well, duh. "Paging Mr Ovious".

IF you have local overrides they get ignored. 

Which is what _should_ happen, of course.

> What if someone is working on his own branch of the superproject
> that needs some changes in his own subproject?
> He needs to modify .gitmodules, but when the changes go upstream,
> this .gitmodules changes get merged as well.
> Now imagine several developers doing this.
> You end up continually having to modify .gitmodules.

Ehh. What drugs are you on?

That's the whole point of having local overrides. You use them for local 
branches. You do _not_ use .gitmodules for those.

So ".gitmodules" is the default for people who don't do anything special. 
Only people who change the _default_ would ever change that.

I really don't understand or see your objections at all. You are making 
totally idiotic arguments BASED ON DOING OBVIOUSLY STUPID THINGS. That's 
not an argument.

		Linus
