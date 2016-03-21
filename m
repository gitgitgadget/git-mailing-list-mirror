From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Mon, 21 Mar 2016 13:10:08 +0530
Message-ID: <56EFA558.5020301@gmail.com>
References: <56EED10B.4010604@gmail.com> <vpq4mc1asmy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Jacob Keller <jacob.keller@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 21 08:40:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahuRp-00028w-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 08:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcCUHkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 03:40:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33483 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcCUHkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 03:40:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id x3so28807198pfb.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ladS+c3lpTs2bmEDYr5yJ0LtZL/lM2ve4Ti9i/MT5yg=;
        b=qWsEIte1ylhpwIXzClPFAoU6cUea2hZZjp6m0x5PFiAZ2X3Jab2wQGfJ+r7bTbQbvG
         HHSEMScmsDisnXH9pKosKhvxaQxGfPQMSY+n9UrymnzMJVKWw8fqiWI0gIW/R3M2PrrO
         IIpjBFXgZc/x/eO9leXh5Sxpj/mTzZ2+L9MhoA3zroYXVlgBGwnkuAPXEPXhW3JyCMNQ
         wSkoTUhKCxVci60fgxKyw4to+z1MZOhb6MVEPxJyM9jOxxFPc15BzUimmmltTEclzG2a
         M9R1HkDD0QnZUvBr1kk81y60Qy2OFLM9utTO3OxP3KmvVc6Eo00dMp9IqlERrFjECGEE
         s/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ladS+c3lpTs2bmEDYr5yJ0LtZL/lM2ve4Ti9i/MT5yg=;
        b=cywv4zb4+KnXVltUPZggckOo4cYNzn7TFgjQiP+spPaI+cpotK5UpUsq+WKxaRMXrl
         xVjNYMpEGsjIJnQ92kFBjKdPYviMPNjnKoK36KktTgVKhNoH3GvU7Sh3ro8F+bVc01Hz
         fzraKKjVWbcAZI54m991QF7TcSE8PLNlXScNL/mFwHRdX3glqJq3vMvbdar/iw/Cgvf5
         z7CQnVAwkO4lOwRd5zjETO6DBdSjZUhNqs8BfqD1TbGg6R1yeBEzZmLs6H+u3wnKTIto
         Y5YtRw9Pg2I68N02zWBKjVPID+TXvIoSOmjA98Yh5KuXLCgZC3DUBfdKT2vo8MNUWF/c
         YEsw==
X-Gm-Message-State: AD7BkJJ7DYLSrL8gGH84IRehccFegIA1dary+/eBO+oPWtlI2/JS1fcZn9+68hTCbJpUEA==
X-Received: by 10.98.71.91 with SMTP id u88mr43155712pfa.161.1458546013644;
        Mon, 21 Mar 2016 00:40:13 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.145.96])
        by smtp.gmail.com with ESMTPSA id v14sm38181545pas.10.2016.03.21.00.40.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 00:40:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <vpq4mc1asmy.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289408>


