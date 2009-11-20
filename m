From: david@lang.hm
Subject: Re: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 17:55:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0911191754540.10307@asgard.lang.hm>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com>
 <20091120014843.GB22556@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: George Dennie <gdennie@pospeople.com>,
	"'Jason Sewall'" <jasonsewall@gmail.com>,
	"'Jakub Narebski'" <jnareb@gmail.com>,
	"=?ISO-8859-15?Q?'Jan_Kr=FCger'?=" <jk@jk.gs>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 02:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIjY-0000ty-FH
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbZKTB4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758068AbZKTB4N
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:56:13 -0500
Received: from mail.lang.hm ([64.81.33.126]:32800 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757527AbZKTB4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:56:12 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id nAK1tLU6006412;
	Thu, 19 Nov 2009 17:55:21 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20091120014843.GB22556@dpotapov.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133295>

On Fri, 20 Nov 2009, Dmitry Potapov wrote:

> On Wed, Nov 18, 2009 at 09:03:31PM -0500, George Dennie wrote:
>>
>> For example, the functional notion of the repository seems well
>> defined: a growing web of immutable commits each created as either an
>> isolated commit or more typically an update and/or merger of one or
>> more pre-existing commits.
>
> In Git, commits are not immutable. One thing that many Git users do
> is git-rebase, which in essense is re-writing or re-ordering exising
> commits. So, you can change history in Git, but you should never change
> the published history. (Of course, that leads to the question what is
> considered as published history. For instance, commits merged on the
> proposed-updates branch are usually not considered to be "published",
> so they can be re-written or discarded later).
>
> So, the correct way to use Git is to find the right balance between
> the need to clean up after mistakes (using git-rebase) and not doing
> too much, so you will not lose important history or create problems
> for other peoples.

the typical advice is to clean up before you make changes public, but not 
afterwords.

David Lang

>>
>> The notion of a shapeless commit is curious. Intuitively, I consider a
>> commit as capturing the state of my work at a transactional boundary
>> (i.e. a successful unit test...or even lunch break).
>
> No, it is not what Git commits were intended for. In Git, a commit is
> a change intended to achieve some goal. Basically, you send a patch
> to maintainer, and you should explain what this patch does and why it
> is useful... If your explanation is "I have a lunch break now", it is
> very bad explanation, thus a bad patch.
>
>
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
