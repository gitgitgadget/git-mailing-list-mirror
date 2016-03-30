From: Stefan Beller <sbeller@google.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 23:05:09 -0700
Message-ID: <CAGZ79kZgyFVzTRpP1k7kj8GVCPBukS_muhd=Xs4gxcA3maW0fw@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	<xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
	<CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
	<20160330045554.GA11007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:05:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al9Fm-0004Zk-Cm
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 08:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbcC3GFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 02:05:12 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37731 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbcC3GFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 02:05:10 -0400
Received: by mail-ig0-f178.google.com with SMTP id l20so33091130igf.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=p7kETsls6sQfbUP2t/eKJfxQLGSkCyPWbns4sC2Nd8Q=;
        b=HMVMNNkzi+xdVXijB6m5L8/pmW6NaGEOP/0vRW0vbNAc7/UzXA0TuulBj1tO4JVaDw
         sjxS8bs8SILAwhmVFIlurfPZedfwZi6XAfqQNVYcwgt/CqVk8lMg+RKKoE8ZsBcMcbSG
         6furj+QTZwXn6OPHT241PIHP5qhsEkbY6q2meqUWa+95RQd2YYxY3hovUE97M7ZM0s2W
         t9gZbpm8BjeNWvm21hr2Eiw636rfLQXikCkw/FsNCZ+i+74Rqwf7xsiyquSqhJFH3jgS
         xqrJODOpL951pkGvUXo9ZAecsGwRnbRWjDkvPdABRM5N1f201LuAytEhARyYuCU6DtAN
         Eycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=p7kETsls6sQfbUP2t/eKJfxQLGSkCyPWbns4sC2Nd8Q=;
        b=bFMGfSHakZH6cfc45MpntaNdmOr6uwUyqx31mUMHQ3L2DsNLRtPyRgpsmYslQ0Lnjl
         2keomZI5RDquoT7DX/ubjeTIMfIiO91xlJ6B4hIgBWnN3NP5BrVWd4kJa0+0bVFL8oOS
         Jb/A+nq7d6ad/mLvvhzTpQHspgMZMd4YrAPEbP8SBnaScJ4+O/LeHfePjpeQXpKmF5Pe
         g5LciPyN9RWiklu5Qz+itTBeovef1ONd+coXKPzP7pwbMLDTS4gM34orqPHvrljv69/H
         xRYDCcnpalBnKDi3keFf7VU/Y7IDNlfPlHG+w/W3yt3gLw1gGAc4SBq1sg6852mXuKnN
         4jQg==
X-Gm-Message-State: AD7BkJJSv2V6c5e9cHk1ZzpoqhG9l8t4zsXL09TG2kwl+j3emsQfNiy+GZLDx1nlVs70OLNTNmajpK5i860o/ctf
X-Received: by 10.50.112.10 with SMTP id im10mr7618666igb.93.1459317909447;
 Tue, 29 Mar 2016 23:05:09 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 29 Mar 2016 23:05:09 -0700 (PDT)
In-Reply-To: <20160330045554.GA11007@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290272>

On Tue, Mar 29, 2016 at 9:55 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 29, 2016 at 04:05:57PM -0700, Jacob Keller wrote:
>
>> > This is what we want in both cases.
>> > And I would argue it would appease many other kinds of text as well, because
>> > an empty line is usually a strong indicator for any text that a
>> > different thing comes along.
>> > (Other programming languages, such as Java, C++ and any other C like
>> > language behaves
>> > that way; even when writing latex figures you'd rather want to break
>> > at new lines?)
>> >
>> > Thanks,
>> > Stefan
>>
>> This seems like a good heuristic. Can we think of any examples where
>> it would produce wildly confusing diffs? I don't think it necessarily
>> needs to be default but just a possible option when formatting diffs,
>> much like we already have today.
>
> One thing I like to do when playing with new diff ideas is to pipe all
> of "log -p" for a real project through it and see what differences it
> produces.
>
> Below is a perl script that implements Stefan's heuristic. I checked its
> output on git.git with:
>
>   git log --format='commit %H' -p >old
>   perl /path/to/script <old >new
>   diff -F ^commit -u old new | less

Wow, that's amazing! I'll toy around with it tomorrow. :)

