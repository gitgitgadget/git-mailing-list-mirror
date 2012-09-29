From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: use abbreviated sha1 in 'status' output
Date: Sat, 29 Sep 2012 17:05:29 +0200
Message-ID: <50670E39.8080101@web.de>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com> <1348926195-4788-2-git-send-email-artagnon@gmail.com> <50670655.3030600@web.de> <CALkWK0kzZvPv9jFBF=ibMzcNt-jxq4RFjy7pL173+Y4_S0jhWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 17:05:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THybu-0000KM-1t
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 17:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab2I2PFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 11:05:32 -0400
Received: from mout.web.de ([212.227.15.3]:55259 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450Ab2I2PFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 11:05:31 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LopMx-1Tx5uc1LLv-00gfVk; Sat, 29 Sep 2012 17:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CALkWK0kzZvPv9jFBF=ibMzcNt-jxq4RFjy7pL173+Y4_S0jhWA@mail.gmail.com>
X-Provags-ID: V02:K0:il2orYYy24G1l7nKOxRWQiZ0PFypQqeiKVysDFEPEl2
 DZZpQAAjWjPZZq30KI6P/XwQZUeuaM+l2rVzde9qmy4AxxZJj9
 vI0KplyqRqrx9938bxi3d3g5gQZ6HtvqVT3WB+PZc+sj/CHOLx
 NUrYOSDN7uTadrtGv9qrthC+GfI+xDvfjUPyr/iNFxWZDTsQ2l
 iTTJ6ambLRXzespgPt6OQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206652>

Am 29.09.2012 16:45, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> I'm not against the change per se, but do we really want to risk breaking
>> scripts which parse the output of "git submodule status" without even
>> providing a commit message explaining why we did that?
> 
> Oh, I didn't realize that there might be such scripts.  What
> justification do I give in the commit message apart from
> prettification?

Is a prettification justification enough to break backwards compatibility
and to risk breaking scripts and user expectations? I think we must have
a really good reasons to do that, and just making stuff prettier doesn't
count for me unless we have a strong user demand for that.

I suspect you got the idea for this patch from Marc's recent comment:

Am 24.09.2012 17:07, schrieb Marc Branchaud:
> (Honestly, submodule's status sub-command has always felt more like plumbing
> to me than something a user would work with directly.  Maybe it's just the
> full-length SHA's that put me off...)

That is just a single user so far indicating your patch /could/ be an
improvement. I think we need quite some more votes on that before we
should do a change like this.
