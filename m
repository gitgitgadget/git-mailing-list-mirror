Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E467320899
	for <e@80x24.org>; Tue,  8 Aug 2017 18:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdHHSDW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 14:03:22 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34591 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbdHHSDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 14:03:20 -0400
Received: by mail-pg0-f49.google.com with SMTP id u185so17812027pgb.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E04xlExOIQSKbxGpuhAm7vehUWS+t2uOxuIGYjQ5eUE=;
        b=Z3fKa5bBKOi/3+aOP78zpkqZHPPORumYfwZlUPaQgjox/xsH0cOinZ/Ejva4gm4nvq
         LdeOOvHbS9l6oYuBv9Q1KaG7L08MvAnsi02qfM7QW6ryoemmFejwmQqACpGQCdSQYk6q
         yPKARrN+QZYQ8bioPaDdPFhe7BKODHl28eG48KhS6o9j23qNoKXiziBU/CNMOtFcc08D
         4dh10BcUXQo6fDE/GN/f0OiUfHT9bXWfASK7yr7Q1sl+/baeUHGmkB2IEbB0FpcVimZ2
         kXMcHjBA5o/F5mIC84r3DJR5FbZKVUSMGzqZaWQD3TfKYtvTm5JG5T3A1Fm+0yVEp1h8
         ot4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E04xlExOIQSKbxGpuhAm7vehUWS+t2uOxuIGYjQ5eUE=;
        b=TAYBeEIoOhdMvf45w1QuXSF6ZQSgS0MdOA2TaxmH8kTLLM0T0tedWjbn3PjsLcechF
         R+Y2O05E0LDKx7nBrcGI6lfM8UaT3UWX4n5lhHbi3Xr7Qiv4jC+cQFd+Z4B0vBno/eAX
         GYJC2/sBoDD3TuziT0oPP3op8UJI3ao/kDKakWkmomNUvJzhOaCRC0M8VO7rOe2ECzgh
         syY1i0E1xS2fMu7Uyv2haJ88VHr+gRrrw8k0m9HihoLRtVvhm0BW5iiLddoocp5Djct3
         01HIobgjDtxWtp4B0bXDXZnq2C22bbMDHtYW7o1gFOmXHsUtfdWvpXqbP6PL+t+0bG5J
         3JZg==
X-Gm-Message-State: AHYfb5h+nDyemPYWv2hmblDcCJ5fRxzleOf9NJN0NGlzGqUNIoQ//EEI
        9DRDbJenOYRK2PpRpPW3SQ==
X-Received: by 10.99.151.17 with SMTP id n17mr4833246pge.157.1502215400021;
        Tue, 08 Aug 2017 11:03:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3453:175f:fdaa:f8c5])
        by smtp.gmail.com with ESMTPSA id p77sm3477012pfi.153.2017.08.08.11.03.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 11:03:18 -0700 (PDT)
