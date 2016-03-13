From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 00:03:33 +0530
Message-ID: <56E5B27D.7010808@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 19:35:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afAr2-0007Sz-8e
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 19:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbcCMSdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 14:33:39 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35070 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbcCMSdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 14:33:39 -0400
Received: by mail-pa0-f54.google.com with SMTP id td3so112481239pab.2
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OnQyR/wpuhRVvTnlPYnNB9vCXNHKWThUg/kzvkk/JD4=;
        b=dWph3844iNkyKcDzw0B89FeOHTvLCiBSiwYzhNJYx+/kasG7BdbeMdbAtQqw7XbCv+
         5J7/Kq0zrXkDhrOV/PSlt+ptbCoxuwYttmSlliT89XeW3ldG/H553ze7ZodIpcX/1UTe
         14vxJVDyX1mW4R03YjCK3F8eS01PghAsikUZAYUL0DNodZXreS+qC+wXa586MgVzI9ky
         oq4NOjwrk87SlmTrPK/4WBwDrsgi01FnIGPUcRQa/MLYMtInSXiR/KzoH52kbJ7ESFoB
         T2h1+MNghPoOmz8U7vvToLI7YAc8CfgmRgcTItyoDF0HJ6VCjqURzEX9+Xq91t3zzq6m
         K7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OnQyR/wpuhRVvTnlPYnNB9vCXNHKWThUg/kzvkk/JD4=;
        b=jt281AlqITM5Y+xUUzQ0moQhhXf5FRXVb6Ck37GTyvmfehJkYlSVlGY1SMpNSIjwEi
         lsvCFyodXePuslZdkrwbFesVfSGW9x/wk7/ceZhETx9uHrJDR5uJgT0IDAguhhV5rA7w
         o9MKouqd0CWpHaftbOiBW+ydgOjxzW2caaCFeSmqeIAck7egzpKfncjvdUMxLr/oGUPM
         WAU0rb3cjMvWvdsImIE26D6LcCbbMUmFy88WG58/j/Khu45DOJdzKl9Gy8pVgDcxqEmU
         NqFMHPAqoK24nCh+o4GKJUJVQcKFVMk95JpXnin7GojATkFWqZT3nDJoEL03A6s/QnCw
         6AJA==
X-Gm-Message-State: AD7BkJIQGc7vBI2VBEX+Ue74REgKabIZRf2XijMRRBF9zubFSc8+ZBwP5RTa5iTXhwl31g==
X-Received: by 10.66.222.41 with SMTP id qj9mr32137371pac.136.1457894017791;
        Sun, 13 Mar 2016 11:33:37 -0700 (PDT)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id s7sm6064394pfi.12.2016.03.13.11.33.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2016 11:33:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288758>



On Sunday 13 March 2016 09:20 PM, Lars Schneider wrote:
> Hi Sidhant,
>
> thanks for your interest in the 'Git Beginner' mode topic. I completely 
> understand your motivation for the topic as your Git learning experience
> matches mine. However, please be aware that this is no easy project. The
> final implementation might be easy but it will require hard work to come 
> up with a design for the beginner mode that the list considers to accept.
> That being said, I am eager to learn about your ideas on the topic :-)
Hi,

I understand that this project will require much effort to find an acceptable
solution and I'm prepared for it. I'm very excited to take this one up :)

> Based on my previous discussions with Junio [3] I think on of the most 
> important aspects is to ensure that Git does not become harder to use.
> I thought a while about this requirement and I wonder if a wrapper called 
> 'ggit' (guarded Git) could be a solution. The wrapper would pass all 
> command line arguments to 'git' and check for potentially destructive 
> commands. If such a command is detected then the user would see a warning. 
> If the command is not destructive then 'ggit' would print a short instruction 
> how to "undo" it. The ordinary Git user would not be affected at all by the 
> wrapper. A novice Git user who is unsure about his/her command line
> usage could use `ggit` as a safety net.
>
> I am curious about your opinions on this kind of approach. I wonder if
> people would actually use such a wrapper.
Coincidentally, my approach too is a wrapper around git as you suggest.
The approach is simple and straight forward, but I wasn't sure if it would be
accepted on the list, mainly because it may not look consistent with the current
interface `git command [options]`. Perhaps a configuration like
`core.beginnerMode` [4] might be apt? By default, it can be false, making git
behave normally. When set, a safety-check can be run before the command is
executed to ensure it's not potentially destructive. Very much like a wrapper
but on the inside. There can be an option like `--no-beginner` to override
this configuration from the command-line. I was wondering if there should be
command-specific options as well, such as `beginner.allowForcePush`,
`beginner.allowRebase` etc. for a finer control over what commands git would warn
the user about. By default, all are set to false, and warning is shown when any
of them is encountered. Another configuration that may be considered is
`beginner.strict`, which when set would just print the warning and die, instead
of giving the user an option to continue (though I'm a little unsure whether
this one would be a good idea).
One thing that bothers me about this approach is that unlike the explicit 'ggit'
wrapper, an internal wrapper would add (unnecessary?) overhead for most commands,
thus impacting the performance. Will that be an issue?

Along with this, the idea of showing a short instruction for undoing commands
sounds very nice as it'll help beginners to understand and use git better.

I'm eager to know your opinions on this approach :)

Other than this, I also tried to expand the list of potentially destructive
commands and updated the list as follows (additions in brackets):

* git rebase [ git pull --rebase ]
* git reset --hard
* git clean -f
* git gc --prune=now --aggressive
* git push -f [ git push <remote> :<branch>, git push <remote> +<branch> ]
* [ git branch -D ]

Are these additions appropriate? What other commands should be included?


Thanks and regards,
Sidhant Sharma


[4]: http://thread.gmane.org/gmane.comp.version-control.git/285893/focus=286663
