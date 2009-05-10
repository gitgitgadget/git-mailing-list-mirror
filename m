From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] completion: enhance "current branch" display
Date: Sun, 10 May 2009 14:18:18 -0700
Message-ID: <20090510211818.GA30527@spearce.org>
References: <7vvdo91glm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 23:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3GPs-000177-Pl
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 23:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbZEJVST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZEJVSS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 17:18:18 -0400
Received: from george.spearce.org ([209.20.77.23]:51369 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbZEJVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 17:18:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 72BB4381D5; Sun, 10 May 2009 21:18:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vvdo91glm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118747>

Junio C Hamano <gitster@pobox.com> wrote:
> Introduce GIT_PS1_DESCRIBE option you can set to "contains", "branch", or
> "describe" to tweak the way how a detached HEAD is described.
> 
> The default behaviour is to describe only exact match with some tag
> (otherwise use the first 7 hexdigits) as before.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I do not think the new modes based on name-rev (aka "--contains") are
>    much useful if you do your own development while on a detached HEAD,
>    but they probably are useful for tourists who sightsee.

Yea, both patches are sensible.

IIRC the desire for name-rev was for detached HEAD in contexts
like what git submodule produce.  If you are sitting on a tagged
version in a submodule, its nice to see that in your prompt.
Since you aren't developing there right now, there is no branch,
and you are just sightseeing.

This feature may have started at my prior job, where we had our
own git submodule like tool integrated with our build system,
that predated git submodule.  But its also still really useful
with say the Android Open Source Project, where users have 150 or
so git repositories, all on detached HEADs, most pointing at an
annotated tag.

-- 
Shawn.
