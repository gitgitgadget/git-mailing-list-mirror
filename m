From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Mon, 23 Feb 2015 17:24:58 +0100
Message-ID: <54EB545A.2040309@drmicha.warpmail.net>
References: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net> <54EB436E.9060106@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:25:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvpF-0007hC-3k
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbbBWQZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:25:01 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48550 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149AbbBWQZA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 11:25:00 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E742C20877
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 11:24:58 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 23 Feb 2015 11:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KblIbukZYMwo3NMftQJF4J
	6TE7g=; b=VO3DBBL65u8FQ7gKiRiVROSQAUUuBVNSTMtElRmJoM4WFwM/Ld5Dgg
	B3JARw3EBwj6Y/9Pwi81MoeO6kPyHX5SvelK5WqFcMUbYr3wSOYfdWKneKrIzlzc
	dJRg2aYOZjSNxwrbyHZKIyMdcDnKG37+qR+xXhXlLePUivql7bPC8=
X-Sasl-enc: YjSoH0djV+CpPXeFYAA3oKaFnFV/8V7mdQuEiFOKpDIK 1424708699
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 290DFC002A4;
	Mon, 23 Feb 2015 11:24:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54EB436E.9060106@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264272>

Marc Branchaud venit, vidit, dixit 23.02.2015 16:12:
> On 15-02-22 12:38 PM, Michael J Gruber wrote:
>> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
>> ref depending on whether the detached HEAD has moved since. "git branch"
>> always uses "from", which can be confusing, because a status-aware user
>> would interpret this as moved detached HEAD.
>>
>> Make "git branch" use the same logic and wording.
> 
> Except that the wording in "git branch" is more correct, especially if the
> detached HEAD contains new commits.
> 
> In other words, "at" is only correct if the detached HEAD matches the ref.
> If the HEAD has other commits, it is no longer "at" that ref but instead it
> has grown "from" it.

Sure, but that's exactly what git status does. Haven't you tried out?

And it's exactly what I suggest for git branch. It conveys more information.

> But even if the detached HEAD matches the ref, saying it came "from" that ref
> (with 0 extra commits) is still better than saying
> detached-HEAD-with-extra-commits is "at" the ref.

Why? Both are true. "at" conveys the additional information that HEAD is
still at the that rev.

Michael
