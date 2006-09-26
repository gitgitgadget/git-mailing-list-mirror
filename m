From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Fix fetch --no-ignore-externals with GIT_SVN_NO_LIB=1
Date: Tue, 26 Sep 2006 11:14:02 -0700
Message-ID: <20060926181401.GA1479@hand.yhbt.net>
References: <1159263775639-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 20:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSHRZ-000478-Sn
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWIZSOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWIZSOG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:14:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47296 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932405AbWIZSOD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 14:14:03 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 286387DC02F; Tue, 26 Sep 2006 11:14:02 -0700 (PDT)
To: Sergey Vlasov <vsu@altlinux.ru>
Content-Disposition: inline
In-Reply-To: <1159263775639-git-send-email-vsu@altlinux.ru>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27808>

Sergey Vlasov <vsu@altlinux.ru> wrote:
> When using Subversion 1.3.1 without Perl bindings (GIT_SVN_NO_LIB=1),
> "git-svn fetch --no-ignore-externals" fails with errors like:
> 
>   Tree (.../.git/svn/git-svn/tree) is not clean:
>   X      directory_with_external
> 
> In this case the 'X' lines in the "svn status" output are not a sign
> of unclean tree, and therefore should be ignored.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
