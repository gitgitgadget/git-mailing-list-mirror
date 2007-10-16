From: Mike Hommey <mh@glandium.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 21:36:05 +0200
Organization: glandium.org
Message-ID: <20071016193605.GA829@glandium.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhsES-0004Vf-VA
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319AbXJPTh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765970AbXJPTh0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 15:37:26 -0400
Received: from vawad.err.no ([85.19.200.177]:53530 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759007AbXJPThZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 15:37:25 -0400
Received: from aputeaux-153-1-26-158.w82-124.abo.wanadoo.fr ([82.124.188.158] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IhsEA-0005j2-4i; Tue, 16 Oct 2007 21:37:18 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IhsCz-0000Dy-1O; Tue, 16 Oct 2007 21:36:05 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61242>

On Tue, Oct 16, 2007 at 12:20:50PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 16 Oct 2007, Jari Aalto wrote:
> 
> > * Tue 2007-10-16 Michael Witten <mfwitten AT MIT.EDU>
> > >
> > > However, 8 spaces per tab is a lot of wasted
> > > information to be bandying about.
> > 
> > Spaces are guaranteed to interpreted correctly in all environments. TABs
> > are the source of too many problems.
> 
> No.
> 
> Tabs are 8 spaces wide. Live with it. It's the only sane solution.

Actually, part of the mess with tabs is due to the fact they're not
exactly 8 spaces wide, but any width that ends at a multiple of 8
characters from the start of the line. So 0 <= n < 8 spaces and a tab
is still 8 spaces.

Anyways, it's maybe just simpler to run indent before sending patches.

Mike
