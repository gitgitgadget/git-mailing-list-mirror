From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 10:55:27 +0530
Message-ID: <56E64B47.5000000@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56E5B27D.7010808@gmail.com>
 <CA+P7+xp3drFd9rSkxSH9P4PfxFrXvDU9kFib1dtBFdVC5R+ZRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 06:25:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afL0c-0004nE-LK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 06:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbcCNFZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 01:25:34 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33052 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbcCNFZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 01:25:32 -0400
Received: by mail-pa0-f54.google.com with SMTP id fl4so148375408pad.0
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RhTMjS5NDFfbNbEQt3WRjpcgYzZCdKPN5kXP7MEOvjw=;
        b=Cn+n0MQ2KvmISvjfr8lZRP+Tb4bfX2de8sJTkQl20veFPg/h9+L33uUrcX4KOvl7ZR
         rZc8J3YvBI08ESU+LAQG/VHYl5DYH0tjGe4kjPKZ6PNp9/Hyco3E0CEnyX8k98TS6Z1I
         fo+G9zlVJcSLVjEtz40lUm0jzZmSiYvdSGGfi15/hI52rr+0jZN8NfC+27zS20m59HcR
         1vQ029FW8bbAMF1I+FswXX9R0Jq/WHLqUO6D9aYYwNUiLuasINPievcV8oNme/rumRE3
         R2zh+7BO/NRBNnZkqHOK5kUUlRPcSmO9DH6QLVhExt6YhuIl5BEIs+fJNVjk4qspc7Db
         Qxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RhTMjS5NDFfbNbEQt3WRjpcgYzZCdKPN5kXP7MEOvjw=;
        b=EbWDi30UUdJTH1moDx18Pi4JAhwZYLnx66HQhU9LhWa4AKveIm9N/5ibP2duhjwAow
         CJpGdHug9mmAwNi6UWjZ9fk92SvkiGMqIr0ju+CrjtfZ3/SXaYXZZCFWnSx/cI1hB/XJ
         jFrDchGH91LWaAFr5A4TvGlnsGFVI/CEx/IkoiKWNT5ivaryQI9VeXP9E/s9mDkE15Gk
         5IiBM92tXpc8by2+e6buwSib+NUnZ77V4AmW5qqOovkZBSpz3g3bhbXcRAyDpLKX5YNQ
         QHMLfXgtj/KLtsIEeyrwTbMn87itOFsV7kSeYjZQelZkvnNCG9pDczMP7pkv1T80HCuO
         aRUA==
X-Gm-Message-State: AD7BkJK1XUKwwzdMtAWANhNGKU9WS9Xk6uQqW4ncEnT4APRHcSNcqrTKMbB2GVghwFzYJQ==
X-Received: by 10.66.193.161 with SMTP id hp1mr35302680pac.9.1457933131663;
        Sun, 13 Mar 2016 22:25:31 -0700 (PDT)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id yh5sm28672392pab.13.2016.03.13.22.25.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2016 22:25:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CA+P7+xp3drFd9rSkxSH9P4PfxFrXvDU9kFib1dtBFdVC5R+ZRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288766>


On Monday 14 March 2016 04:58 AM, Jacob Keller wrote:
> On Sun, Mar 13, 2016 at 11:33 AM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>> Coincidentally, my approach too is a wrapper around git as you suggest.
>> The approach is simple and straight forward, but I wasn't sure if it would be
>> accepted on the list, mainly because it may not look consistent with the current
>> interface `git command [options]`. Perhaps a configuration like
>> `core.beginnerMode` [4] might be apt? By default, it can be false, making git
>> behave normally. When set, a safety-check can be run before the command is
>> executed to ensure it's not potentially destructive. Very much like a wrapper
>> but on the inside. There can be an option like `--no-beginner` to override
>> this configuration from the command-line. I was wondering if there should be
>> command-specific options as well, such as `beginner.allowForcePush`,
>> `beginner.allowRebase` etc. for a finer control over what commands git would warn
>> the user about. By default, all are set to false, and warning is shown when any
>> of them is encountered. Another configuration that may be considered is
>> `beginner.strict`, which when set would just print the warning and die, instead
>> of giving the user an option to continue (though I'm a little unsure whether
>> this one would be a good idea).
>> One thing that bothers me about this approach is that unlike the explicit 'ggit'
>> wrapper, an internal wrapper would add (unnecessary?) overhead for most commands,
>> thus impacting the performance. Will that be an issue?
>>
> If I recall correctly, a configuration setting was previously
> discussed but mostly discarded as a solution since any changes had
> better not impact any current scripts. Having to add "--no-beginner"
> for all of them seems unacceptable. Especially since many scripts may
> do potentially dangerous operations in a safe or useful way.
>
I agree that adding `--no-beginner` to all such commands wouldn't be right. In
that case, can we have the flag between git and the command? Such as
`git --no-beginner reset --hard`. If present, the flag can then be removed from
the argument list and the rest of the command executed as is without warning.
Would that a better option?


Thanks and regards,
Sidhant Sharma
