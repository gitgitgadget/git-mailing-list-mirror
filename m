From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Sun, 12 Dec 2010 15:27:32 +1100
Message-ID: <20101212042732.GA7296@brick.ozlabs.ibm.com>
References: <1289212979-64246-1-git-send-email-lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Dec 12 05:32:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRdbr-0000n1-Tq
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 05:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab0LLEc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 23:32:28 -0500
Received: from ozlabs.org ([203.10.76.45]:51234 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab0LLEcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 23:32:23 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2165AB70AA; Sun, 12 Dec 2010 15:32:21 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1289212979-64246-1-git-send-email-lists@haller-berlin.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163470>

On Mon, Nov 08, 2010 at 11:42:59AM +0100, Stefan Haller wrote:
> Sometimes it's desirable to see what changes were introduced by a
> merge commit, rather than how conflicts were resolved. This adds
> a checkbox which, when turned on, makes gitk show the equivalent
> of "git show --first-parent <commit>" for merge commits.
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
> I realize this conflicts with Thomas Rast's recent patch to
> add a word-diff dropdown box; things are fighting for space
> in the diff pane header...

I just applied Thomas Rast's patch, so you'll need to rebase.  Also
you're right that we're running out of space; perhaps we need to make
the pane header two rows high.  Finally, "First parent" doesn't really
convey to me immediately what it does -- I have to think about it, so
it will probably confuse new users.  I don't know what would be
better, though.

Paul.