On Monday 21 March 2016 12:22 AM, Matthieu Moy wrote:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
>
>> A wrapper is to be implemented around (currently called 'ggit'), which will
>> provide the following user interface:
>> `ggit <git-command> <options>`
> There's actually already a tool doing this:
>
>   https://people.gnome.org/~newren/eg/
>
> I'm Cc-ing the author.
>
> I heard good feedback about the tool in the early days of Git, when git
> itself was rather clearly not ready for bare mortals. The tool seems
> abandonned since 2013 (last release), my guess is that git became usable
> enough and eg is not needed as much as it was. For example, eg defaulted
> to push.default=tracking before we did the change to push.default=simple
> in git.
Nice! I'll take a look at its source and see how it works.
>
> I think the "wrapper" approach is sound. It avoids touching git itself
> and breaking things that depend on git (for example, adding
> core.denyHardReset to let "git reset --hard" error out would be
> unacceptable because it would mean that any script using "git reset
> --hard" would break when a user has the option set in ~/.gitconfig).
>
> Note that it implies writting an almost full-blown option parser to
> recognize commands like
>
> ggit --work-tree git --namespace reset --git-dir --hard git log
>
> (just looking for "git", "reset" and "--hard" in the command-line would
> not work here).

Could you please elaborate on the above command, I'm unable to
understand its syntax. I thought all git commands follow the
`git command <arguments>` syntax, so using simple string
manipulations and regexes would work. Am I missing something?

>> The wrapper will assess the arguments passed to it, and if they are detected to
>> be safe, it will simply pass them through to 'git'.
>>
>> Warning for potentially destructive commands
>>
>> For every command that is entered, the wrapper will assess the subcommand and
>> its options. In that, it will first check if the subcommand (eg. add,
>> commit, rebase) is present in a list of predefined 'potentially destructive'
>> commands. This can be done by searching through a radix tree for the subcommand.
>> If found, then the arguments to the subcommand will be checked for specific
>> flags. The graylisted flags for the destructive commands will be stored as an
>> array of regular expressions, and the current command's arguments will be
>> checked against them. If matches are found, a warning is displayed. 'ggit'
>> for the warning would be
>> "You are about to do X, which will permanently destroy Y. Are you sure you wish
>> to continue? [Y/n] "
>> If the user enters Y[es], the command will be executed as is (by passing it
>> unaltered to git). In the case of Y[es], 'ggit' will also give tips for undoing
>> the changes made by this command (by referring the user to correct commands and
>> reflog),  if the command can be undone. In case the command cannot be undone,
>> 'ggit' will display an additional line in the warning like
>> "The changes made by this command cannot be undone. Please proceed cautiously".
>> In the case of n[o], 'ggit' will exit without executing the command.
>> Usage tips and documentation
>>
>> The wrapper will also be responsible for showing a short description of every
>> command that is entered through 'ggit'. This shall be done for every command
>> unconditionally.
> I'm not 100% convinced that this is a good idea: it'd be tempting for
> the user to run a command just to know what it does. Perhaps it's better
> to let the user run "git <command> -h" instead. But it could indeed help
> for commands doing very different things depending on the options, like
>
> $ git checkout foo
> Checks-out branch foo
> $ git checkout -b bar
> Creating a new branch bar and checking it out
> $ git checkout HEAD -- .
> Reverting directory . to its last commited state

Yes, I did consider that and came up with this: I thought we can
have an option like --intro or --doc that will just print the
intro snippet for the command without actually running. Though
"git <command> -h" is an option, I wasn't inclined towards it as I
think sometimes the output from -h may not make sense to a new user.
Plus, -h only gives an elaborate list of syntax and options/arguments
but not say what the command does.

> ...
>
> (I think a list of examples would be an important addition to your
> proposal to clarify the plans)

Will do that.

>> The description will be derived from the actual documentation, but
>> will primarily aim to help the beginner understand the Git workflow
>> and the Git model.
>>
>> Timeline
>>
>> Community Bonding Period
>>
>> Week 1 : Discuss the flow of course with the mentor. Discuss adequate data
>> structures and search techniques to be used.
>>
>> Week 2-3 : Discuss over an extensive list of commands that should be classified
>> as destructive. Discuss appropriate short descriptions for commands.
>>
>> Week 4 : Discuss code structure, tests, optimization for least overhead and
>> other details.
>>
>> Coding Starts
>>
>> Week 1-2 : Submit code for a basic wrapper that will warn for a subset of the
>> potentially destructive command, and continue if the command is safe.
>> and this is stored as per to provide backward compatibility.
> I think you can submit an RFC even earlier. Writting and discussing an
> extensive list of commands before seeing any code might end up being
> boring...

I wasn't sure if we are allowed to code before the actual coding period begins
so I kept it that way. I'll update it now.

>> Week 3-6 : Extend the wrapper to warn for all commands in the list, along with
>> proper instructions for undoing them.
>>
>> Mid Term Evaluation
>>
>> Week 7-10 : Add beginner-friendly documentation snippets to various git commands.
>>
>> Week 10-12 : Write tests, evaluate performance.
> You don't want to write tests at the end.
>
Alright, I'll put writing tests into their respective time frames.
>> Week 13 : Final cleanup, final touches suggested by mentors and community.
>>
>> Pens Down Date
>> Submission of Code to GSOC
>>
>>
>> Post GSoC 2016
>> After GSoC 2016 is over, I believe there will stilll be further work required
>> for improving and perfecting the 'ggit' interface before it can be merged with
>> the main distribution.
> I think having the wrapper merged in the main distribution before the
> end of the GSoC must be a goal of the project. Sure, it can be improved
> later, but code not merged at the end of a GSoC usually rests for months
> or years, and is often lost forever.

OK, so I guess that section can be removed altogether since it's not
relevant to the project otherwise.

>> I would like to continue my work on this project and contribute to Git
>> in general as well.
> Cheers,

Thanks and regards,
Sidhant
