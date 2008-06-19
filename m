From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] completion: add --graph to log command completion
Date: Fri, 20 Jun 2008 01:40:12 +0300
Message-ID: <20080619224012.GA6705@mithlond.arda.local>
References: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com> <20080619215842.GL11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Sod-0004j7-Ri
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYFSWkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYFSWkV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:40:21 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35944 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751991AbYFSWkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:40:20 -0400
Received: from mithlond.arda.local (80.220.180.140) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C0109CFD7; Fri, 20 Jun 2008 01:40:13 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K9Snc-0001kj-FJ; Fri, 20 Jun 2008 01:40:12 +0300
Content-Disposition: inline
In-Reply-To: <20080619215842.GL11793@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85553>

Shawn O. Pearce wrote (2008-06-19 17:58 -0400):

> Dan McGee <dpmcgee@gmail.com> wrote:
> > Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> 
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
> 
> First change for 1.5.6.1?  With --graph in 1.5.6 we really should have
> included this as part of 1.5.6.  Oh well.  1.5.6.1 perhaps Junio?

Liked-by: me

I think I have already sent twice a patch with --graph completion. I use
bash completions quite a lot and here's my current additions to "git
log":


---snip---
bash: Add more option completions for 'git log'

Options added: --graph --walk-reflogs --stat --numstat --shortstat
--decorate --diff-filter= --color-words

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 contrib/completion/git-completion.bash |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 506b40c..e78ca8e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -761,6 +761,9 @@ _git_log ()
 			--pretty= --name-status --name-only --raw
 			--not --all
 			--left-right --cherry-pick
+			--stat --numstat --shortstat
+			--decorate --diff-filter=
+			--color-words --walk-reflogs --graph
 			"
 		return
 		;;
-- 
1.5.6.2.g3c3a
