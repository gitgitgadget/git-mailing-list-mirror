From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: weird diff output?
Date: Thu, 14 Apr 2016 17:21:12 -0700
Message-ID: <CA+P7+xrs-Jy-enrZvt32UcmQ+1LY2i+gxH2irBVs7NRHY40R8A@mail.gmail.com>
References: <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
 <20160330045554.GA11007@sigill.intra.peff.net> <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
 <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
 <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
 <20160331134750.GA29790@sigill.intra.peff.net> <CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
 <CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
 <alpine.DEB.2.10.1604140639230.8340@zino> <20160414183405.GE22068@sigill.intra.peff.net>
 <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:21:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqrVx-0002pH-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbcDOAVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 20:21:34 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34677 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcDOAVd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 20:21:33 -0400
Received: by mail-io0-f182.google.com with SMTP id 2so120542291ioy.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Hj5l0atA3pn2OemrDCqW6EHPlK//Qic0sV7WDvqCRM=;
        b=nEyNTh6qx5/PvK/O7fxq6lY2PJEVx7c+s2m4BgLkh3l5UCcTxBFa0eBKz/2/KomY9J
         wQOAf8wcAlehiadhPIex4c9yTPhONlAWP18+N4eVr/xYKu9hGOwroWWzXwffQacLYpRD
         LFMxw2sM86GRomaTwG+EgqcDvdkOkB3nczOWQp+U37tSsX21HSLxz4UB5dFz0uGjWJrw
         7zqmn3rFAAEWTBbUCK5Zv2F8UJgyJfNs6iXfwBg97WMq+kE4DIl5tW9H3saiZN7lvbd4
         ZfBpcOmqxmsK2oGLOqkPz5y9Lh9USHE7BnsaXkN1hQZmDxyEkbjIXtHOw5ElfdrVzVxR
         hvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Hj5l0atA3pn2OemrDCqW6EHPlK//Qic0sV7WDvqCRM=;
        b=Vr+Pf40uAQmQnYfjOlDX9rQU5Ow7sy/vmTIs6WLndUS5dy1OMYJdarU6VGJfgr8P66
         XuWTi3W3ZrLd2aBEk0iFyLR9IEqCGiRm2ukm86tYg5Lu30hW1NmTmMl/YCcFBdOSpT3G
         49XRa4de2z2Y7oAoiGEesufrvKIE6MbBBzowOkN3IFJyYJ4w+nqzDiJEz4/OxRpWs1zu
         L7gtrzsd5KjhnYlTPVflEzRSOIm7kODU4BuHWFLaGjii/DAfwEORvbwd57wJ55LN7Hvb
         kWwqWVssF/YRW+RHTE0nac3v3KNnbi5StNsmZiOYdAcOS7UiSfjSwsD4btACFBM5ZGRU
         N+QQ==
X-Gm-Message-State: AOPr4FX+1hdE8AiY+dYbPXk1BAprDEiqX1bCmW6WgM+W+a7U1g/h9fePYB7fU+z8zHv6+YS6G09tt74Rq9hgPw==
X-Received: by 10.107.136.69 with SMTP id k66mr21996990iod.0.1460679692344;
 Thu, 14 Apr 2016 17:21:32 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Thu, 14 Apr 2016 17:21:12 -0700 (PDT)
In-Reply-To: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291583>

On Thu, Apr 14, 2016 at 2:05 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 14, 2016 at 11:34 AM, Jeff King <peff@peff.net> wrote:
>> On Thu, Apr 14, 2016 at 06:56:39AM -0700, Davide Libenzi wrote:
>>
>>> That was a zillions of years ago :) , but from a quick look at email
>>> thread, if you want to do it within xdiff, xdi_change_compact would be
>>> the place.  The issue is knowing in which situations one diff look
>>> better than another, and embedding an if-tis-do-tat logic deep into
>>> the core diff machinery.  In theory one could implement the same thing
>>> higher up, working with the unified diff text format, where maybe a
>>> user can provide its own diff post-process hook script.  In any case,
>>> that still leaves open the issue on what to shift in the diff chunks,
>>> and in which cases. Which is likely going to be language/format
>>> dependent. IMHO, it gets nasty pretty quickly.
>>
>> Thanks, that's helpful. Stefan already came up with a heuristic that I
>> implemented as a post-processing script in perl. It _seems_ to work
>> pretty well in practice across multiple languages, so our next step was
>> to implement it in an actual usable and efficient way. :)
>
> To reiterate the heuristic for Davide (so you can avoid reading the
> whole thread):
>
>     If there are diff chunks, which can be shifted around, shift it such that
>     the last empty line is below the chunk and the rest above.
>
> Example:
> (indented, shiftable part marked with Xs)
>
>         diff --git a/test.c b/test.c
>         index 2d7f343..2a14d36 100644
>         --- a/test.c
>         +++ b/test.c
>         @@ -8,6 +8,14 @@ void A()
>          }
>
>          /**
>         + * This is text.
>         + */
>         +void B()
>         +{
>         +  text text
> X1      +}
> X2      +
> X3      +/**
>           * This does 'foo foo'.
>           */
>          void C()
>
> The last empty line is X2, so that's where we wrap:
> (X2 is the last line of the diff)
>
>         diff --git a/test.c b/test.c
>         index 2d7f343..2a14d36 100644
>         --- a/test.c
>         +++ b/test.c
>         @@ -8,6 +8,14 @@ void A()
>          }
>
> X3      +/**
>         + * This is text.
>         + */
>         +void B()
>         +{
>         +  text text
> X1      +}
> X2      +
>          /**
>           * This does 'foo foo'.
>           */
>          void C()
>
>
>>
>> Looking over the code, I agree that xdl_change_compact() is the place we
>> would want to put it. We'd probably tie it to a command-line option and
>> let people play around with it, and then consider making it the default
>> if there's widespread approval.
>
> I just stumbled upon
> http://blog.scoutapp.com/articles/2016/04/12/3-git-productivity-hacks
> which advertises git config --global pager.diff "diff-so-fancy | less
> --tabs=4 -RFX"
>
> Would you consider your perl script good enough to put that instead of
> diff-so-fancy?
>

Interesting. I'll play around with that for a bit and see how fast it appears.

Thanks,
Jake

>>
>> -Peff
