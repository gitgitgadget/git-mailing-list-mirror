From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 03:04:21 -0400
Message-ID: <20071016070421.GE13801@spearce.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhgTm-0000Pm-53
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbXJPHE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbXJPHE0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:04:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33263 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbXJPHEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:04:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhgTW-0004SO-7r; Tue, 16 Oct 2007 03:04:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B472420FBAE; Tue, 16 Oct 2007 03:04:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61097>

Michael Witten <mfwitten@MIT.EDU> wrote:
> What are the rules about tabs and spaces in source code?
> 
> I'm having a terrible time with formatting,
> especially in the perl scripts; there is a
> mix of spaces and tabs.
> 
> from what I can deduce, single tabs are used
> to introduce the equivalent of 8 spaces while
> 4 explicit spaces are used for half a tab.

The C code is all tabs, with the tabs set at 8 spaces, but the
actual tab width isn't too important here as we never use the tab
for alignment beyond the left indent.

The bulk of the Perl/shell is also done that way, but you may
run into a place where it isn't.  In which case try to match the
existing identation within that block as best as you can so the diff
is minimal and the resulting file still indents just as good/bad
as it did before.

You may also consider submitting a whitespace correction patch in
front of your actual code change to correct the offending part of
the file, but every line you touch is that much more work for your
peers to review and test.  In short changing code is bad unless
there is a really compelling reason...

-- 
Shawn.
