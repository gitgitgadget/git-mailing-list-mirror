From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 13 Mar 2016 23:14:02 -0700
Message-ID: <CA+P7+xqsjY--_0aQgJKKNOBONDL5ULkRw+z+J7ATyJC=KWC1qg@mail.gmail.com>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
 <56E5B27D.7010808@gmail.com> <CA+P7+xp3drFd9rSkxSH9P4PfxFrXvDU9kFib1dtBFdVC5R+ZRg@mail.gmail.com>
 <56E64B47.5000000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 07:14:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afLlt-0007lZ-W7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 07:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbcCNGOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 02:14:22 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34946 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbcCNGOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 02:14:22 -0400
Received: by mail-io0-f170.google.com with SMTP id g203so211015032iof.2
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Ep6a1Lh/3+tMPmkr77kROvH9Zb0Ql1YCazuUg1pWCs=;
        b=T6vO6F++WtRCUI1MwWrdjeSbWf5rAfhHMRby7QaqIjCVMai2ls3NH7avbXWRpc6Nlu
         Qm4SFT/M0w3eMFQv+6f6bISDcodLvxgIR1g5ljq+BWmam3BDJKd1Oxf65htPG+WDtLc/
         qvfuGvwM/N1XQF+K5WjCRaGCqKTF+sJl9BdAHdxRtNyrjzQDaEilXDZBd9E9WWbGVQJV
         HyGTmcpdINGDH3h4dxk5RHS1XMBSKSqTwPA8t1lgdIc82o4mPwrHa6GGwwMIPjlJIkrp
         zpeZKjyNzZ68gXwMX4TVWJMiemVDhY7XlkloPjv7/HuxF2i7UUhL7hiMrSQKKNk6bwi2
         MRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Ep6a1Lh/3+tMPmkr77kROvH9Zb0Ql1YCazuUg1pWCs=;
        b=RgNL2RajIFlj5gu9/Oadi4ehFRJCjp02WoqRJ39cRiv1NQV1Z0MRuH7NNtUgIYRtIJ
         +UYRVYrrSbzuyDEkTSfLRM7lsGw+HD7dfvtqPMxSHB9i6fmq/jYCmVujZK4fteWuRC7j
         IvPpTNLeH8wcYyt08n5tLQonfRV05l2yd8L6F1jDrSjsb+R9b5TAbDR3n6bOz4lpeVO1
         uoFrwsym3LBa2CeIPIX/rp9pOupxenoGuzW6tH8QDWx4Q3qmH4l32+tbb8m4laLD7BXt
         NFenbptVmqe0mJopgOKzpDZn4lNAeUUecLazw17WlMhfwTz/zwxQADzH+v3LyaenXNFZ
         XcbA==
X-Gm-Message-State: AD7BkJJWxP8bW6BAj+XWDE7X935/ZGp+zHw3mfnsqDtQb64DDGhiajEVCY3N+AIw1U3/qGX/gDBoHs/zUGm/OA==
X-Received: by 10.107.170.6 with SMTP id t6mr18815006ioe.71.1457936061383;
 Sun, 13 Mar 2016 23:14:21 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Sun, 13 Mar 2016 23:14:02 -0700 (PDT)
In-Reply-To: <56E64B47.5000000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288768>

On Sun, Mar 13, 2016 at 10:25 PM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>
> On Monday 14 March 2016 04:58 AM, Jacob Keller wrote:
>> On Sun, Mar 13, 2016 at 11:33 AM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>>> Coincidentally, my approach too is a wrapper around git as you suggest.
>>> The approach is simple and straight forward, but I wasn't sure if it would be
>>> accepted on the list, mainly because it may not look consistent with the current
>>> interface `git command [options]`. Perhaps a configuration like
>>> `core.beginnerMode` [4] might be apt? By default, it can be false, making git
>>> behave normally. When set, a safety-check can be run before the command is
>>> executed to ensure it's not potentially destructive. Very much like a wrapper
>>> but on the inside. There can be an option like `--no-beginner` to override
>>> this configuration from the command-line. I was wondering if there should be
>>> command-specific options as well, such as `beginner.allowForcePush`,
>>> `beginner.allowRebase` etc. for a finer control over what commands git would warn
>>> the user about. By default, all are set to false, and warning is shown when any
>>> of them is encountered. Another configuration that may be considered is
>>> `beginner.strict`, which when set would just print the warning and die, instead
>>> of giving the user an option to continue (though I'm a little unsure whether
>>> this one would be a good idea).
>>> One thing that bothers me about this approach is that unlike the explicit 'ggit'
>>> wrapper, an internal wrapper would add (unnecessary?) overhead for most commands,
>>> thus impacting the performance. Will that be an issue?
>>>
>> If I recall correctly, a configuration setting was previously
>> discussed but mostly discarded as a solution since any changes had
>> better not impact any current scripts. Having to add "--no-beginner"
>> for all of them seems unacceptable. Especially since many scripts may
>> do potentially dangerous operations in a safe or useful way.
>>
> I agree that adding `--no-beginner` to all such commands wouldn't be right. In
> that case, can we have the flag between git and the command? Such as
> `git --no-beginner reset --hard`. If present, the flag can then be removed from
> the argument list and the rest of the command executed as is without warning.
> Would that a better option?
>
>
> Thanks and regards,
> Sidhant Sharma
>

No, the whole problem with "--no-beginner" is that scripts must either
check the configuration variable or add the flag. Since, by definition
exactly zero scripts do that today, then every script must either (a)
be re-written, (b) accept that some behavior will not work as
expected.

Most (robust) scripts will already check for aliases, and if not, the
user should expect that doing weird things to their environment in
this way would cause things to break.

I don't think we can create a design where scripts must be re-written
to protect themselves or accept misbehaving in those ways.

If we had a clear (used) delineation between porcelain and plumbing
commands, we could have all the porcelain commands accept an argument
but not plumbing. Except that (a) all plumbing commands can be called
from the path relatively easily so a user might still want protection
on those too and (b) we don't actually have an enforced
plumbing/porcelain distinction. While we document one, several scripts
exist in the wild which violate this and which we may want to support.

I think that we could go this route, but we'd have to be willing to
accept (a) or (b), above as costs to this route. Personally I prefer
the wrapper approach since it neatly bypasses all of this behavior and
seems easier to implement.  It's major downside is telling beginners
to use "ggit" or similar, which is a big deal.

We have broken scripts in the past or changed behavior of commands
before. But it is done using a phased transition with lots of
warnings. It is possible that the gain is large enough to be worth it.
In this case, I think we should heavily way that side because helping
people learn git is a huge win. I can't count how many times I've had
to tell someone "you really didn't mean to do that" and wished for a
way to help avoid this.

But, it is a cost to adding an option that any scripting, push/pull
hooks or other complex workflows would have to be thought through
carefully.

Thanks,
Jake
