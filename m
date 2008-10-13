From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] describe: Make --tags and --all match lightweight
	tags  more often
Date: Mon, 13 Oct 2008 07:32:02 -0700
Message-ID: <20081013143202.GO4856@spearce.org>
References: <20080930083940.GA11453@artemis.corp> <20081010165952.GI8203@spearce.org> <20081010171217.GB29028@artemis.corp> <7vwsggl3ep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Erez Zilber <erezzi.list@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpOU4-0006mk-80
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 16:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbYJMOcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 10:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbYJMOcF
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 10:32:05 -0400
Received: from george.spearce.org ([209.20.77.23]:57564 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbYJMOcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 10:32:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 626A93835F; Mon, 13 Oct 2008 14:32:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vwsggl3ep.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98116>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> The primary mode of operation without --tags of "describe" is about coming
> up with version numbers, and as such, it should try to base its output on
> immutable anchors as much as possible.  For that reason, I think it should
> use "tag " line from the tag object, not the name of the ref, to describe
> the committish.  They should match (otherwise fsck would say something
> about it) in practice, though...

FWIW the use of "tag " line for an annotated tag being output is what
212945d4 (Teach git-describe to verify annotated tag names before
output) was all about.  That has been in tree since v1.5.5-rc0~86^2.

So we already are doing (have been doing) exactly what you are
asking for.

Or did I misunderstand you?

-- 
Shawn.
