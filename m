From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH next resend] bash completion: refactor diff options
Date: Mon, 19 Jan 2009 09:31:53 -0800
Message-ID: <20090119173153.GB14053@spearce.org>
References: <1231679663-31907-1-git-send-email-trast@student.ethz.ch> <1232240603-11729-1-git-send-email-trast@student.ethz.ch> <7vtz7xytdo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 18:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOy0L-0003fh-5d
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbZASRb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760163AbZASRb4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:31:56 -0500
Received: from george.spearce.org ([209.20.77.23]:51985 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760159AbZASRby (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:31:54 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DFDD638210; Mon, 19 Jan 2009 17:31:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtz7xytdo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106369>

Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > +__git_diff_common_options="--stat --numstat --shortstat --summary
> >  			--patch-with-stat --name-only --name-status --color
> >  			--no-color --color-words --no-renames --check
> >  			--full-index --binary --abbrev --diff-filter=
> > -			--find-copies-harder --pickaxe-all --pickaxe-regex
> > +			--find-copies-harder
> 
> The changes around pickaxe made me "Huh?".  For log pickaxe makes very
> good sense but for a single diff it doesn't, yet the original seems to
> have had them only on "git diff" and not on "git log", which feels wrong.
> 
> Other than that, I think the patch tries to achieve a great thing in the
> longer term---we do not have to worry about common parts going out of sync
> between diff and log family of commands.

I agree completely.  The pickaxe stuff in current completion is
just plain wrong.  I'd like to see it fixed with this cleanup.
Maybe do it in two parts; fix the pickaxe options to be on log
and not diff, and then do the cleanup for the common options.

-- 
Shawn.
