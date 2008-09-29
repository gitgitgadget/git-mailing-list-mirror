From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] parse-opt: migrate fmt-merge-msg.
Date: Mon, 29 Sep 2008 09:35:23 -0700
Message-ID: <20080929163523.GC18340@spearce.org>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org> <1222595139-32087-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:36:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkLje-0004JM-T3
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 18:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYI2QfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 12:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbYI2QfY
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 12:35:24 -0400
Received: from george.spearce.org ([209.20.77.23]:46653 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYI2QfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 12:35:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6F1C438360; Mon, 29 Sep 2008 16:35:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222595139-32087-2-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97033>

Pierre Habouzit <madcoder@debian.org> wrote:
> Also fix an inefficient printf("%s", ...) where we can use write_in_full.
> 
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-fmt-merge-msg.c |   50 +++++++++++++++++++++-------------------------
>  1 files changed, 23 insertions(+), 27 deletions(-)

Near as I can tell, this is based upon a merge commit in next.

We can't do that.  Patches need to be based on master, or worst-case
on a topic head that is in next or pu (in which case the name of
the topic, or its tip commit, is helpful in the note).

-- 
Shawn.
