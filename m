From: Stephen Bash <bash@genarts.com>
Subject: Re: Understanding git cherry-pick
Date: Wed, 10 Nov 2010 15:01:32 -0500 (EST)
Message-ID: <14344677.655207.1289419292378.JavaMail.root@mail.hq.genarts.com>
References: <20101110204323.0b675331@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Camille Moncelier <moncelier@devlife.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 21:01:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGrZ-00055b-7Z
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab0KJUBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:01:40 -0500
Received: from hq.genarts.com ([173.9.65.1]:32862 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754676Ab0KJUBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:01:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id CEDA21E26961;
	Wed, 10 Nov 2010 15:01:38 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hDzFJwFtZR3; Wed, 10 Nov 2010 15:01:32 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 75E261E26960;
	Wed, 10 Nov 2010 15:01:32 -0500 (EST)
In-Reply-To: <20101110204323.0b675331@cortex>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161178>

----- Original Message -----
> From: "Camille Moncelier" <moncelier@devlife.org>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Wednesday, November 10, 2010 2:43:23 PM
> Subject: Re: Understanding git cherry-pick
>
> On Wed, 10 Nov 2010 09:04:29 -0500 (EST)
> Stephen Bash <bash@genarts.com> wrote:
> 
> > git status reported the actual change we wanted from the commit
> > applied cleanly; the conflicts were all added/deleted files between
> > the two branches. The commit only modifies a single file, and the
> > file exists with the same name on both branches.
> >
> > So what's actually going on here? If the one changed file in the
> > commit merged cleanly, why did the automatic cherry-pick fail? Why
> > does cherry-pick even care about file differences between the two
> > branches that aren't modified by the commit in question? Or is it
> > user error?
> 
> Which version are you using ?

1.7.3 on the machine I reproduced the issue on...  My coworker has something post-1.7.2 but I'm not exactly sure.

Thanks,
Stephen
