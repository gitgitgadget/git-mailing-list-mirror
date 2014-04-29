From: David Lang <david@lang.hm>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 14:58:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1404291456080.14881@nftneq.ynat.uz>
References: <535C47BF.2070805@game-point.net> <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com> <535D3DF8.4020904@game-point.net> <535e12389eb8d_338911e930c9c@nysa.notmuch> <535E1622.70608@game-point.net> <87r44h6d47.fsf@fencepost.gnu.org>
 <535E1AF6.8080609@game-point.net> <87fvkx6c4z.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:58:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG2f-0004lN-FK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641AbaD2V6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:58:18 -0400
Received: from mail.lang.hm ([64.81.33.126]:51940 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116AbaD2V6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:58:17 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s3TLw82U020308;
	Tue, 29 Apr 2014 14:58:08 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <87fvkx6c4z.fsf@fencepost.gnu.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247617>

On Mon, 28 Apr 2014, David Kastrup wrote:

> Jeremy Morton <admin@game-point.net> writes:
>
>> On 28/04/2014 10:02, David Kastrup wrote:
>>> Jeremy Morton<admin@game-point.net>  writes:
>>>
>>>> On 28/04/2014 09:32, Felipe Contreras wrote:
>>>>>>> some people to is to always merge with --no-ff, that way you see the branch
>>>>>>> name in the merge commit.
>>>>>>
>>>>>> But surely, it's recommended with Git that you try to avoid doing
>>>>>> --no-ff merges to avoid commit noise?
>>>>>
>>>>> Nope. Different people have different needs, there's no recommendation. If
>>>>> anything, the recommendation is to do a ff merge, because that's the default.
>>>>
>>>> That's what I'm saying.  With an ff merge, you don't get the merge
>>>> commit message telling you the branch name.
>>>
>>> And I don't _want_ that branch name to be recorded.  The whole point of
>>> a distributed version control system is that it's nobody else's business
>>> how I organize my work before submitting it.
>>
>> Well it would be optional, so obviously you wouldn't be forced to
>> share the branch name.  It's not like we're trying to "pry in" to your
>> private development.  It's a way of choosing to share what you may
>> consider to be useful contextual information about the commit.

It sounds like what you want is really a template for a commit message that lets 
you include arbitrary information in that template, including things like branch 
name that may not make sense for other people.

If there is no commit message, populate the template and show that to the user 
in their editor.

If there is a commit message, don't touch it.

Then people can use whatever they want (including environment variables) as part 
of their messages.

David Lang
