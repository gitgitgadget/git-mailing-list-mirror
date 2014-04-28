From: David Kastrup <dak@gnu.org>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 11:02:16 +0200
Message-ID: <87r44h6d47.fsf@fencepost.gnu.org>
References: <535C47BF.2070805@game-point.net>
	<1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
	<535D3DF8.4020904@game-point.net>
	<535e12389eb8d_338911e930c9c@nysa.notmuch>
	<535E1622.70608@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:02:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehSC-0004No-4J
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbaD1JCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:02:20 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:58460 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbaD1JCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:02:18 -0400
Received: from localhost ([127.0.0.1]:57501 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WehS5-000332-04; Mon, 28 Apr 2014 05:02:17 -0400
Received: by lola (Postfix, from userid 1000)
	id 83F99E05FE; Mon, 28 Apr 2014 11:02:16 +0200 (CEST)
In-Reply-To: <535E1622.70608@game-point.net> (Jeremy Morton's message of "Mon,
	28 Apr 2014 09:49:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247254>

Jeremy Morton <admin@game-point.net> writes:

> On 28/04/2014 09:32, Felipe Contreras wrote:
>>>> some people to is to always merge with --no-ff, that way you see the branch
>>>> name in the merge commit.
>>>
>>> But surely, it's recommended with Git that you try to avoid doing
>>> --no-ff merges to avoid commit noise?
>>
>> Nope. Different people have different needs, there's no recommendation. If
>> anything, the recommendation is to do a ff merge, because that's the default.
>
> That's what I'm saying.  With an ff merge, you don't get the merge
> commit message telling you the branch name.

And I don't _want_ that branch name to be recorded.  The whole point of
a distributed version control system is that it's nobody else's business
how I organize my work before submitting it.

I don't want to have people tell me when submitting patches "but can't
you give this a better branch name?" and then have to use git
filter-branch or whatever else to get the branch name removed.

> As I said before, I usually consider my branch names useful
> information worth keeping around - I'm not sure why you don't.

It is _totally_ useless information in a distributed development model.
Why would or should anybody be concerned what private branches some
submitter has developed his patches in?

This is not a useful part of a commit.

-- 
David Kastrup
