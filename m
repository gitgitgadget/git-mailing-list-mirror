From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 00/14] TreeWalk D/F conflict detection
Date: Tue, 19 Aug 2008 07:24:45 -0700
Message-ID: <20080819142445.GB20947@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org> <1219135931.3184.473.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVS9q-0006hu-T7
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbYHSOYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYHSOYq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:24:46 -0400
Received: from george.spearce.org ([209.20.77.23]:41543 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYHSOYq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:24:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6ADEB38375; Tue, 19 Aug 2008 14:24:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219135931.3184.473.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92864>

David Woodhouse <dwmw2@infradead.org> wrote:
> On Mon, 2008-08-18 at 16:53 -0700, Shawn O. Pearce wrote:
> > This series is about fixing the "mistake" in Git trees where
> > subtrees sort as through their name is "path/" and not "path".
> 
> Er, really? Does that mean this commit is broken, then?
> 
> http://git.kernel.org/?p=linux/kernel/git/dwmw2/misc-git-hacks.git;a=commitdiff;h=fc1b73da

Yes, that is broken.
 
> I shouldn't need to know that -- I'd _really_ like a version of
> 'git-hash-object -t tree' which validates and sorts its input for me.
> And maybe even takes input in _text_ form, so I don't have to convert
> the sha1 to binary.

Try `git mktree` instead.  It uses a text form, and it corrects
the sorting for you.  Though funny names that contain an LF may be
harder to send to mktree.

-- 
Shawn.