>
> which shows the differences, with the commit id in the hunk header
> (which makes it easy to "git show $commit | perl /path/to/script" to
> see the new diff with more context.
>
> In addition to the cases discussed, it seems to improve C comments by
> turning:
>
>    /*
>   + * new function
>   + */
>   +void foo(void);
>   +
>   +/*
>     * old function
>     ...
>
> into:
>
>   +/*
>   + * my function
>   + */
>   +void foo(void);
>   +
>    /*
>     * old function
>     ...
>
> See 47fe3f6e for an example.
>
> It also seems to do OK with shell scripts. Commit e6bb5f78 is an example
> where it improves a here-doc, as in the motivating example from this
> thread. Similarly, the headers in 4df1e79 are much improved (though I'm
> confused why the final one in that diff doesn't seem to have been
> caught).
>
> I also ran into an interesting case in 86d26f24, where we have:
>
>   + test_expect_success '
>   +   foo
>   +
>   +'
>   +

That's an interesting case :)
I was trying to generalize my thoughts on it. (How is an empty line special?)

Instead of empty line we could go with the line with the least amount
of characters
in the lines which can be shifted up or down instead as well. Why so?

  The more characters are in a line, the more interesting the line is.
  (the more information is in there). Assuming one patch carries information
  that is highly relevant in itself, but may not be relevant to the surrounding
  (think adding a new function to a C file. The surrounding functions are not
  interesting for the diff, but rather you want to have all "relevant"
information
  bundled into that one diff reasonably.

  Going by the rule of splitting at the shortest line instead of just
at empty lines,
  is a generalization of

So instead of looking at

>   + test_expect_success '
>   +   foo
>   +
>   +'
>   +

we rather want to look at the string lengths of each line:

>   21
>   5
>   0
>   1
>   0

and then take the minimum (so instead of only acting on the 'last 0'
as shown by Jeff,
we'd go to the minimum of those numbers.)

Now on tie breaking (i.e two empty lines):

We need to understand the "pattern" of whether the lonely 1 char line
belongs above
or below the chunk. I do not think we can do that just from the diff alone.

* We either need to check the file ("Does the file start with the 0 1 0 pattern
or does it end with that?" That would be a strong hint on whether to
put the 1 line
above or below the chunk.) However a typical file has noise at the top
and bottom,
so this heuristic is not often applicable. With noise I mean license headers or
a java class or namespace ending with another brace or such. So probably
this second order heuristic on which of the empty lines to pick for
breaking needs more thoughts.

* Go through the history of the file and check for occurrences (how
was such a pattern
added in the past? Ideally we want to find the first time such a
pattern is added and
then decide based on that whether to break at the first or second empty line)

I guess both ways are expensive. Probably too expensive.

So for now we can just go with "take first or last empty line (shortest line) of
overlapping lines" and inspect that further.






>
> and there are _two_ blank lines to choose from. It looks really terrible
> if you use the first one, but the second one looks good (and the script
> below chooses the second, as it's closest to the hunk boundary). There
> may be cases where that's bad, though.
>
> This is just a proof of concept. I guess we'd want to somehow integrate
> the heuristic into git.
>
> -- >8 --
> #!/usr/bin/perl
>
> use strict;
> use warnings 'all';
>
> use constant {
>   STATE_NONE => 0,
>   STATE_LEADING_CONTEXT => 1,
>   STATE_IN_CHUNK => 2,
> };
> my $state = STATE_NONE;
> my @hunk;
> while(<>) {
>   if ($state == STATE_NONE) {
>     print;
>     if (/^@/) {
>       $state = STATE_LEADING_CONTEXT;
>     }
>   } else {
>     if (/^ /) {
>       flush_hunk() if $state != STATE_LEADING_CONTEXT;
>       push @hunk, $_;
>     } elsif(/^[-+]/) {
>       push @hunk, $_;
>       $state = STATE_IN_CHUNK;
>     } else {
>       flush_hunk();
>       $state = STATE_NONE;
>       print;
>     }
>   }
> }
> flush_hunk();
>
> sub flush_hunk {
>   my $context_len = 0;
>   while ($context_len < @hunk && $hunk[$context_len] =~ /^ /) {
>     $context_len++;
>   }
>
>   # Find the length of the ambiguous portion.
>   # Assumes our hunks have context first, and ambiguous additions at the end,
>   # which is how git generates them
>   my $ambig_len = 0;
>   while ($ambig_len < $context_len) {
>     my $i = $context_len - $ambig_len - 1;
>     my $j = @hunk - $ambig_len - 1;
>     if ($hunk[$j] =~ /^\+/ && substr($hunk[$i], 1) eq substr($hunk[$j], 1)) {
>       $ambig_len++;
>     } else {
>       last;
>     }
>   }
>
>   # Now look for an empty line in the ambiguous portion (we can just look in
>   # the context side, as it is equivalent to the addition side at the end).
>   # We count down, though, as we prefer to use the line closest to the
>   # hunk as the cutoff.
>   my $empty;
>   for (my $i = $context_len - 1; $i >= $context_len - $ambig_len; $i--) {
>     if (length($hunk[$i]) == 2) {
>       $empty = $i;
>       last;
>     }
>   }
>
>   if (defined $empty) {
>     # move empty lines after the chunk to be part of it
>     for (my $i = $empty + 1; $i < $context_len; $i++) {
>       $hunk[$i] =~ s/^ /+/;
>       $hunk[@hunk - $context_len + $i] =~ s/^\+/ /;
>     }
>   }
>
>   print @hunk;
>   @hunk = ();
> }
