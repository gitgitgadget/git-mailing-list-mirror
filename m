From: Paul Ebermann <Paul-Ebermann@gmx.de>
Subject: Re: Command-line interface thoughts
Date: Sun, 05 Jun 2011 23:22:47 +0200
Message-ID: <4DEBF3A7.9090705@gmx.de>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 23:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTKn5-0003eM-PI
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 23:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab1FEVXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 17:23:18 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:44416 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754650Ab1FEVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 17:23:18 -0400
Received: (qmail invoked by alias); 05 Jun 2011 21:23:15 -0000
Received: from p5B3FB360.dip.t-dialin.net (EHLO [192.168.1.51]) [91.63.179.96]
  by mail.gmx.net (mp011) with SMTP; 05 Jun 2011 23:23:15 +0200
X-Authenticated: #2289940
X-Provags-ID: V01U2FsdGVkX18RsOZYvrQRjCOhct1a4TOZ2I0UBicV83tj+jv6Ya
	4vLZNB7UUW+ROL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <201106051311.00951.jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175084>

Jakub Narebski skribis:
> On Sun, 5 Jun 2011, Michael Nahas wrote:
>> On Sat, Jun 4, 2011 at 5:49 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> Michael Nahas <mike.nahas@gmail.com> writes:
[...]
>>>> "stash save"
>>>>    STASH = new(new(HEAD+(NEXT-HEAD))+WTREE-NEXT)
>>>>    NEXT = HEAD
>>>>    WTREE = HEAD
>>>>    push(STASH)
>>>> "stash pop"
>>>>    STASH = pop()
>>>>    WTREE = HEAD + (STASH-STASH^^)
>>>>    NEXT = HEAD + (STASH^-STASH^^)
>>>
>>> ???
>>
>> "stash save" makes two new consecutive commits: one equal to NEXT and
>> another equal to WTREE.
> 
> No, "stash save" doesn't make two _consecutive_ commits.  It makes
> a commit which has state of worktree as one parent, and state of index
> as other parent (i.e. a merge commit).

Hmm, for me it always looked like one commit with the index state as
content and HEAD as parent, and second one with the Worktree as content,
and both HEAD and the mentioned index commit as parent.

This is technically a merge commit (as it has two parents), but not
really done as a merge.


Paul
