From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.perl: close the edit for propedits even with no
 mods
Date: Mon, 5 Dec 2011 17:10:36 -0800
Message-ID: <20111206011036.GA26704@dcvr.yhbt.net>
References: <1322707047-24227-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 02:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXjYP-0000hR-Ad
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 02:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780Ab1LFBKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 20:10:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48995 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932724Ab1LFBKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 20:10:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D05A1F4E8;
	Tue,  6 Dec 2011 01:10:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1322707047-24227-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186305>

Steven Walter <stevenrwalter@gmail.com> wrote:
> It's legitimate to update the mergeinfo property without
> actually changing any files.  This can happen when changes are
> backported to a branch, and then that branch is merged back
> into mainline.  We still want to record the updated mergeinfo
> for book-keeping.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>

Acked-by: Eric Wong <normalperson@yhbt.net>

Pushed to "master" of git://bogomips.org/git-svn.git

(Btw, you got my email address wrong in the Cc:)
