From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] bash completion: teach fetch, pull, and push to
	complete their options
Date: Fri, 6 Mar 2009 08:15:58 -0800
Message-ID: <20090306161558.GI16213@spearce.org>
References: <cover.1236314073.git.jaysoffian@gmail.com> <5576c9f6e10a6efec0b2bbbd156a25852506cc49.1236314073.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfcjq-0000ZN-I2
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZCFQQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZCFQQA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:16:00 -0500
Received: from george.spearce.org ([209.20.77.23]:39688 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbZCFQQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:16:00 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6D52938211; Fri,  6 Mar 2009 16:15:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5576c9f6e10a6efec0b2bbbd156a25852506cc49.1236314073.git.jaysoffian@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112460>

Jay Soffian <jaysoffian@gmail.com> wrote:
> fetch, pull, and push didn't know their options. They do now. merge's
> options are factored into a variable so they can be shared between
> _git_merge and _git_pull
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

but I think this patch depends on 2/3 in the series to be fixed first.

> ---
>  contrib/completion/git-completion.bash |   61 +++++++++++++++++++++++++++++---
>  1 files changed, 56 insertions(+), 5 deletions(-)

-- 
Shawn.
