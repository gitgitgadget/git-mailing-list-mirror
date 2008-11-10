From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 12:52:42 -0800
Message-ID: <20081110205242.GH2932@spearce.org>
References: <200811101522.13558.fg@one2team.net> <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Galiegue <fg@one2team.net>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdlm-0007ue-PJ
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbYKJUwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYKJUwn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:52:43 -0500
Received: from george.spearce.org ([209.20.77.23]:49578 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbYKJUwn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:52:43 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 92D32381FF; Mon, 10 Nov 2008 20:52:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100572>

Junio C Hamano <gitster@pobox.com> wrote:
> Francis Galiegue <fg@one2team.net> writes:
> 
> > A very nice git feature, without even going as far as merges, is the cherry 
> > pick feature.
> 
> I thought cherry-picking needs to be done in terms of 3-way merge, not
> diff piped to patch, for correctness's sake.

Yea, the 3-way merge cherry-pick is better.  But in a pinch you
can (usually) get correct results from a "diff | patch" pipeline.
Of course that doesn't always work, resulting in patches that don't
apply cleanly, or worse, that apply at the wrong place silently.

-- 
Shawn.
