From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Documentation: git-init: flesh out example
Date: Wed, 06 Aug 2014 10:41:10 -0700
Message-ID: <xmqqoavxms7d.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-8-git-send-email-linusarver@gmail.com>
	<xmqqegwuoa7b.fsf@gitster.dls.corp.google.com>
	<20140806053428.GD12559@k0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF5DP-0002y6-09
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaHFRlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 13:41:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52971 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbaHFRlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 13:41:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B25352ED6B;
	Wed,  6 Aug 2014 13:41:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6bsKqx9fxgnLVHZYZeT4ynF1xd8=; b=wt8BQB
	OxbrVmf/XAinjeDl6MINFi7+3Y//QBAXjq6Xo6ufJWe9tSgWDIzwIOoyU3LKCekb
	C7hSLV1Y4wYO/+ERTtoKI8T2pT54y7Pyb7U4MyTlK9yAHZzWiHC8HhpBnxerjkRg
	zqVsymFmn339p3qgub0oXYvoKMc+35fyPnDIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jA2JNTefwtKu/EfBcoETmkE6/NW72yqx
	GlxbcOIeEcvqmOqShOtBAU9bXsGKKJJLvkgPFSnH/k4l55IE7DwxkuX6NXLNeN1B
	74/qAQzz/x5Rgj5lBzmmmew072RWy42xbmP5+ZsAXgBpbY1lJ2D7JNnzISWJFq/C
	Tchgc2bS4uk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A44D22ED6A;
	Wed,  6 Aug 2014 13:41:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1680B2ED62;
	Wed,  6 Aug 2014 13:41:14 -0400 (EDT)
In-Reply-To: <20140806053428.GD12559@k0> (Linus Arver's message of "Tue, 5 Aug
	2014 22:34:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC92D892-1D90-11E4-B205-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254882>

Linus Arver <linusarver@gmail.com> writes:

> On Tue, Aug 05, 2014 at 03:14:48PM -0700, Junio C Hamano wrote:
>> Linus Arver <linusarver@gmail.com> writes:
>> 
>> > Signed-off-by: Linus Arver <linusarver@gmail.com>
>> > ---
>> >  Documentation/git-init.txt | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
>> > index b94d165..16e9f9c 100644
>> > --- a/Documentation/git-init.txt
>> > +++ b/Documentation/git-init.txt
>> > @@ -138,10 +138,12 @@ Start a new Git repository for an existing code base::
>> >  $ cd /path/to/my/codebase
>> >  $ git init      <1>
>> >  $ git add .     <2>
>> > +$ git commit    <3>
>> 
>> I agree it is a good discipline to make the initial "pristine"
>> import immediately after "git add ." without doing anything else.
>> Perhaps the description below wants to make it more explicit?
>> 
>
> I could add a comment like the following:
>
>     For new repositories, creating a commit immediately after "git add
>     ." is good practice as it will cleanly separate any preexisting work
>     (done under some other VCS, for example) from any new work done with
>     git.
>
> Does this make sense? I am not sure how explicit you want it to be, or
> whether I captured what you wanted to be explained.

I was thinking more along the lines of

    <3> Record the pristine state as the first commit in the history.

which should suffice without becoming excessively verbose.

> Actually, I would like to know if anything is special about the
> "root-commit"...

As far as Git is concerned, they are just ordinary commits without
any parents.  A commit in Git can have zero or more parents, so from
that "structural" point of view, they are not that special.

They are considered special by users because they represent the
beginning of the project history.
