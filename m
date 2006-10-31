X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport: support for partial imports
Date: Wed, 1 Nov 2006 00:50:54 +0200
Message-ID: <20061031225054.GA20211@sashak.voltaire.com>
References: <20061025225026.GA13031@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 22:45:35 +0000 (UTC)
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061025225026.GA13031@sashak.voltaire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 31 Oct 2006 22:45:22.0752 (UTC) FILETIME=[3FD76C00:01C6FD3E]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30604>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf2MJ-0007Ac-Lw for gcvg-git@gmane.org; Tue, 31 Oct
 2006 23:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946043AbWJaWpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 17:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423847AbWJaWpZ
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 17:45:25 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:2368 "EHLO
 taurus.voltaire.com") by vger.kernel.org with ESMTP id S1423846AbWJaWpY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 17:45:24 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 1 Nov 2006 00:45:22 +0200
Received: by sashak (sSMTP sendmail emulation); Wed,  1 Nov 2006 00:50:54
 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 00:50 Thu 26 Oct     , Sasha Khapyorsky wrote:
> This adds support for partial svn imports. Let's assume that SVN
> repository layout looks like:
> 
>   $trunk/path/to/our/project
>   $branches/path/to/our/project
>   $tags/path/to/our/project
> 
> , and we would like to import only tree under this specific
> 'path/to/our/project' and not whole tree under $trunk, $branches, etc..
> Now we will be be able to do it by using '-P path/to/our/project' option
> with git-svnimport.
> 
> Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>

Any news about status of this patch?

