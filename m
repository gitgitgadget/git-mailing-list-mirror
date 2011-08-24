From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [RFC] branch: list branches by single remote
Date: Wed, 24 Aug 2011 18:02:52 +0200
Message-ID: <4E5520AC.7050407@elegosoft.com>
References: <4E383132.3040907@elegosoft.com> <20110804040646.GA5104@sigill.intra.peff.net> <4E4A729D.9030906@drmicha.warpmail.net> <20110816151448.GA5152@sigill.intra.peff.net> <4E551548.9090807@elegosoft.com> <4E551AD0.7050702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 18:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFvE-0004bT-Dm
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 18:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab1HXQDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 12:03:16 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:54785 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab1HXQDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 12:03:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 20F14DE87F;
	Wed, 24 Aug 2011 18:03:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KSJPhneWXxCu; Wed, 24 Aug 2011 18:03:08 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id BD3D0DE87E;
	Wed, 24 Aug 2011 18:03:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E551AD0.7050702@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180014>

On 08/24/2011 05:37 PM, Michael J Gruber wrote:
> Michael Schubert venit, vidit, dixit 24.08.2011 17:14:
>> On 08/16/2011 05:14 PM, Jeff King wrote:
>>> On Tue, Aug 16, 2011 at 03:37:33PM +0200, Michael J Gruber wrote:
>>>
>>>>> This isn't right. You are assuming that a remote called "foo" will have
>>>>> all of its branches in refs/remotes/foo. That's true under the default
>>>>> configuration, but technically speaking, the remote tracking branches of
>>>>> "foo" are defined by the right-hand side of foo's fetch refspecs.
>>>>
>>>> You are 100% right here, but...
>>>>
>>>>> So I think you want something more like this:
>>>>
>>>> ...the op still might want to filter simply by the remote name.
>>>
>>> That is a perfectly reasonable approach. It just should be called
>>> "--glob" or something, and not "remote".  git-tag allows patterns to an
>>> explicit "tag -l", but "-l" is already taken for git-branch.
>>
>> As suggested, I've just called it "--glob" for now.
> 
> Well, again, what's the point in replicating
> 
> http://permalink.gmane.org/gmane.comp.version-control.git/172228
> 
> and how is it different?

While I just haven't seen this,

> As I've mentioned, I've been in the middle of polishing that up. You can
> follow it if you like:
> 
> http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/branch-list-pattern

I thought I just send it out not knowing you're actually into resurrecting
the "patterns-with-branches series".

Thanks.
