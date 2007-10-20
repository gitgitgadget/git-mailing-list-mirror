From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 03:02:49 -0400
Message-ID: <20071020070249.GX14735@spearce.org>
References: <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <20071020063628.GV14735@spearce.org> <8D972813-2D7F-4D6A-958F-B76E947E7BC3@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:03:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij8MW-0003xF-OS
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 09:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbXJTHC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 03:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbXJTHC5
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 03:02:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47987 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbXJTHC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 03:02:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij8MH-0008QB-2I; Sat, 20 Oct 2007 03:02:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ABEB820FBAE; Sat, 20 Oct 2007 03:02:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8D972813-2D7F-4D6A-958F-B76E947E7BC3@MIT.EDU>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61803>

Michael Witten <mfwitten@MIT.EDU> wrote:
> 
> On 20 Oct 2007, at 2:36:28 AM, Shawn O. Pearce wrote:
> 
> >Today I move the file, then unstage the hunks I'm not sure about,
> >then go back and restage them.  Annoying.  It really disrupts
> >my workflow.
> 
> I know it's against policy, but the proposed change should be set
> as the default at some point, in my opinion.

Its not so much policy as a timing issue.

Git 1.5.4 shouldn't have major distruptions to end-users in terms
of changing existing behavior to be different than in 1.5.3.
Especially default behavior.

Git 1.6.0 we're a little bit more willing to change default
behavior as it is a full major release.  This is probably quite a
bit off still, unless we started to accumulate a lot of really good
changes that required breaking something in the user interface.
That's what happened with the 1.4.4 series vs. 1.5.0.  Right now
I don't see that happening anytime soon.

> I have a feeling that my suggestion will not go far,
> but I also think that backwards compatibility can
> overstay its welcome.

I agree.

-- 
Shawn.
