From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Revert "Convert output messages in merge-recursive to
	past tense."
Date: Fri, 22 Aug 2008 16:03:46 -0700
Message-ID: <20080822230346.GN3483@spearce.org>
References: <1219425524-77545-1-git-send-email-maillist@steelskies.com> <7v7ia87k2e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfgX-00061p-J6
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbYHVXDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYHVXDs
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:03:48 -0400
Received: from george.spearce.org ([209.20.77.23]:41680 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbYHVXDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:03:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D73C738375; Fri, 22 Aug 2008 23:03:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7ia87k2e.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93392>

Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <maillist@steelskies.com> writes:
> 
> > Now that the progress meter is gone, merge messages make more sense when presented in present tense
> >
> > This reverts commit 89f40be294363ce4d14ed6931a65561a4e8e9140.
> >
> > Conflicts:
> >
> > 	builtin-merge-recursive.c
> > ---
> 
> "Conflicts:"?  Please either remove it or describe how you resolved the
> conflicts.

The conflicts are likely because this was run with git-revert and a
few hunks had to be manually merged.  The result of the patch looks
fine to me.  But the "Conflicts" part of the message is likely not
interesting here.
 
> Sign-off?
> 
> The patch looked Ok to me.  Shawn?

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
