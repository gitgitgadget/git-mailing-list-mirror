From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Sun, 27 May 2007 21:37:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705102006.08624.johan@herland.net> <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 28 06:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsWz8-0005Xe-Sf
	for gcvg-git@gmane.org; Mon, 28 May 2007 06:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXE1Eh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbXE1Eh0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 00:37:26 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:60337 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965AbXE1Eh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 00:37:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4S4bGTX012517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 21:37:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4S4bFW5006542;
	Sun, 27 May 2007 21:37:15 -0700
In-Reply-To: <200705271608.02122.johan@herland.net>
X-Spam-Status: No, hits=-3.01 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48609>



On Sun, 27 May 2007, Johan Herland wrote:
> 
> I've been working on combining tag objects and --decorate into a useful
> proof-of-concept that provides the after-the-fact commit annotations I
> requested above, and here's the result:

Ok, looks fine to me. I do have a few questions:
 - why don't you just let people name their notes, the same way we name 
   tags (and then actually using it as the note name?)

   Putting them in the refs/notes/ filesystem by their SHA1 seems a bit 
   wasteful, and it would seem that it could be quite nice to name the 
   notes some way?

 - This will probably scale horribly badly if you have tens of thousands 
   of notes, even when they are packed. Do we care?

Other than that, it looks straightforward and sane.

		Linus
