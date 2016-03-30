From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 23:05:41 -0700
Message-ID: <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com> <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com> <20160330045554.GA11007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al9Gb-0004qL-8x
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 08:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbcC3GGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 02:06:04 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34629 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbcC3GGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 02:06:02 -0400
Received: by mail-ig0-f173.google.com with SMTP id sy18so22882758igc.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=onp5YtU9kZdfs29H5f62uBUmGV9h8d+gWmtEVk72Hgg=;
        b=loc+Tp8CaZpspEYTFZbhm9YYMO2V03MGCLorCXU+JUMbfZWVSc7PHNDlh48dOoEMt7
         URuFzKm9lpbbg3RYsHS/HrUkQDaonJio4gF8OWRKi+1ban8i4t9xEdQyarlvdo3ET1JI
         JUqNxRKbySbAGwAUE01EnSuAMVBhfXaRfhahrfPTde+x05hwMnSDtOyXnzUzsGJ4iJIf
         42e0phZ7TYR85qQhZ2yezBg8wsNRundpfoOPMbX69yu4SgmrlNqPILoSEYM84G63PNkP
         M2WoQNWvYbn8pF1DwfFdvz9TfjgSRzFXikiM9omUkSoQfTNxzlEfpB1C7cDLbEwztjh4
         489w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=onp5YtU9kZdfs29H5f62uBUmGV9h8d+gWmtEVk72Hgg=;
        b=VY05bGXIrXHHBL/9QDdBEQwTomGU+DGg1Q4AqiUOQY+tpNSiAHVG9fl3EID6FMeeY0
         W4KMUP+Q+fANRDZdgb5bXIClO9xY3rShWCS/6vCOUWmwNpQBX1X01B3AnIzBOhusKhrB
         Y5cTwl/zV0RuMCs0YoDraQ5rYuA5lnU6DYyApAcuo4DBkbSLcnelfY6FTARgTLbsEZib
         KE5+s+JC0hp+c0rBiRNww/gBlbA1D8hx/kFkV50NfnpM+yw+yb5IY9F8ZutgX7AWAF0i
         kuqY6mKL0zYUJ0P3SpFrw9NDnwSlsAlVy7blj0N1YWM+ZuaU+37rrb+0hJgB8sZrmnrj
         iO7g==
X-Gm-Message-State: AD7BkJLQV7EfHWLaBt0jazy9N+lrKBsuhs9px2vfw0aN8gIWk3MZlY8XErwUOR5LlCR7JoTjx/i3w4KaAx0Tgw==
X-Received: by 10.50.143.104 with SMTP id sd8mr7612005igb.35.1459317961245;
 Tue, 29 Mar 2016 23:06:01 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Tue, 29 Mar 2016 23:05:41 -0700 (PDT)
In-Reply-To: <20160330045554.GA11007@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290273>

On Tue, Mar 29, 2016 at 9:55 PM, Jeff King <peff@peff.net> wrote:
> One thing I like to do when playing with new diff ideas is to pipe all
> of "log -p" for a real project through it and see what differences it
> produces.
>

Great idea!

> Below is a perl script that implements Stefan's heuristic. I checked its
> output on git.git with:
>
>   git log --format='commit %H' -p >old
>   perl /path/to/script <old >new
>   diff -F ^commit -u old new | less
>
> which shows the differences, with the commit id in the hunk header
> (which makes it easy to "git show $commit | perl /path/to/script" to
> see the new diff with more context.
>

I'll try to run this  against my projects and see what it looks like
to see if I can spot (m)any counter examples, which would indicate
it's a bad idea. I may have some time in the next few days to see how
hard it would be to fully integrate it into the diff machinery too.

Thanks for the help!

Regards,
Jake

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
