From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GIT-GUI PATCH] call prepare-commit-msg hook
Date: Wed, 24 Sep 2008 10:04:34 -0700
Message-ID: <20080924170434.GW3669@spearce.org>
References: <48D02144.8030409@qlogic.com> <48D02D99.9090102@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Jay Blakeborough <jay.blakeborough@qlogic.com>,
	Bill Lohse <bill.lohse@qlogic.com>
To: Joshua Williams <joshua.williams@qlogic.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:06:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXo9-0000ll-6m
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYIXREf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYIXREf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:04:35 -0400
Received: from george.spearce.org ([209.20.77.23]:53803 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYIXREf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:04:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9CAAF3835F; Wed, 24 Sep 2008 17:04:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48D02D99.9090102@qlogic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Williams <joshua.williams@qlogic.com> wrote:
> Small change.  Still need to load MERGE_MSG and SQUASH_MSG
> if there's no prepare-commit-msg hook.  We now process the hook
> first and if it's not there, load MERGE_MSG or SQUASH_MSG.
>
> Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>

This patch looks reasonable.  My only comment is maybe we want
to delete PREPARE_COMMIT_MSG file when we "exit 1" when the hook
has declined.

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 10d8a44..8d06cd1 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh

Can you please try to put this onto my current git-gui tree?
I don't have the base 10d8a44 object so I can't 3-way merge
this in, and the patch doesn't apply cleanly anymore.

-- 
Shawn.
