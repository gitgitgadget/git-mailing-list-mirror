From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: weird diff output?
Date: Wed, 6 Apr 2016 10:47:31 -0700
Message-ID: <CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com> <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
 <20160330045554.GA11007@sigill.intra.peff.net> <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
 <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
 <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com> <20160331134750.GA29790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:48:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anrYh-0007i9-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 19:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbcDFRrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 13:47:52 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36629 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbcDFRrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 13:47:51 -0400
Received: by mail-ig0-f179.google.com with SMTP id f1so135673376igr.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jdKO+TjsMLQU6NtGpvOzzhNpvG+lTeugKobeRMCb31w=;
        b=TmEqTmUGsiegupM7JPY7SZA6oCWcZNTW/QDkc7t4+h7YefK7vqb2wyjKewIMoxMHlB
         92cuC1QzS8F3rlJQF6GDSGzu+EbZOSJMkdnxAPKQbrDApSzsf2Ldim8pmOwBXAlfQIPv
         v1BEVbwDjLXwYjszFgr2NMDj+fs4ihvOdudByVVGUF9rmrbMsd9C01QA5W0mmnWUeL1p
         KSTobLSZgGF0LCHrMzlS1XgTVTNhaR2tV59A2/AgNPOTYtK20u9S3J7qKIqY3sLWJ0ab
         hBsC6OOjfEER6aOrTHhBYnDxItifg9IlywN2vFx+atDFvMIwdCuyYS01dKkLIcY0PGxN
         t/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jdKO+TjsMLQU6NtGpvOzzhNpvG+lTeugKobeRMCb31w=;
        b=NjnFkly3FJQaXs75sss+wAWqRMMbhhQWq5JbQP3zsiklZvwJSaD/nvR8TSGk54Zlbd
         7f6d3HIiYM+uD22cFcRDASVdeQVMzdJCYUEQvQZ0Y/SgcsHF2cbjSvItOZKDvBEZ8gkP
         l8Z+5i6RtVx3K/GsnEHy246aPIkO5wIPKPm5wLS8sbVx6VD5V3aasMTVOOUMndWuJSCs
         ENlsC+XDRQwMTOabHUMT5gvaGZcDO+uwiiPBeiVjjnc4m9CVetVPToBOTU9jfGuCPVd/
         2A6oEqICT0SlghoALjZFAdDbJyzufosAhlV7r3By537uHqqj6Ro1mtEbhzLdb9rbFnth
         tXOQ==
X-Gm-Message-State: AD7BkJJnruoICKPpC5HbwAaNQn1ycp+Fjx3Vs8gPLsawykEp+VBdq0B8y326Y9Y+N7OViU9Rr8TVgPdduIWZlA==
X-Received: by 10.50.97.70 with SMTP id dy6mr22187043igb.73.1459964870472;
 Wed, 06 Apr 2016 10:47:50 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Wed, 6 Apr 2016 10:47:31 -0700 (PDT)
In-Reply-To: <20160331134750.GA29790@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290859>

On Thu, Mar 31, 2016 at 6:47 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 30, 2016 at 12:31:30PM -0700, Jacob Keller wrote:
>
>> So far I've only found a single location that ends up looking worse
>> within the Linux kernel. Diffs of some Kbuild settings result in
>> something like
>>
>> before:
>>
>>           If unsure, say Y.
>> +
>> +config RMI4_I2C
>> +       tristate "RMI4 I2C Support"
>> +       depends on RMI4_CORE && I2C
>> +       help
>> +         Say Y here if you want to support RMI4 devices connected to an I2C
>> +         bus.
>> +
>> +         If unsure, say Y.
>>
>> after:
>>
>>           required for all RMI4 device support.
>>
>> +         If unsure, say Y.
>> +
>> +config RMI4_I2C
>> +       tristate "RMI4 I2C Support"
>> +       depends on RMI4_CORE && I2C
>> +       help
>> +         Say Y here if you want to support RMI4 devices connected to an I2C
>> +         bus.
>> +
>>           If unsure, say Y.
>>
>> So in this particular instance which has multiple blank lines and is a
>> similar issue as with Stefan's note above, this is where the heuristic
>> falls apart. At least for C code this is basically vanishingly small
>> compared to the number of comment header fix ups.
>>
>> I think it may be that Stefan's suggestions above may be on the right
>> track to resolve that too.
>
> This is a tricky one. There _aren't_ actually multiple blank lines in
> the ambiguous area, because this particular example comes at the very
> end of the file. Try:
>
>   git show 8d99758dee3 drivers/input/rmi4/Kconfig
>
> which adds a block in the middle of the file. It looks good both before
> and after running through the script. Now look at this example:
>
>   git show fdf51604f10 drivers/input/rmi4/Kconfig
>
> which looks like:
>
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 5ea60e3..cc3f7c5 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -8,3 +8,12 @@ config RMI4_CORE
>           required for all RMI4 device support.
>
>           If unsure, say Y.
> +
> +config RMI4_I2C
> +       tristate "RMI4 I2C Support"
> +       depends on RMI4_CORE && I2C
> +       help
> +         Say Y here if you want to support RMI4 devices connected to an I2C
> +         bus.
> +
> +         If unsure, say Y.
>
>
> Note that there is no trailing context, as we're adding at the end of
> the file. So the ambiguous portion consists of only two lines: an empty
> line, and "If unsure...". And we bump the latter to the top, per the
> heuristic (it's the exact opposite of every other case, where the blank
> line is a true delimiter).
>
> As a human, I think the indentation here is the real syntactic clue. But
> getting into indentation heuristics is probably insane.
>
> The script could probably make this work by disabling itself if the hunk
> is at the end of the diffed file (i.e., we don't see more context lines
> afterward). That covers any case like this where newline _is_ a
> delimiter, but we just have some internal newlines, too. It wouldn't
> cover the case where we had internal newlines but used some other
> paragraph delimiter, but based on the results so far, that seems rather
> rare.
>
> Something like this:
>
> --- foo.pl.orig 2016-03-31 09:44:44.281232230 -0400
> +++ foo.pl      2016-03-31 09:44:34.901232632 -0400
> @@ -24,13 +24,15 @@
>        push @hunk, $_;
>        $state = STATE_IN_CHUNK;
>      } else {
> -      flush_hunk();
> +      print @hunk;
> +      @hunk = ();
>        $state = STATE_NONE;
>        print;
>      }
>    }
>  }
> -flush_hunk();
> +print @hunk;
> +@hunk = ();
>
>  sub flush_hunk {
>    my $context_len = 0;
>
> -Peff

I started attempting to implement this heuristic within xdiff, but I
am at a loss as to how xdiff actually works. I suspect this would go
in xdi_change_compact or after it, but I really don't understand how
xdiff represents the diffs at all...

Thanks,
Jake
