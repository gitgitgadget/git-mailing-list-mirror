From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Use previous author when amending a commit
Date: Mon, 9 Feb 2009 07:29:24 -0800
Message-ID: <20090209152924.GI30949@spearce.org>
References: <498FF7D1.8030905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWY60-0005Ea-Dr
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbZBIP3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZBIP3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:29:25 -0500
Received: from george.spearce.org ([209.20.77.23]:40042 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZBIP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:29:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5F02B38210; Mon,  9 Feb 2009 15:29:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <498FF7D1.8030905@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109081>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> In the commit dialog, when amending the commit, the author of the
> previous commit is proposed as default in the author field.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>

Much better to read when its by itself.

Applied.  Thanks.

>  .../egit/ui/internal/actions/CommitAction.java     |    5 ++++-
>  .../egit/ui/internal/dialogs/CommitDialog.java     |   12 ++++++++++++
>  2 files changed, 16 insertions(+), 1 deletions(-)

-- 
Shawn.
