From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/4] Switch usage of AnyObjectId.toString() to new
	AnyObjectId.name()
Date: Wed, 3 Sep 2008 16:00:31 -0700
Message-ID: <20080903230031.GH28315@spearce.org>
References: <20080903170438.GA28315@spearce.org> <1220477294-23268-1-git-send-email-robin.rosenberg@dewire.com> <1220477294-23268-2-git-send-email-robin.rosenberg@dewire.com> <200809040005.55643.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb1NO-00046d-KY
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 01:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621AbYICXBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbYICXAh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 19:00:37 -0400
Received: from george.spearce.org ([209.20.77.23]:46633 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbYICXAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 19:00:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4527038375; Wed,  3 Sep 2008 23:00:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809040005.55643.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94869>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> The order of the patches should be
> Add name to AnyObjectId
> Switch usage.. in jgit
> Switch usage.. in egit
> Change toString to the new behaviour

Yup.  I'll take care of it.  I'll split the toString change out
of the first hunk and toss it into a final patch at the end of
the series.

-- 
Shawn.
