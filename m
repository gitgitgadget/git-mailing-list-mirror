From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4: Add copy detection support
Date: Sat, 12 Feb 2011 08:32:23 -0500
Message-ID: <20110212133223.GA12432@arf.padd.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <1296429563-18390-2-git-send-email-vitor.hda@gmail.com>
 <20110206002547.GB31245@arf.padd.com>
 <AANLkTi=Awi6d77QcbbZ2rDTv6LpP+qjsReJ5=4NyhUBz@mail.gmail.com>
 <20110206220546.GA9024@mew.padd.com>
 <AANLkTikO4=froHvYN-JCOMZF7zgGHaD4J=nbN1ij_RjW@mail.gmail.com>
 <AANLkTinF=9ELNMV0TmBzjEPa=7BZF+dnAK7VUrUw4QNK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 14:32:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoFal-0004ns-7j
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 14:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1BLNcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 08:32:47 -0500
Received: from honk.padd.com ([74.3.171.149]:36155 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab1BLNcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 08:32:45 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id B3DFF1C78;
	Sat, 12 Feb 2011 05:32:41 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CFC8331ADE; Sat, 12 Feb 2011 08:32:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <AANLkTinF=9ELNMV0TmBzjEPa=7BZF+dnAK7VUrUw4QNK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166613>

vitor.hda@gmail.com wrote on Sat, 12 Feb 2011 00:29 +0000:
> Originally the code always opened the files for editing just in case
> there was a patch to be applied late,r. This makes sense, because git
> can detect a rename (or copy) even if the files differ. But doing this
> would create an "unclean" integration in the revision graph. So, what
> I thought was "if we have available the SHA of the origin and
> destination files in diff-tree output why not compare them before
> opening the file for editing?" And that was the only purpose for this
> comparison.

I get what you are saying and it makes sense to fix this.  I
think you are on the right track, and I can't see the problem
in the code.

Side note:  p4 installations can make client SubmitOptions
have "revertunchanged" to avoid these annoying null integrations.

		-- Pete
