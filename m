From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Sun, 18 Mar 2007 14:48:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703181440140.6730@woody.linux-foundation.org>
References: <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703180854470.6730@woody.linux-foundation.org>
 <20070318213807.GB20658@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3F8-00042F-Go
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbXCRVsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbXCRVsp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:48:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:55764 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932853AbXCRVso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:48:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2ILmIcD030289
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 14:48:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2ILmHOO031293;
	Sun, 18 Mar 2007 13:48:17 -0800
In-Reply-To: <20070318213807.GB20658@spearce.org>
X-Spam-Status: No, hits=-0.979 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42527>



On Sun, 18 Mar 2007, Shawn O. Pearce wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > Of course, the git gui blame colorization is clearly done by somebody who 
> > is still actively popping LSD with both fists and didn't realize that the 
> > 60's are long done, but that's another issue.
> 
> :-)
> 
> git-gui is open source.  I'd be happy to take a patch.  Or,
> since that is horribly messy Tcl/Tk code, just a better color
> suggestion. :-)

Yeah, the Tcl/Tk part means that I take one look and decide that I have 
absolutely zero clue..

Also, I'm not entirely sure what the "right" color is, but the changing 
colors do confuse me. Also, maybe I'm some kind of white suburban 
house-wife or something, but I prefer calmer pastel colors over the bright 
ones you've selected.

I would suggest:

 - some special color for "currently selected" (which defaults to being 
   the first one coming out of the blame thing, of course). 

   I'd suggest "black text on pale green background", but that may be just 
   me. Patricia calls the current color "hot pink", and maybe that's 
   appropriate for a certain segment of the population, but I'm not sure I 
   want to even *meet* that segment ;)

 - some *stable* graduated color for the rest. I don't think it 
   necessarily needs to be "older" vs "newer", and in fact I'd suggest 
   just two slightly different shades of gray for the background - just 
   pick alternating shades for each blame entry that comes in (and leave 
   un-blamed lines white).

The flickering just makes me go "ooh, I'm really happy I don't have 
epilepsy, because otherwise I'd be writhing on the floor every time I 
tried to use this tool".

			Linus
