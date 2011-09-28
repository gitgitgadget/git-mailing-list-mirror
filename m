From: Stephen Bash <bash@genarts.com>
Subject: Re: error: addinfo_cache failed during merge
Date: Wed, 28 Sep 2011 11:24:11 -0400 (EDT)
Message-ID: <4364790.33608.1317223450994.JavaMail.root@mail.hq.genarts.com>
References: <26411548.33530.1317221043429.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:24:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vzu-00046B-S9
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 17:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab1I1PYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 11:24:30 -0400
Received: from hq.genarts.com ([173.9.65.1]:37418 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754811Ab1I1PYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 11:24:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4C080EA23C2
	for <git@vger.kernel.org>; Wed, 28 Sep 2011 11:24:18 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R+ynFQTD7p+U for <git@vger.kernel.org>;
	Wed, 28 Sep 2011 11:24:11 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1221CEA23B8
	for <git@vger.kernel.org>; Wed, 28 Sep 2011 11:24:11 -0400 (EDT)
In-Reply-To: <26411548.33530.1317221043429.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182332>

----- Original Message -----
> From: "Stephen Bash" <bash@genarts.com>
> To: "git discussion list" <git@vger.kernel.org>
> Sent: Wednesday, September 28, 2011 10:44:03 AM
> Subject: error: addinfo_cache failed during merge
>
> Unfortunately, during the merge, I got a bunch of errors like
> this:
> 
> error: addinfo_cache failed for path 'foo/bar.h'
> 
> So first, is this important?

Well, to my uneducated eye, it looks like the error just left the conflicts in the working copy rather than resolving them.  Running mergetool appears to have cleaned up the problems.

Thanks,
Stephen
