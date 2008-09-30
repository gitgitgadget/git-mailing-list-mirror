From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] parse-opt: migrate fmt-merge-msg.
Date: Tue, 30 Sep 2008 15:46:23 -0700
Message-ID: <20080930224623.GQ21310@spearce.org>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org> <1222595139-32087-2-git-send-email-madcoder@debian.org> <20080929163523.GC18340@spearce.org> <20080930084019.GB11453@artemis.corp> <20080930191014.GH21310@spearce.org> <20080930211643.GA16879@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 00:47:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kko0E-0003Gd-WC
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 00:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYI3WqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYI3WqY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 18:46:24 -0400
Received: from george.spearce.org ([209.20.77.23]:40877 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbYI3WqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 18:46:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5FA7138360; Tue, 30 Sep 2008 22:46:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930211643.GA16879@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97166>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Sep 30, 2008 at 07:10:14PM +0000, Shawn O. Pearce wrote:
> > Pierre Habouzit <madcoder@debian.org> wrote:
> > > On Mon, Sep 29, 2008 at 04:35:23PM +0000, Shawn O. Pearce wrote:
> > > > Pierre Habouzit <madcoder@debian.org> wrote:
> > > > > Also fix an inefficient printf("%s", ...) where we can use write_in_full.
> > 
> > I'd appreciate an updated series if you can send it.  am -3 isn't
> > "easily" applying it.
> 
> Okay, I will then, but FWIW it means that when you'll try to merge this
> in next it'll conflict at that time, so I'm not sure there's a huge win
> for you at that point.

It may actually be a good idea to rebase this against master.

Reading Junio's notes for sg/merge-options (the branch this conflict
is coming out of) it sounds like we'd want to revert that anyway.
Its been around since April and Junio was talking about it needing
to be in a 1.7.0 release.  Its not going to graduate anytime soon.

IOW I'm quite tempted to revert sg/merge-options and cancel the
branch out of next.

-- 
Shawn.
