From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix typo in release notes for 1.6.0.3
Date: Mon, 29 Sep 2008 08:08:58 -0700
Message-ID: <20080929150858.GH17584@spearce.org>
References: <1222700288-29717-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 17:10:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKO5-0004hB-19
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbYI2PI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbYI2PI7
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:08:59 -0400
Received: from george.spearce.org ([209.20.77.23]:58841 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYI2PI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:08:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 966EB3835F; Mon, 29 Sep 2008 15:08:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222700288-29717-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97019>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> diff --git a/Documentation/RelNotes-1.6.0.3.txt b/Documentation/RelNotes-1.6.0.3.txt
> index 46e13a4..a374690 100644
> --- a/Documentation/RelNotes-1.6.0.3.txt
> +++ b/Documentation/RelNotes-1.6.0.3.txt
> @@ -16,7 +16,7 @@ Fixes since v1.6.0.2
>  * Behaviour of "git diff --quiet" was inconsistent with "diff --exit-code"
>    with the output redirected to /dev/null.
>  
> -* "git stash apply sash@{1}" was fixed to error out.  Prior versions
> +* "git stash apply stash@{1}" was fixed to error out.  Prior versions
>    would have applied stash@{0} incorrectly.

Actually maybe that typo was a good thing.  The commit was about
erroring out on typos rather than silently applying stash@{0}.

-- 
Shawn.
