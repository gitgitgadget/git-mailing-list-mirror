From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 08:16:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130812390.28042@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
 <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 17:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcNVV-0005lA-Tk
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 17:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbXDMPQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 11:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbXDMPQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 11:16:09 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36819 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbXDMPQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 11:16:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DFG5Is022518
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 08:16:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DFG5A7002695;
	Fri, 13 Apr 2007 08:16:05 -0700
In-Reply-To: <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44411>



On Fri, 13 Apr 2007, Paul Mackerras wrote:
>
> Linus Torvalds writes:
> 
> >  - bug Paul about alternate diff viewing capabilities in gitk. He's cc'd 
> >    here. A way to make the "diff" pane show just the new one, the old one, 
> >    or even both side-by-side with some mousy interface?
> 
> Showing just the old lines, or just the new lines, would be dead easy,
> since the Tk text widget has an "elide" option on tagged ranges of
> text that effectively removes them from the display.  So I don't even
> have to change the contents of the text widget, merely the display
> options associated with the tags that I already have attached to the
> old and new lines (that's how they get their color).

Ok, just a radio button for the patch case for "show patch" vs "show 
result" would certainly be sufficient for what I normally do. Adding the 
case "show origin" for completeness (ie filter out the new lines, rather 
than filtering out the old lines) is probably a good idea, even if I've 
never used it.

> Side-by-side would be more challenging.

Not a biggie. I've used kdiff3 etc in the past, and they do a good job of 
it and it "looks cool", but I've never done it on a command line which 
means that in practice _I_ don't use it. Maybe other people do.

> Have you seen what dirdiff can do with displaying diffs?  You can
> expose more context, move old and new lines up and down (but not in a
> manner which changes the meaning of the diff), and split context lines
> into old/new pairs, all with the mouse.

I've never used dirdiff. Sounds a bit like what kdiff3 does.

			Linus
