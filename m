From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 10:10:14 +0100
Message-ID: <535E1AF6.8080609@game-point.net>
References: <535C47BF.2070805@game-point.net>	<1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>	<535D3DF8.4020904@game-point.net>	<535e12389eb8d_338911e930c9c@nysa.notmuch>	<535E1622.70608@game-point.net> <87r44h6d47.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehZt-0006ZG-OV
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbaD1JKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:10:13 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:54968 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbaD1JKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:10:11 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 055F818A09AC;
	Mon, 28 Apr 2014 04:17:58 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <87r44h6d47.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247258>

On 28/04/2014 10:02, David Kastrup wrote:
> Jeremy Morton<admin@game-point.net>  writes:
>
>> On 28/04/2014 09:32, Felipe Contreras wrote:
>>>>> some people to is to always merge with --no-ff, that way you see the branch
>>>>> name in the merge commit.
>>>>
>>>> But surely, it's recommended with Git that you try to avoid doing
>>>> --no-ff merges to avoid commit noise?
>>>
>>> Nope. Different people have different needs, there's no recommendation. If
>>> anything, the recommendation is to do a ff merge, because that's the default.
>>
>> That's what I'm saying.  With an ff merge, you don't get the merge
>> commit message telling you the branch name.
>
> And I don't _want_ that branch name to be recorded.  The whole point of
> a distributed version control system is that it's nobody else's business
> how I organize my work before submitting it.

Well it would be optional, so obviously you wouldn't be forced to share 
the branch name.  It's not like we're trying to "pry in" to your private 
development.  It's a way of choosing to share what you may consider to 
be useful contextual information about the commit.

> I don't want to have people tell me when submitting patches "but can't
> you give this a better branch name?" and then have to use git
> filter-branch or whatever else to get the branch name removed.
>
>> As I said before, I usually consider my branch names useful
>> information worth keeping around - I'm not sure why you don't.
>
> It is _totally_ useless information in a distributed development model.
> Why would or should anybody be concerned what private branches some
> submitter has developed his patches in?

Why should anybody be concerned about what commit message some submitter 
has typed in for his commit?  They could just read the source code to 
see what has changed, right?

Because the commit message is a way for the submitter to try and make it 
easier for the people looking at the commit to understand what the 
commit is doing.  In the same way, a meaningful branch name may also 
make it easier for people looking at the commit to understand what it is 
doing, or what part of the application it is affecting, or what group of 
commits it is a part of.

-- 
Best regards,
Jeremy Morton (Jez)
