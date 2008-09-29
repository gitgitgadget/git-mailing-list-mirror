From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Mon, 29 Sep 2008 07:55:42 -0700
Message-ID: <20080929145542.GA18340@spearce.org>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de> <20080924155745.GA3908@coredump.intra.peff.net> <20080924170154.GA6816@neumann> <20080924175315.GA10337@coredump.intra.peff.net> <20080924195658.GB6816@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, vim@tpope.info, git@vger.kernel.org
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Sep 29 16:58:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKBB-0007dt-AD
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 16:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYI2Ozo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 10:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYI2Ozn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 10:55:43 -0400
Received: from george.spearce.org ([209.20.77.23]:37422 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYI2Ozn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 10:55:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D7C3D3835F; Mon, 29 Sep 2008 14:55:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080924195658.GB6816@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97014>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> remove vim syntax highlighting in favor of upstream
> 
> As of version 7.2, vim ships with its own syntax
> highlighting for git commit messages, which is:
> 
>   1. more comprehensive in splitting up the various
>      components of the file
> 
>   2. in accordance with the usual vim behavior for syntax
>      highlighting (e.g., respecting b:current_syntax)
> 
>   3. presumably better maintained (I have not been using
>      what's in git's contrib/ directory for some time in
>      favor of the upstream version)
> 
> Furthermore, vim 7.2 also provides syntax highlighting for
> other git filetypes (gitconfig, rebase, send-email).
> 
> This patch gets rid of our local version and just points
> interested parties to the upstream version.
> 
> The code for auto-detecting filetypes is taken from vim 7.2's
> runtime/filetype.vim.
> 
> ---
>  contrib/vim/README               |   38 ++++++++++++++++++++++++++++++--------
>  contrib/vim/syntax/gitcommit.vim |   18 ------------------
>  2 files changed, 30 insertions(+), 26 deletions(-)
>  delete mode 100644 contrib/vim/syntax/gitcommit.vim

Missing SBO line?
 
-- 
Shawn.
