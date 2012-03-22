From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 18:56:29 -0500
Message-ID: <4F6BBC2D.10204@gmail.com>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net> <4F6BB425.2010807@gmail.com> <20120322232723.GA15676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anjib Mulepati <anjibcs@hotmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArry-0003eX-2W
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463Ab2CVX4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 19:56:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43615 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab2CVX4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:56:32 -0400
Received: by yenl12 with SMTP id l12so2325996yen.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mkDvwz3VS+utGPnVyyRG1p1spwO1vQvgPIzaY7aR/sg=;
        b=zyOrmvWVDdPipn2MgAH30wYHkbiLvfPYAJ9fFdRY1SP9La/9XbwvT/yFnOd1XDGyge
         wDz7gtNmGP2wq2aZT+rrLN8fVmHwOiZjg9SJooqOHjWWiro1u1SGBZqOcp5CvzJ2GNPw
         YWT2+Fkfeg5JQ8tT4F8Vz3ac+y8zcrAVNQIbOydTequimHss0qCsB9SPG+mCduhBoKqI
         kEhpR8nB/FkBjrizFbgbwwlJ9zSmTo2iV/4ufaP6EIKKLSrgVCLXDGQxWwJGgxFw840m
         52Ck6mRhD/I9AbGo1PDDbd4e36MKsx8qZ/8X2BsHVixhr087bNEqJXeiyeiNZ8PXQtNb
         /PBw==
Received: by 10.60.0.226 with SMTP id 2mr12223349oeh.18.1332460590561;
        Thu, 22 Mar 2012 16:56:30 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id o9sm5404760obd.21.2012.03.22.16.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 16:56:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120322232723.GA15676@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193735>

On 3/22/2012 6:27 PM, Jeff King wrote:
> On Thu, Mar 22, 2012 at 06:22:13PM -0500, Neal Kreitzinger wrote:
>
>>> You have a repository inside a repository. So when you are in (c),
>>> you will be pushing the commits from (c), not from (a). I'm not
>>> really sure what you are trying to accomplish with that.
>>>
>> See this thread for the "cons" of nested git repos: (I don't think
>> there are any "pros".)
>> http://thread.gmane.org/gmane.comp.version-control.git/190372
>
> Nested git repos are OK. I use one inside my git.git checkout to hold
> meta-information and scripts (and I know Junio does the same thing). But
> I mark the sub-repository as ignored in the parent repository.  What's
> insane is trying to track the same set of files from two different
> repositories. And I think that is the confusing case in the thread you
> mentioned.
>
Yes, hopefully the nested git repo is ignored by the higher level git
repo.  However, if it was ignored I don't suspect one would be wondering
if it was ok to "only" push from the nested repo.  I could be wrong.

v/r,
neal
