From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Avoid spurious errors when rewriteRoot is
	used.
Date: Fri, 9 Oct 2009 01:34:44 -0700
Message-ID: <20091009083444.GA31594@dcvr.yhbt.net>
References: <200910091101.04116.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 10:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwAzI-0006VN-Q5
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 10:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077AbZJIIfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbZJIIfY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 04:35:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38704 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbZJIIfY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 04:35:24 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 5B9F01F7A1;
	Fri,  9 Oct 2009 08:34:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200910091101.04116.angavrilov@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129753>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> After doing a rebase, git-svn checks that the SVN URL
> is what it expects. However, it does not account for
> rewriteRoot, which is a legitimate way for the URL
> to change. This produces a lot of spurious errors.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Thanks Alexander,

Acked-by: Eric Wong <normalperson@yhbt.net>

Fixed some line wrapping and pushed out to
  git://git.bogomips.org/git-svn

-- 
Eric Wong
