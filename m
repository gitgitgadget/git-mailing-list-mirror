From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Update git-svn to use the ability to place
	temporary files within repository directory
Date: Thu, 13 Nov 2008 01:41:47 -0800
Message-ID: <20081113094147.GA26898@untitled>
References: <491AE935.4040406@svanfeldt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: "Marten Svanfeldt (dev)" <developer@svanfeldt.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 10:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0YjD-0006CI-R6
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 10:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbYKMJlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 04:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYKMJlu
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 04:41:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:48774 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbYKMJlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 04:41:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 442FD2DC01A;
	Thu, 13 Nov 2008 09:41:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <491AE935.4040406@svanfeldt.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100861>

"Marten Svanfeldt (dev)" <developer@svanfeldt.com> wrote:
> This fixes git-svn within msys where Perl will provide temporary files
> with path such as /tmp while the git suit expects native Windows paths.

Ah, I completely didn't understand the related Git.pm patch from you
until I saw this sentence above.

Can you update that other patch and clarify this statement so it
makes sense to UNIX-only folks?

 | This fixes issues when the Perl in use uses a different format for paths
 | than in use by native code in the git tools such as msysgit with msys-perl.

Thanks,

-- 
Eric Wong
