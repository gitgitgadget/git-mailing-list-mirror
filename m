From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Sat, 08 Aug 2009 09:12:54 -0700
Message-ID: <7v8whul1x5.fsf@alter.siamese.dyndns.org>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
 <7v4osj1odt.fsf@alter.siamese.dyndns.org> <4A7D7CF2.40902@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Sat Aug 08 18:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZoXa-0005wL-T5
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 18:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbZHHQM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 12:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbZHHQM7
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 12:12:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZHHQM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 12:12:58 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8BBE315A;
	Sat,  8 Aug 2009 12:12:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C98133158; Sat,  8 Aug
 2009 12:12:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56C82A26-8436-11DE-AD20-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125284>

Ori Avtalion <ori@avtalion.name> writes:

> On 08/07/2009 09:15 PM, Junio C Hamano wrote:
>> Ori Avtalion<ori@avtalion.name>  writes:
>>
>>> Most of the docs and printouts refer to "commands".
>>> This patch changes the other terminology to be consistent.
>>
>> Thanks, but not really.
>>
>>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>>> index d313795..20bf512 100644
>>> --- a/Documentation/fetch-options.txt
>>> +++ b/Documentation/fetch-options.txt
>>> @@ -1,7 +1,7 @@
>>>   -q::
>>>   --quiet::
>>>   	Pass --quiet to git-fetch-pack and silence any other internally
>>> -	used programs.
>>> +	used utilities.
>>
>> This does not have much to do with what you claim to have done in the
>> commit log message nor the title.  Probably "utilities" is a slightly
>> better word than "programs" in this context but not by a wide margin.
>
> If that doesn't fit,...

My comment on this part was not "Don't change this wording, the original
is much better", but was primarily "you said this commit is about
replacing 'program' with 'command' for consistency, but this change does
not belong to that category.  Either make a separate commit for this
change separate from all the rest, or change the wording of the commit log
message to cover this one as well".

>    "Pass --quiet to git-fetch-pack and silence other output" ?
>
>>> -'git-rev-list' is a very essential git program, since it
>>> +'git-rev-list' is a very essential git command, since it
>>>   provides the ability to build and traverse commit ancestry graphs. For
>>>   this reason, it has a lot of different options that enables it to be
>>>   used by commands as different as 'git-bisect' and
>>
>> Ok, but probably we would want to say "git rev-list" here.
> ...
> I see the "git-foo" notation as a convention for git commands.
> It may be for historical reasons, but the manpage for the "pull" git
> command is "git-pull", and that is how commands are mentioned all over
> the documentation.

This was "because you are changing the exact sentence anyway, why not do
this while you are at it".  But you are probably right.  We try to write
"git foo" when we talk about what users would type, but say "git-foo" when
we talk about the command itself.  When we talk about the concept of what
the command achieves, we sometimes say just "foo".

> In git.txt:
> "The following are helper programs used by the above"
>                           ^^^^^^^^
>                           commands
>
> In git-mailsplit.txt (and cmds-purehelpers.txt):
>    "Simple UNIX mbox splitter program."
>
> Maybe the word "program" should just be dropped.

That may be an option and I kind of like it; but I'd rather hear from
others first.
