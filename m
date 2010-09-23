From: Stephen Bash <bash@genarts.com>
Subject: Re: Find out on which branch a commit was originally made) (was
 ANNOUNCE git-what-branch)
Date: Thu, 23 Sep 2010 09:14:14 -0400 (EDT)
Message-ID: <32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com>
References: <201009222326.o8MNQJ2E022410@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org,
	Artur Skawina <art.08.09@gmail.com>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Thu Sep 23 15:14:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyldM-0007Hl-Hp
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 15:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab0IWNOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 09:14:22 -0400
Received: from hq.genarts.com ([173.9.65.1]:18541 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753342Ab0IWNOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 09:14:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4D9CB1E26947;
	Thu, 23 Sep 2010 09:14:20 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gavdnup8078l; Thu, 23 Sep 2010 09:14:14 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1293F1E262F9;
	Thu, 23 Sep 2010 09:14:14 -0400 (EDT)
In-Reply-To: <201009222326.o8MNQJ2E022410@no.baka.org>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156867>

----- Original Message -----
> From: "Seth Robertson" <in-gitvger@baka.org>
> To: "Artur Skawina" <art.08.09@gmail.com>
> Cc: "Stefan Haller" <lists@haller-berlin.de>, git@vger.kernel.org
> Sent: Wednesday, September 22, 2010 7:26:19 PM
> Subject: Re: Find out on which branch a commit was originally made) (was ANNOUNCE git-what-branch)
>
> ... I wanted something completely different. Something more
> like: if a bug was introduced in commit X, what releases or branches
> has it contaminated (or more positively, if a feature was introduced,
> where was it made available). The simple case is figuring out on
> which branch a commit was originally made.

Wait... When you restate the problem that way, isn't git-{branch,tag} --contains the right answer?  I'm curious how you (and others) would differentiate the approaches...

If I were to frame this discussion, I think the value of git-what-branch is the ability to extract the branch name that a commit was created on.  In many environments the branch name may be useless (see the i18n example earlier in this discussion), but at least in our corporate environment, branches (especially those that are going to merge into mainline development) are named very consistently.  So in our situation the branch name can produce information that may not be captured in the standard reporting products (branch names transform into conventional tag names, branch names imply a lead developer, branch names spur developers' memories, ...).

Stephen