Date:   Tue, 8 Aug 2017 11:03:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170808180317.GA73298@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Add a '.clang-format' file which outlines the git project's coding
> > style.  This can be used with clang-format to auto-format .c and .h
> > files to conform with git's style.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >
> > I'm sure this sort of thing comes up every so often on the list but back at
> > git-merge I mentioned how it would be nice to not have to worry about style
> > when reviewing patches as that is something mechanical and best left to a
> > machine (for the most part).  I saw that 'clang-format' was brought up on the
> > list once before a couple years ago
> > (https://public-inbox.org/git/20150121220903.GA10267@peff.net/) but nothing
> > really came of it.  I spent a little bit of time combing through the various
> > options and came up with this config based on the general style of our code
> > base.  The big issue though is that our code base isn't consistent so try as
> > you might you wont be able to come up with a config which matches everything we
> > do (mostly due to the inconsistencies in our code base).
> >
> > Anyway, I thought I'd bring this topic back up and see how people feel about it.
> 
> I gave just one pass over all the rules you have here.  I didn't
> think too deeply about implications of some of them, but most of
> them looked sensible.  Thanks for compiling this set of rules.
> 
> Having said that, it is easier to refine individual rules you have
> below than to make sure that among the develoepers there is a shared
> notion of how these rules are to be used.  If we get that part wrong,
> we'd see unpleasant consequences, e.g.
> 
>  - We may see unwanted code churn on existing codebase, only for the
>    sake of satisfying the formatting rules specified here.

This is an issue when you have an inconsistent code base such as ours as
the tool, even when used to format a diff, will format the surrounding
context.

> 
>  - We may see far more style-only critique to patches posted on the
>    list simply because there are more readers than writers, and it
>    is likely that running the tool to nitpick other people's patches
>    is far easier than writing these patches in the first place (and
>    forgetting to ask the formatter to nitpick before sending them
>    out).

I would hope that use of such a tool would eventually completely
eliminate style-only critiques.  

> 
>  - Human aesthetics judgement often is necessary to overrule
>    mechanical rules (e.g. A human may have two pairs of <ptr, len>
>    parameters on separate lines in a function declaration;
>    BinPackParameters may try to break after ptrA, lenA, ptrB before
>    lenB in such a case).

I know that when you introduce a formatter there are bound to be some
issues where a human would choose one way over the other.  If we start
using a formatter I would expect some of the penalties would need to be
tweaked overtime before we rely too heavily on it.

> 
> We need to set our expectation and a guideline to apply these rules
> straight, before introducing something like this.

> 
> 
> >  .clang-format | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644 .clang-format
> >
> > diff --git a/.clang-format b/.clang-format
> > new file mode 100644
> > index 000000000..7f28dc259
> > --- /dev/null
> > +++ b/.clang-format
> > @@ -0,0 +1,166 @@
> > +# Defaults
> > +
> > +# Use tabs whenever we need to fill whitespace that spans at least from one tab
> > +# stop to the next one.
> > +UseTab: Always
> > +TabWidth: 8
> > +IndentWidth: 8
> > +ContinuationIndentWidth: 8
> > +ColumnLimit: 80
> 
> I often deliberately chomp my lines much shorter than this limit,
> and also I deliberately write a line that is a tad longer than this
> limit some other times, if doing so makes the result easier to read.
> And I know other develoepers with good taste do the same.  It is
> pointless to have a discussion that begins with "who uses a physical
> terminal these days that can only show 80-columns?" to tweak this
> value, I think.  It is more important to give a guideline on what to
> do when lines in your code goes over this limit.
> 
> A mechanical "formatter" would just find an appropriate point in a
> line with least "penalty" and chomp it into two.  But an appropriate
> way to make such a code that is way too deeply indented readable may
> instead be judicious use of goto's and one-time helper functions,
> for example, which mechanical tools would not do.
> 
> That is an example of what I meant above, i.e. a guideline to apply
> these rules.  We would not want to say "clang-format suggests this
> rewrite, so we should accept the resulting code that is still too
> deeply indented as-is"---using the tool to point out an issue is
> good, though.
> 
> > +
> > +# C Language specifics
> > +Language: Cpp
> 
> Hmph ;-)

Well there's no 'C' Lang option so Cpp is the closest there is ;)

> 
> > +# Add a line break after the return type of top-level functions
> > +# int
> > +# foo();
> > +AlwaysBreakAfterReturnType: TopLevel
> 
> We do that?

Haha So generally no we don't do this.  Though there are definitely many
places in our code base where we do.  Personally this makes it a bit
easier to read when you end up having long function names.  I also
worked on a code base which did this and it made it incredible easy to
grep for the definition of a function.  If you grep for 'foo()' then
you'd get all the uses of the function including the definition but if
you grep for '^foo()' you'd get only the definition.

But that's my preference, if we end up using this tool it would probably
make sense to change this.

> 
> > +# Pack as many parameters or arguments onto the same line as possible
> > +# int myFunction(int aaaaaaaaaaaa, int bbbbbbbb,
> > +#                int cccc);
> > +BinPackArguments: true
> > +BinPackParameters: true
> 
> I am OK with this but with the caveats I already mentioned.

The alternative (with this config) is to have arguments and parameters
each on their own separate line.

> 
> > +# Insert a space after a cast
> > +# x = (int32) y;    not    x = (int32)y;
> > +SpaceAfterCStyleCast: true
> 
> Hmph, I thought we did the latter, i.e. cast sticks to the casted
> expression without SP.

I've seen both and I wasn't sure which was the correct form to use.

> 
> Thanks.

-- 
Brandon Williams
