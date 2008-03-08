From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Sat, 8 Mar 2008 00:51:57 -0500
Message-ID: <20080308055157.GA8410@spearce.org>
References: <20080305225123.GA8485@localdomain> <7vy78wgyu1.fsf@gitster.siamese.dyndns.org> <18383.51154.695501.543720@cargo.ozlabs.ibm.com> <20080308015357.GU8410@spearce.org> <18386.9974.50409.525039@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, kaitanie@cc.helsinki.fi,
	newsletter@dirk.my1.cc, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 06:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXrzX-00071w-Ev
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 06:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYCHFwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbYCHFwF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 00:52:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33909 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYCHFwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 00:52:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JXryQ-0005VM-QN; Sat, 08 Mar 2008 00:51:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 51DC820FBAE; Sat,  8 Mar 2008 00:51:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <18386.9974.50409.525039@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76549>

Paul Mackerras <paulus@samba.org> wrote:
> Shawn O. Pearce writes:
> 
> > git-gui does this scrollbar on-demand thing in its revision list meta-widget,
> > which is lib/choose_rev.tcl.  The procedure in question is this, and it gets
> > installed as:
> 
> That's a nice idea, doing it in _sb_set.  However, since the text
> widget adjusts the horizontal scroll bar depending on what's visible,
> that would mean the scroll bar would appear and disappear as you
> scrolled vertically through the text, which would be disconcerting.
> So for a text I think it's better to have the scrollbar there
> permanently.

Yea.  For a list it looks a little funny too, but its better than
not having the scrollbar there at all and looking at a chopped name
that you can't tell apart from another chopped name.  Which was a
bug I suffered from in the early dark ages of git-gui at my day
job.  Imagine Aunt Tillies blindly merging branches because they
cannot see the full branch names.  :-)
 
> Also, I wonder if you could use pack forget instead of destroying the
> scrollbar?

Because I didn't even know about that option to pack.  I'll have to
look into switching the code to do that.  Thanks for the suggestion.

-- 
Shawn.
