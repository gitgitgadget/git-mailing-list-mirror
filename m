From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv2 0/2] Make t9119-git-svn-info.sh run with svn 1.6.*
Date: Thu, 4 Mar 2010 01:47:08 -0800
Message-ID: <20100304094708.GA12885@dcvr.yhbt.net>
References: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net> <cover.1267647872.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 10:47:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn7eG-00080X-IZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 10:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab0CDJrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 04:47:12 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44043 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab0CDJrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 04:47:09 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951D21F4F1;
	Thu,  4 Mar 2010 09:47:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1267647872.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141518>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> I'm sorry my previous analysis was wrong. In fact, since the delayed
> loading of SVN::Core, git-svn's cmd_info would guess the wrong svn version
> because it uses SVN::Core without loading it (leading to an empty version string).
> 
> After fixing this, the test runs unmodified, so enbale it for 1.6.*.
> 
> Michael J Gruber (2):
>   git-svn: req_svn when needed
>   t9119-git-svn-info.sh: test with svn 1.6.* as well
> 
>  git-svn.perl            |    1 +
>  t/t9119-git-svn-info.sh |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)

Thanks Michael,

Acked and pushed out to: git://git.bogomips.org/git-svn.git

-- 
Eric Wong
