From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Re: Status after 'git clone --no-checkout' ?
Date: Fri, 02 Dec 2011 08:53:03 +0100
Message-ID: <jba050$uhs$1@dough.gmane.org>
References: <jb59h0$p3e$1@dough.gmane.org> <20111201190058.GC2873@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 08:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWNw1-0004Db-1I
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 08:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab1LBHxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 02:53:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:37555 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab1LBHxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 02:53:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RWNvr-0004Bd-7U
	for git@vger.kernel.org; Fri, 02 Dec 2011 08:53:19 +0100
Received: from 93.92.134.38 ([93.92.134.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 08:53:19 +0100
Received: from norbert.nemec by 93.92.134.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 08:53:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 93.92.134.38
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111201190058.GC2873@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186212>

Thanks a lot for this concise explanation -- exactly what I was hoping for!


Am 01.12.11 20:00, schrieb Jeff King:
> On Wed, Nov 30, 2011 at 02:02:22PM +0100, norbert.nemec wrote:
>
>> what exactly is the status after 'git clone --no-checkout'? Is there
>> any straightforward way how one could end up in this state starting
>> from a regularly checked out repository?
>
> You have a HEAD which points to some actual commit, but no index or
> working tree. I don't think there is a particular name for this state.
>
> You can get something similar in an existing repo by deleting all of the
> working tree files and removing .git/index.
>
>> 'git checkout' without any further options serves to move from the
>> aforementioned special state to a regular checked out state.
>> Otherwise it never seems to do anything. Are there any other
>> situations where 'git checkout' on its own would have any effect?
>
> By itself, I don't think so. But you can use "git checkout -f" to
> discard changes in the index and working tree, setting them back to the
> state in HEAD.
>
> At one point, some people used "git checkout" as a no-op, because it
> would print the "ahead/behind" information with respect to the upstream.
> These days, that information is part of "git status", so I suspect
> people use that instead.
>
> -Peff
