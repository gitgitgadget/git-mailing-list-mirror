From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 10:10:32 -0700
Message-ID: <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 19:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMnJ3-00082P-LU
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 19:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYGZRKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 13:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbYGZRKl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 13:10:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYGZRKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 13:10:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACE8641544;
	Sat, 26 Jul 2008 13:10:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 700E941540; Sat, 26 Jul 2008 13:10:35 -0400 (EDT)
In-Reply-To: <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
 (Scott Chacon's message of "Fri, 25 Jul 2008 17:59:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C4F7F074-5B35-11DD-B3BA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90262>

"Scott Chacon" <schacon@gmail.com> writes:

> On Fri, Jul 25, 2008 at 4:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> I find a tabular list like this list easier to read if it were sorted like
>> this:
>>
>>        A       D       G
>>        B       E       H
>>        C       F
>> ...
>
> I fixed the things you mentioned here, except for the list ordering,
> only because I kinda think you big contributors should be at the top
> there,...

If you are going to list 30 or so top contributors in 8 rows times 4
columns, because visually the columns are much more distinct than the
rows, it makes the result look more sorted.  This is the same reasoning
hwo "git help --all" was fixed with 112d0ba (Make "git help" sort git
commands in columns, 2005-12-18).

By the way, I think this shows another issue with the "rest of us" list in
the lower half.

I have a mild suspicion that sorting that list in alphabetical order may
actually make it much better.  It all depends on the purpose of that list,
though.

The purpose of the list would most likely not to find somebody with high
activity to contact for help (you would use the top list that is sorted by
the commit count for that kind of thing).  It would primarily be to give
credit to everybody, and perhaps so that people on the contributor list
can point at their own name and say "I helped them", or find somebody else
they happen to know in the list.

When a contributor used to have 8 commits and then adds 2 commits, that
would move the name in the list by a dozen places or so with the current
set of contributors.  It would be much easier to locate one's own name
among a huge list if the names are alphabetically sorted, not by commit
count.  When more people start to contribute, your name does not move so
drastically.  If you are Adam, you are likely to find yourself near the
beginning of the list, if you are Scott, you are likely to find yourself
near one fourth from the end of the list.

And for the "giving credit" purpose, I do not think truncating the list at
5 commits or less threshold, as suggested earlier and already done, makes
much sense, either.
