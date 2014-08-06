From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] Documentation: git-init: --separate-git-dir: clarify
Date: Wed, 06 Aug 2014 10:35:31 -0700
Message-ID: <xmqqsil9msgs.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-5-git-send-email-linusarver@gmail.com>
	<xmqqiom6oabe.fsf@gitster.dls.corp.google.com>
	<20140806052129.GC12559@k0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF57t-0003XQ-N9
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbaHFRfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 13:35:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63528 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbaHFRfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 13:35:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9863D2EA75;
	Wed,  6 Aug 2014 13:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UaJFBXHhXz2f1WamoDnHPzTZ9NU=; b=N/Rt7N
	roaHxpJvaOPS/aRkidmP+RPICQCtd9k9Z5DiF2+MKf8VX35lIu7Ic/9qWBSfyhro
	vZx6ed/g7SWKBdFDEa4lF6MCkMmHO3n3R6BYEWJd4pN3LLmJvC0LHtxmUY0NrO3X
	T3mxLIo9G8TWtxye8BSfUI7tnzD+UW4Kn1EVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NPyDMLJpeM7EPwb050VdrbqCpWhIh2LG
	nzR50J57TRkoR7e7i1OtlsCPyz1wm/Aqr0JANVS4L1mj2U9jSssApDCxuUWRiLD5
	toEH8ZTMn5HF2KH4AIGjpsKlkXDHhTZpkLuls50G97bKtd8rYvcrwo/wA11FwvFg
	xqVAnVMCu3A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D45F2EA74;
	Wed,  6 Aug 2014 13:35:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC1F02EA62;
	Wed,  6 Aug 2014 13:35:33 -0400 (EDT)
In-Reply-To: <20140806052129.GC12559@k0> (Linus Arver's message of "Tue, 5 Aug
	2014 22:21:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11B9261C-1D90-11E4-A92B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254881>

Linus Arver <linusarver@gmail.com> writes:

> On Tue, Aug 05, 2014 at 03:12:21PM -0700, Junio C Hamano wrote:
>> Linus Arver <linusarver@gmail.com> writes:
>> 
>> > Signed-off-by: Linus Arver <linusarver@gmail.com>
>> > ---
>> 
>> You would need to work on your justification skills ;-) in the log
>> message.  What does this change "clarify" and in what way?
>
> Oops, sorry. I guess I should have written some more information in the
> commit message, something like this:
>
>     Use shorter sentences to describe what actually happens. We describe
>     what the term "Git symbolic link" actually means.
>
>     Also, we separate out the description of the behavioral change upon
>     reinitialization into its own paragraph.

Sounds very sensible.

>> >  Documentation/git-init.txt | 12 ++++++------
>> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
>> > index f21b85b..bf0a7ae 100644
>> > --- a/Documentation/git-init.txt
>> > +++ b/Documentation/git-init.txt
>> > @@ -57,12 +57,12 @@ DIRECTORY" section below.)
>> >  
>> >  --separate-git-dir=<git dir>::
>> >  
>> > -Instead of initializing the repository where it is supposed to be,
>> > -place a filesytem-agnostic Git symbolic link there, pointing to the
>> > -specified path, and initialize a Git repository at the path. The
>> > -result is Git repository can be separated from working tree. If this
>> > -is reinitialization, the repository will be moved to the specified
>> > -path.
>> > +Separate the Git repository from your working tree.  Instead of initializing the
>> > +repository as a directory to either `$GIT_DIR` or `./.git/`, create a text file
>> > +there containing the path to the actual repository.  This file acts as
>> > +filesystem-agnostic Git symbolic link to the repository.

While I agree that it is a very good idea to state "what it does,
what it is for" with the very first sentence of the paragraph,
"separate the git repository from your working tree" does not say
much more than the name of the option "--separate-git-dir" already
tells the reader.  And I do not offhand think of a better version
(and obviously I didn't think of any when the current text was
reviewed and committed).  The second sentence in your version is
definitely an improvement over the first and the second sentences of
the original ("where it is supposed to be" does not give any new
information to those who don't know, and does not help those who
already know).

Perhaps we can simply remove the first sentence from your version?

>> > +If this is reinitialization, the repository will be moved to the specified path.
>> >  
>> >  --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
