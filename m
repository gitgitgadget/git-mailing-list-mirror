From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:40:03 -0400
Message-ID: <20071020064003.GA30605@coredump.intra.peff.net>
References: <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <20071020063628.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ari Entlich <lmage11@twcny.rr.com>,
	Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij80Q-0007bG-Rn
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761869AbXJTGkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760927AbXJTGkH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:40:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1562 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760724AbXJTGkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:40:06 -0400
Received: (qmail 19102 invoked by uid 111); 20 Oct 2007 06:40:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 02:40:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 02:40:03 -0400
Content-Disposition: inline
In-Reply-To: <20071020063628.GV14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61797>

On Sat, Oct 20, 2007 at 02:36:28AM -0400, Shawn O. Pearce wrote:

> So lets say I make a change in my Makefile that changes the name
> of a source file to be more descriptive of that file's contents.
> I've reviewed the Makefile change *and* done the file rename,
> but I'm still not done reviewing the stuff in the file.  (Yea,
> maybe that should be two different commits, but maybe not, lets
> not get into that as it depends very much on context.)

Right. So the exact state you have in your index never actually existed
in your working tree. But that's OK if:
  - the changes are trivial and obviously correct
  - you're not actually planning on _committing_ that, you just want to
    build the commit using the index
And in those cases, git-stash is either, respectively, overkill or
totally useless.

Please ignore everything I said on this subject before today...I
obviously hadn't figured out what was going on.

-Peff
