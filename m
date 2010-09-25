From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Sat, 25 Sep 2010 04:24:57 +0000
Message-ID: <20100925042457.GA28899@dcvr.yhbt.net>
References: <20100924162704.GA4513@dcvr.yhbt.net> <1285386710-27905-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Walter <stevenrwalter@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 06:25:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzMJu-00017x-63
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 06:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0IYEY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 00:24:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40256 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab0IYEY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 00:24:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5551F4F3;
	Sat, 25 Sep 2010 04:24:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1285386710-27905-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157116>

Steven Walter <stevenrwalter@gmail.com> wrote:
> As a first step towards preserving merges across dcommit, we need a
> mechanism to update the svn:mergeinfo property.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>

Thanks Steven,

I fixed a bashism and style issues in test case, but nonetheless acked
and pushed it out to git://git.bogomips.org/git-svn along with a few
others I had forgotten to tell Junio about while I was on vacation:

Eric Wong (1):
      Documentation/git-svn: discourage "noMetadata"

Mathias Lafeldt (1):
      git-svn: fix processing of decorated commit hashes

Steven Walter (2):
      git-svn: check_cherry_pick should exclude commits already in our history
      git-svn: allow the mergeinfo property to be set

-- 
Eric Wong
