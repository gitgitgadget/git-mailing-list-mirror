From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/5] Define Patch to parse a sequence of patch
	FileHeaders
Date: Thu, 11 Dec 2008 12:41:37 -0800
Message-ID: <20081211204137.GJ32487@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <200812111934.13218.robin.rosenberg.lists@dewire.com> <20081211183954.GH32487@spearce.org> <200812112139.29875.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsNV-00048l-2E
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbYLKUlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757413AbYLKUli
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:41:38 -0500
Received: from george.spearce.org ([209.20.77.23]:48205 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbYLKUli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 15:41:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8770638200; Thu, 11 Dec 2008 20:41:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812112139.29875.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102824>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> ...Quick, quick, find something else to pick on..  :->

Heh, you'll get more patches again from me today, so there'll still
be more to pick on. :)
 
> Yes. Very little of the code in TemporaryBuffer is covered by the unit tests
> and number of conditionals in there are rather large. I tried messing with
> the constants in there to improve that and then PatchTest started to fail.
> 
> Here are the changes I tried with. I think it should still work with thes
> changes. Rather than changing the other tests, we might want to create
> a special test for only the buffer class.

Ok.  I was thinking the same thing actually, that I should spend a
bit of time today and try to get coverage on TemporaryBuffer.  I'll
write a unit test for it.

-- 
Shawn.
