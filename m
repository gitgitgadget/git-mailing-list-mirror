From: Tim Chase <git@tim.thechases.com>
Subject: Re: Archiving off old branches
Date: Wed, 23 Apr 2014 13:06:19 -0500
Message-ID: <20140423130619.495e5e6b@bigbox.christie.dr>
References: <20140423120850.3f6fb535@bigbox.christie.dr>
	<20140423175820.GE15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tim Chase <git@tim.thechases.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 20:06:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1ZC-0008Lt-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 20:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbaDWSG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 14:06:26 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:36419 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750926AbaDWSGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2014 14:06:25 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:34149 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <git@tim.thechases.com>)
	id 1Wd1Yv-000Ac4-HJ; Wed, 23 Apr 2014 13:06:25 -0500
In-Reply-To: <20140423175820.GE15516@google.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246862>

On 2014-04-23 10:58, Jonathan Nieder wrote:
> Tim Chase wrote:
> >   cd .git/refs
> >   mkdir -p closed
> >   mv heads/BUG-123 closed
> 
> That breaks with packed refs (see git-pack-refs(1)), which are a
> normal thing to encounter after garbage collection.
> 
> Hope that helps,

Very much so.  Alrighty...based on that alone, I'll stick to my
archive script that calls update-ref and then deletes the branch.

Thanks,

-tkc
