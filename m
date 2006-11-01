X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport: support for partial imports
Date: Wed, 1 Nov 2006 02:51:05 +0200
Message-ID: <20061101005105.GA20556@sashak.voltaire.com>
References: <20061025225026.GA13031@sashak.voltaire.com> <20061031225054.GA20211@sashak.voltaire.com> <7v1wooqc6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 00:45:46 +0000 (UTC)
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v1wooqc6j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 01 Nov 2006 00:45:33.0144 (UTC) FILETIME=[0991ED80:01C6FD4F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30614>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf4Ec-0004mH-Fy for gcvg-git@gmane.org; Wed, 01 Nov
 2006 01:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423555AbWKAApf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 19:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423824AbWKAApf
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 19:45:35 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:54092 "EHLO
 taurus.voltaire.com") by vger.kernel.org with ESMTP id S1423555AbWKAApf
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 19:45:35 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 1 Nov 2006 02:45:33 +0200
Received: by sashak (sSMTP sendmail emulation); Wed,  1 Nov 2006 02:51:05
 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 15:48 Tue 31 Oct     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > On 00:50 Thu 26 Oct     , Sasha Khapyorsky wrote:
> >> This adds support for partial svn imports. Let's assume that SVN
> >> repository layout looks like:
> >> 
> >>   $trunk/path/to/our/project
> >>   $branches/path/to/our/project
> >>   $tags/path/to/our/project
> >> 
> >> , and we would like to import only tree under this specific
> >> 'path/to/our/project' and not whole tree under $trunk, $branches, etc..
> >> Now we will be be able to do it by using '-P path/to/our/project' option
> >> with git-svnimport.
> >> 
> >> Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
> >
> > Any news about status of this patch?
> 
> Somebody mentioned this duplicates something that can be already
> done, and I saw you refuted that.  At that point I thought then
> it would be Ok to add, and then I forgot about it.  Sorry.

No problem.

