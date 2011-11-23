From: Stephen Bash <bash@genarts.com>
Subject: Re: svn to git with non-standard layout
Date: Wed, 23 Nov 2011 15:22:14 -0500 (EST)
Message-ID: <2d5f33eb-c1dc-491a-a8ed-e8ceaaf2e2b1@mail>
References: <jajh7m$it7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
X-From: git-owner@vger.kernel.org Wed Nov 23 21:29:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJRx-0005WL-9m
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab1KWU3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:29:38 -0500
Received: from hq.genarts.com ([173.9.65.1]:50412 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754109Ab1KWU3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 15:29:37 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Nov 2011 15:29:37 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id CD340BE64C8;
	Wed, 23 Nov 2011 15:22:20 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d0ZzKXQI2Ftp; Wed, 23 Nov 2011 15:22:14 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B9120BE64C7;
	Wed, 23 Nov 2011 15:22:14 -0500 (EST)
In-Reply-To: <jajh7m$it7$1@dough.gmane.org>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC15 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185870>

----- Original Message -----
> From: "Bernd Schubert" <bernd.schubert@itwm.fraunhofer.de>
> To: git@vger.kernel.org
> Sent: Wednesday, November 23, 2011 2:23:34 PM
> Subject: svn to git with non-standard layout
> 
> So we have something like this:
> 
> svn-root -> main-project
>              /       |    \
>             /        |     \
>            proj1    proj2   proj{n}
>           /    \     /   \    /    \
>          /      \   /     \  trunk  tags
>         /       \ trunk   tags
>         trunk   tags
>                 /   \
>                tag1 tag{2...n}

Just for clarification: are there files and/or directories in main-project that are not sub-projects?

Thanks,
Stephen
