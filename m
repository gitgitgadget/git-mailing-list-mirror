From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 21:30:23 +0530
Message-ID: <56E6E017.1080709@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56E5B27D.7010808@gmail.com>
 <CA+P7+xp3drFd9rSkxSH9P4PfxFrXvDU9kFib1dtBFdVC5R+ZRg@mail.gmail.com>
 <56E64B47.5000000@gmail.com>
 <CA+P7+xqsjY--_0aQgJKKNOBONDL5ULkRw+z+J7ATyJC=KWC1qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 17:00:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUv4-0006Xd-UK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 17:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965594AbcCNQAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 12:00:31 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34739 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965385AbcCNQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 12:00:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id x3so45287101pfb.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QpQh971/yVja/CucPKiiFRFPcdxD+0jO868LHdZmdqU=;
        b=vpzVU7nMR8UPzEl5/8XsBsbRNjLdiUhu4P4OohaeXjbv8C42WXMC4ykhl0/tmHHLn7
         G/vSffjJ7ib4zoPsNUFJWLAMEd951C35EqbY65aRvFmrOfbPLfjsovW/yJoaBJKf/7C0
         LZZ4jVoK83xrAHqxXga/G8rLmD9OiE9PMzXUD6UOCdOX3/UTE66l8GdDeNXNz6ugCsCU
         ZL05zRE3Y8O4giBnKerrqyP+uNNMomULJWF/AcP+8/meQ8NZOo5/h3+7JAqFmJbMG2dr
         fj35PApVeANp+uDXFCGvpL+NmqXiyruQ7h1R6U1TkC8zzNkYLGOwHElrjzyiFTW0tRWd
         n05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QpQh971/yVja/CucPKiiFRFPcdxD+0jO868LHdZmdqU=;
        b=ZgBeBKYyW2V//WFbfTKcG2xMH81rcFCI8AixkgZ8FJ5WdlmcGfWmA/b0k+LpApHKjB
         n4wlD56fpy5Vt+2DOgI/1g6oar4kkU2vxegEUgiQrfEvmaxwCoQ/erOxxekXiTdO8t7t
         iOwIBTcLvJfyZ4vLFKEWOCdu0mDG6qL4W4fZJhq66RFar+3XBwuM6XWwRsKOtJAHCuj4
         xS+PowKef4aJf33dv8HOERe9cWXyFMAwFTmYGAbVNaxxcZeU+8Q+Ub+vKjU7JCYyfKNw
         LtcmFc0prk/l8EHPShbZnn360hMzTm0EpR2Qr7QHMcV0E0rky2g732IE1O2Y4watlH4a
         H0Wg==
X-Gm-Message-State: AD7BkJJAdOSe+C5RqbdzFefkB0maV6TUKw4M2Pzd+iGOG3OWUYCjowVxVjCnqTDwTgtxzQ==
X-Received: by 10.98.16.150 with SMTP id 22mr31131600pfq.128.1457971227663;
        Mon, 14 Mar 2016 09:00:27 -0700 (PDT)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id l14sm33219912pfi.23.2016.03.14.09.00.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2016 09:00:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CA+P7+xqsjY--_0aQgJKKNOBONDL5ULkRw+z+J7ATyJC=KWC1qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288788>


On Monday 14 March 2016 11:44 AM, Jacob Keller wrote:
> On Sun, Mar 13, 2016 at 10:25 PM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>> On Monday 14 March 2016 04:58 AM, Jacob Keller wrote:
>>>
>>> If I recall correctly, a configuration setting was previously
>>> discussed but mostly discarded as a solution since any changes had
>>> better not impact any current scripts. Having to add "--no-beginner"
>>> for all of them seems unacceptable. Especially since many scripts may
>>> do potentially dangerous operations in a safe or useful way.
>>>
>> I agree that adding `--no-beginner` to all such commands wouldn't be right. In
>> that case, can we have the flag between git and the command? Such as
>> `git --no-beginner reset --hard`. If present, the flag can then be removed from
>> the argument list and the rest of the command executed as is without warning.
>> Would that a better option?
>>
>>
>> Thanks and regards,
>> Sidhant Sharma
>>
> No, the whole problem with "--no-beginner" is that scripts must either
> check the configuration variable or add the flag. Since, by definition
> exactly zero scripts do that today, then every script must either (a)
> be re-written, (b) accept that some behavior will not work as
> expected.
>
> Most (robust) scripts will already check for aliases, and if not, the
> user should expect that doing weird things to their environment in
> this way would cause things to break.
>
> I don't think we can create a design where scripts must be re-written
> to protect themselves or accept misbehaving in those ways.
>
> If we had a clear (used) delineation between porcelain and plumbing
> commands, we could have all the porcelain commands accept an argument
> but not plumbing. Except that (a) all plumbing commands can be called
> from the path relatively easily so a user might still want protection
> on those too and (b) we don't actually have an enforced
> plumbing/porcelain distinction. While we document one, several scripts
> exist in the wild which violate this and which we may want to support.
>
> I think that we could go this route, but we'd have to be willing to
> accept (a) or (b), above as costs to this route. Personally I prefer
> the wrapper approach since it neatly bypasses all of this behavior and
> seems easier to implement.  It's major downside is telling beginners
> to use "ggit" or similar, which is a big deal.
Thanks for elaborating on that. I now understand why the configuration
option approach is not fit. The 'ggit' wrapper does sound more
apt for this. I do realize telling the beginners to use 'ggit' instead 
of just 'git' is a shortcoming of this approach, but perhaps it's worth
it if it makes Git easier to use and understand for beginners. Lars'
suggestion of short instructions would be really nice for helping
beginners form a mental picture of git workflow, and might be worth
the trade-off.


Thanks and regards,
Sidhant Sharma
