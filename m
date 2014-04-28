From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 09:49:38 +0100
Message-ID: <535E1622.70608@game-point.net>
References: <535C47BF.2070805@game-point.net> <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com> <535D3DF8.4020904@game-point.net> <535e12389eb8d_338911e930c9c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:49:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehFr-00044v-TT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbaD1Itg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:49:36 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:57102 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbaD1Itf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:49:35 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 85C0318A09AC;
	Mon, 28 Apr 2014 03:57:23 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <535e12389eb8d_338911e930c9c@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247248>

On 28/04/2014 09:32, Felipe Contreras wrote:
>>> some people to is to always merge with --no-ff, that way you see the branch
>>> name in the merge commit.
>>
>> But surely, it's recommended with Git that you try to avoid doing
>> --no-ff merges to avoid commit noise?
>
> Nope. Different people have different needs, there's no recommendation. If
> anything, the recommendation is to do a ff merge, because that's the default.

That's what I'm saying.  With an ff merge, you don't get the merge 
commit message telling you the branch name.

>> Also, it is a lot more hassle (and no doubt, CPU cycles) to track down where
>> a branch was merged to try and figure out which branch name a commit
>> pertained to, not to mention the fact that the commit could've been moved
>> since.  Nothing short of tagging the commit with the branch name when the
>> commit is made will definitely record the branch name at the time of
>> committing.
>
> But why do you need that information?

As I said before, I usually consider my branch names useful information 
worth keeping around - I'm not sure why you don't.  I might include a 
bug# in the branch name so I don't have to keep typing it in every 
commit message, or I might just have a handy short description of what 
part of the application this branch is modifying (like my 
"pacman-minigame" example).

-- 
Best regards,
Jeremy Morton (Jez)
