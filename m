From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Sat, 18 Jun 2005 22:43:04 +0100
Message-ID: <tnxekaz1guv.fsf@arm.com>
References: <tnxy899zzu7.fsf@arm.com>
	<Pine.LNX.4.21.0506171750180.30848-100000@iabervon.org>
	<2cfc4032050617152878b75c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 23:38:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djl1K-000764-Ch
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 23:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVFRVn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 17:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFRVn6
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 17:43:58 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:10149 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262169AbVFRVn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 17:43:56 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5ILgt6i019149;
	Sat, 18 Jun 2005 22:42:55 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id WAA12346;
	Sat, 18 Jun 2005 22:43:19 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sat, 18 Jun 2005 22:43:19 +0100
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050617152878b75c97@mail.gmail.com> (Jon Seymour's
 message of "Sat, 18 Jun 2005 08:28:58 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Jun 2005 21:43:19.0120 (UTC) FILETIME=[BDD74500:01C5744E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jon Seymour <jon.seymour@gmail.com> wrote:
> I also think it would be good if patches extracted from git
> repositories included some information about exactly where the patch
> was extracted from...something like...
>
> signed-off-by: Name <user@host.domain>
> ---
> commit: sha1 -> sha1
> tree: sha1 -> sha1
>
> The reason for including the commits is to allow the maintainer to
> track exactly where the a given rev of a patch was from. The reason
> for including the treeids is to allow appliers to verify that the
> patch has produced the same result as the patch submitter.

See my (long) reply to Daniel. A StGIT patch is a collection of git
commits, mixed in time with commits for other patches. There might not
be a single author. For example, I create a patch called
'stabilisation' where I gather different git changesets from different
authors and commit them one by one.

I think what you mean is similar to the cg-mkpatch command. The 'stg
export' is totally different. While it might be possible to generate a
set of changesets for a StGIT patch, this is not intended for the near
future.

-- 
Catalin

