From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: [PATCH/GSoC] parse-options: Add a new nousage opt
Date: Thu, 24 Mar 2016 22:51:05 +0530
Message-ID: <CAJj6+1EYYiK3qjOpZLBZG1d0FfW2r67759dCcLjxEy=+vFN0Dg@mail.gmail.com>
References: <1458456405-3519-1-git-send-email-chirayudesai1@gmail.com>
	<20160323223157.GA12531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:21:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8wc-00082c-C7
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbcCXRVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:21:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33109 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcCXRVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:21:07 -0400
Received: by mail-io0-f194.google.com with SMTP id v187so10192748ioe.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=x/gF23TJBgU/UlMhJM0XkU6JuvNQXSrOxaVSgBUV68Q=;
        b=ItpC7iWtQ5nEw38NjD8woa0WTpfWSDsWH0K0qijPLkJMREJcT8+ADCt6bz7NaeUe3Q
         C6zuDUpJDPCmsPFQ+axEeUBLdcrqdQRTdHc/9yTaABS2ZneppgetxoDaJ1aWkgS7f0UW
         viS8u9yMs78tNNMdR1UjbX15AG6XDRM6/klZ0cRxWjUVyqjW4fnZPZt7jfZA4Ujtl7qr
         I3GkG1j5Fawx+juS7wAUCuMZFmHPkZ3iWUJI61HzF3ePYF871h8Pdg8b3KWMc3EMlWOB
         GFLEUfLYhzMIN6gZZdT0VsoO9gevj8CCqJcgzDGMPE5yNNgzydyykbBcd8IYmNVhZzNt
         jTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=x/gF23TJBgU/UlMhJM0XkU6JuvNQXSrOxaVSgBUV68Q=;
        b=asCjsfg8h1p0BPYp90y9R2MD6oP5HRtsZBY1Cu0RequgNArmhgEoJ3Cmve3UCz8h+t
         1X9HBFxN9rt6dPh9kVV+SQDMERT/E9HUhrmUNdNOB4xZxkctfiGpVhneQjlZdtRInwlm
         XBiTCa5PxZ774y5apkV0oYCzvZUD9gO52rA10o2JScQVkQs3XzaWEI3Wj1bhjFbMbkL8
         o3WhZnFbew/ZKlnqLFDTeflOvCGSh1gMG/h6LORJLOdFLnLNa0BgGrn5kScRF0cbqxey
         cwW+LH486TpxV3xGbzT+aC+TRqXOcguduP4Uk5IJMnEK6Uf95z271tWLWOPbm4Ge/1xt
         LA3A==
X-Gm-Message-State: AD7BkJJUAAj+KrtRsTT1ABT9Khm+EI3d10FGwrIgiuRRYnMMQLFIvCkI6iKtvlI2ILgKjpBPm08d1gRsIl8jug==
X-Received: by 10.107.159.137 with SMTP id i131mr9457186ioe.29.1458840065636;
 Thu, 24 Mar 2016 10:21:05 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Thu, 24 Mar 2016 10:21:05 -0700 (PDT)
In-Reply-To: <20160323223157.GA12531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289765>

Note Before: I have decided not to apply for GSoC with Git this year,
as I was already late, and all the remaining time got taken by the
proposal I wrote for Debian, and college studies / exams.

I definitely want to work with Git in the future too, it has always
piqued my interest being something that I use daily.
I want to get this change done as well, if that is okay.

On Thu, Mar 24, 2016 at 4:01 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 20, 2016 at 12:16:45PM +0530, Chirayu Desai wrote:
>
>> diff --git a/parse-options-cb.c b/parse-options-cb.c
>> index 239898d946..ac2ea4d674 100644
>> --- a/parse-options-cb.c
>> +++ b/parse-options-cb.c
>> @@ -85,11 +85,15 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
>>
>>       if (!arg)
>>               return -1;
>> -     if (get_sha1(arg, sha1))
>> -             return error("malformed object name %s", arg);
>> +     if (get_sha1(arg, sha1)) {
>> +             error("malformed object name %s", arg);
>> +             return -3;
>> +     }
>
> Now that we have a few meaningful return values, should we have some
> enum that gives them human-readable names?
>
> E.g., why don't we allow "-2" here? I think it is because
> parse_options_step internally uses it for "I don't know about that
> option". But maybe we should have something like:
>
>   enum PARSE_OPT_ERROR {
>           PARSE_OPT_ERR_USAGE = -1,
>           PARSE_OPT_ERR_UNKNOWN_OPTION = -2,
>           PARSE_OPT_ERR_FAIL_QUIETLY = -3,
>   }
>
> (I don't quite like the final name, but I couldn't think of anything
> better).
I agree, this would be much better and clearer than using hard coded values.
>
>> diff --git a/parse-options.c b/parse-options.c
>> index 47a9192060..d136c1afd0 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -158,6 +158,9 @@ static int get_value(struct parse_opt_ctx_t *p,
>>                       return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
>>               if (get_arg(p, opt, flags, &arg))
>>                       return -1;
>> +             if (opt->flags & PARSE_OPT_NOUSAGE) {
>> +                     return (*opt->callback)(opt, arg, 0);
>> +             }
>>               return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
>
> Here you use PARSE_OPT_NOUSAGE to pass the callback's value directly
> back to the rest of the option-parsing code. But can't we just intercept
> "-3" always? It's possible that another callback is using it to
> generically return an error, but it seems like a rather low risk, and
> the resulting code is much simpler.
I don't get what you mean by intercepting '-3'.
The idea was that other options could use it in the future to return
arbitary values.
>
> Or we could go the opposite direction. If a callback is annotated with
> PARSE_OPT_NOUSAGE, why do we even need to care about its return value?
> The callback could continue to return -1, and we would simply suppress
> the usage message.
That would also work, but I feel that this is cleaner.
>
>>       case OPTION_INTEGER:
>> @@ -504,6 +507,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>>                       goto show_usage_error;
>>               case -2:
>>                       goto unknown;
>> +             case -3:
>> +                     return PARSE_OPT_DONE;
>>               }
>>               continue;
>>  unknown:
>
> If I understand correctly, this is now getting the value from the
> callback directly. What happens if a callback returns "-4" or "4"?
That could be handled in the future if somebody decides to use that.
Now this makes using the above "return -1 always but don't print usage if flags
contain PARSE_OPT_NOUSAGE" option look much better.
>
> Also, this covers the parse_long_opt() call, but there are two
> parse_short_opt() calls earlier. Wouldn't they need to learn the same
> logic?
I didn't add it right now as both "--contains" and "--with" are long opts.
>
> -Peff

Thanks,
Chirayu
