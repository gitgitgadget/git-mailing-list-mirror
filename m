From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] glossary: a revision is just a commit
Date: Sun, 21 Apr 2013 12:00:45 -0700
Message-ID: <7vy5cbso82.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-4-git-send-email-artagnon@gmail.com>
	<20130420222528.GA10043@elie.Belkin>
	<CALkWK0n7e-GQ8eBjgd4pnB5AzLGN0bik-n8_McbK68CvJh6P=A@mail.gmail.com>
	<20130421074118.GE10429@elie.Belkin>
	<CAPc5daVcovqrHP-YWnkcQWwev5TW5S8ioX-bWyAnNG2PTg_XMw@mail.gmail.com>
	<20130421081705.GG10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Ackermann <th.acker@arcor.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 21:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTzVg-00053k-HL
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 21:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab3DUTBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 15:01:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab3DUTAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 15:00:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D24817494;
	Sun, 21 Apr 2013 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QILDTr0PoHZ2MYGE5XdFRXup7ao=; b=eadNsWvpV+IO4GbsYY3L
	lMkvlkmYLlA3VcLmZx9KHxcwAasotilhvpM0E2HG4b9Cml/3KISto4FYg0NKzNS5
	5CKzPfwbsjpx1HQ8RbIeEKSAnNQneCriHDDEmcJd9QFXl8x6PUPtLLvTvG64CB3v
	GxhH0IerII2XjS8xSJSrvYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=I8nkGrhpWQyh8G37FbCXDzYiJDe5uVB/n2/7Hu5h10iK+x
	BMoBADe5oyOBlF37HIM2JInSmQ6V+Ow+3BnQIvaNoB0yWuDnmN7xOtNRcn3fAkkj
	4dS8B3uFRnEiJpB7IXonuYrwnAyOP9lJjp8TpNea/8Jmf/dFIdgTj7DF/vRM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 405281748C;
	Sun, 21 Apr 2013 19:00:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ABD517486;
	Sun, 21 Apr 2013 19:00:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6CF127C-AAB5-11E2-8A83-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221964>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The current definition of 'revision' sounds like it is saying that a
> revision is a tree object.  In reality it is just a commit.
>
> This should be especially useful for people used to other revision
> control systems trying to see how familiar concepts translate into git
> terms.
>
> Reported-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

I think the existing glossary text is just confusing (it does wants
to refer to a commit (noun) as a concept, as opposed to its concrete
realization, i.e. a commit object, and tries to do so but does a bad
job).

Your update is an improvement, but there may need a note that says
that various web pages and documents, especially historical ones
[*1*], may loosely use this word to refer to any single object that
is not necessarily a commit at times.

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index eb7ba84f..521fceeb 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -430,9 +430,7 @@ should not be combined with other pathspec.
>  	<<def_merge,merge>> left behind.
>  
>  [[def_revision]]revision::
> -	A particular state of files and directories which was stored in the
> -	<<def_object_database,object database>>. It is referenced by a
> -	<<def_commit_object,commit object>>.
> +	Synonym for <<def_commit,commit>> (the noun).
>  
>  [[def_rewind]]rewind::
>  	To throw away part of the development, i.e. to assign the


[Footnote]

*1* The "rev-parse" command started as a tool to parse "revisions" aka
"commit", "revision range" e.g. "A..B" and non-revisions (pathspecs)
and flags.  It was primarily designed as a way to sift arguments
given to "git mylog -p A..B Makefile", so that a scripted "mylog"
can turn it into a pipeline that feeds "git rev-list A..B Makefile"
output as the input to "git diff-tree -p --stdin Makefile".

This was back when we did not even have non-committish extended
SHA-1 object name notation.  From the very start, "rev" in the name
"rev-parse" did not even mean that it is limited to "revision" aka
"commit".  Later we added tree:path form of extended SHA-1 notation
and "rev-parse --verify $it" has become its primary usage, while its
role as argument sifter has diminished as we made "log" a built-in,
not a pipeline.  Around that time, we loosely started calling
anything that get_sha1() can turn into an object name a "revision".

Also 99.9% of the time people use it to parse committish in real
life.

For these reasons, I do not think it is wise to rename "rev-parse"
to "object-name-parse".  "rev" in "rev-parse" may be related to
"revisions", and while it technically can operate on "revisions" (in
the colloquial "object name" sense), it is not limited to revisions.
And when it is used for revisions it mostly is used for "revisions"
(in the "nothing but committish" sense).  The name that most
faithfully reflects the use of the command is "git kitchen-sink"
these days.

The user still needs to know that in some context, "revision" may
loosely refer to "object name" when talking about a single object,
if only to understand the name of that command, let alone various
tutorials, screencasts and web resources people made over time.
