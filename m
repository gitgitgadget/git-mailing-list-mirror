From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Mon, 23 Mar 2009 09:19:57 -0700
Message-ID: <7v4oxk6wk2.fsf@gitster.siamese.dyndns.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
 <20090323144650.GA20058@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlmuA-0005L9-Rr
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbZCWQUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZCWQUG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:20:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZCWQUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:20:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A329A47EE;
	Mon, 23 Mar 2009 12:20:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 63287A47EB; Mon,
 23 Mar 2009 12:19:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 766B8062-17C6-11DE-9A7C-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114328>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Sat, Mar 21, 2009 at 12:58:33AM -0700, Junio C Hamano wrote:
> [...]
>> * fg/push-default (Mon Mar 16 16:42:52 2009 +0100) 2 commits
>>  - Display warning for default git push with no push.default config
>>  + New config push.default to decide default behavior for push
>> 
>> Replaced the old series with the first step to allow a smooth transition.
>> Some might argue that this should not give any warning but just give users
>> this new configuration to play with first, and after we know we are going
>> to switch default some day, start the warning.
>
> If you feel that talking about a possible future change is premature,
> you could omit that part of the second commit I guess, but I think
> printing some kind of warning is valuable.  Are you waiting for more
> input?  It seems that this topic is pretty dead now.
>
> Most people who get bitten by this directly are probably not active on
> this list so I don't think you will hear from many of them.

I have already judged that the cause of this series is good, and that is
why the series was even considered to be in git.git to begin with.  I also
looked at the code change in them, and I found it Ok, and that is why the
first one is queued in 'next'.

At this point we do not need "Yes, it is a good idea" from people, even
though "No, it is a horrible change because of such and such reasons"
could reverse its course, if the argument is new.

The reason the patch has been sitting in 'next' is entirely unrelated to
the above.  It is to hear from people about unintended side effects, if
any.  It's only been a week, isn't it?

Unlike documentation reformatting and other kinds of patches in which
potential breakages will not cause a disaster, push is one of the things
we would want to keep working for people.  In general, the more important
the area a patch touches, the patch needs to cook longer in 'next'.
