From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Mon, 21 Mar 2016 15:40:54 +0530
Message-ID: <56EFC8AE.3030606@gmail.com>
References: <56EED10B.4010604@gmail.com> <vpq4mc1asmy.fsf@anie.imag.fr>
 <56EFA558.5020301@gmail.com> <vpqd1qo5j5e.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Mon Mar 21 11:11:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahwnj-0008Ry-5G
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 11:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbcCUKLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 06:11:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33632 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbcCUKLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 06:11:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id x3so29359657pfb.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HL8uqtzackDHC67qpXZoxiKRBOz/UcbPW5gRCj6kLEg=;
        b=V6mceNRQYermscoPWwA5lAJp2i+9cLiDPcSPmAIHRDEOD/5+e9Gh3uAKh++HrB7SWX
         QMFU8M6tG4gM6H4/PXvgeWyBidN9j+7A98ANFGNgWR6nJq2d0Q78AqrfRRdH/N2q5IHB
         GlOJiIL8+TF4fd7SFB/OrTCazpRFDl0n7oq/AsjOGQ2vshGsTwsO30A0Q76h0oxj1fpq
         NPwNN4pMKh0Bx6Wz9csy8GrvgGZZ2Yup01AgGa2knKcBo77UNdijcWM7D4CJtaOOepQU
         W3tlIMSMuWbdz68IPGwEtj/Ubx1kMXG+KySC2v5nAdbyISUAVvWmGFVxjeu/2ThQe2qd
         ueJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HL8uqtzackDHC67qpXZoxiKRBOz/UcbPW5gRCj6kLEg=;
        b=GMVsHDBe+oEAYqjeY3uye0YLPz0amGm/Cr3t0GUdk33zC2GCUW76+NzmXy8jTwjaSy
         /FQ/vpjCeD5oNYbRDagGAzWZxQR/Hy3bfBfxMT/pHQ+vXxwaHiKSe2EFmJLL/TvAW+fM
         ItDr0qxkEOe97gQ32X3odbiQhoOMlnmOzi3nknoNpIDq7dLbPeFIUpKpEIdnP9C1zXGj
         qlLhneZ5B+NVVzZKAgswCGnk3e67LwM4BUMgpNd1duzim+j7rqa+tRULeTJo1Msd+CS5
         RaWobrhPgFQ3gP/mfImbqhaqvV6gPFghte7pGjAZ5O2bJCM9MP8iq0AAyunhKZCOfOX/
         ZIog==
X-Gm-Message-State: AD7BkJLpWFYbu/bVWtzdW6bFS0N6Yw1Lud/B/K7j5zwhRkwFPoTLoobb/kQG1ExeXvTuaA==
X-Received: by 10.98.72.213 with SMTP id q82mr44269083pfi.164.1458555060360;
        Mon, 21 Mar 2016 03:11:00 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.145.96])
        by smtp.gmail.com with ESMTPSA id m84sm39347636pfi.75.2016.03.21.03.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 03:10:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <vpqd1qo5j5e.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289414>



On Monday 21 March 2016 01:59 PM, Matthieu Moy wrote:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
>
>> On Monday 21 March 2016 12:22 AM, Matthieu Moy wrote:
>>
>>> Note that it implies writting an almost full-blown option parser to
>>> recognize commands like
>>>
>>> ggit --work-tree git --namespace reset --git-dir --hard git log
>>>
>>> (just looking for "git", "reset" and "--hard" in the command-line would
>>> not work here).
>> Could you please elaborate on the above command, I'm unable to
>> understand its syntax. I thought all git commands follow the
>> `git command <arguments>` syntax, so using simple string
>> manipulations and regexes would work. Am I missing something?
> The full syntax is
>
> git [global options] <command> [options and arguments for a command]
>
> For example:
>
> git -p log => -p is the option for "git" itself, which means "paginate"
> git log -p => -p is the option for "git log", which means "patch"
>
> Options can have stuck or non-stuck form, for example
>
> git --work-tree=foo <=> git --work-tree foo
>
> git --work-tree git --namespace reset --git-dir --hard git log
> <=>
> git --work-tree=git --namespace=reset --git-dir=--hard git log
>
> (This is probably a stupid command to type, but it's legal)
>
> The later is source of issues for a parser since you can't just iterate
> through argv[] and search for problematic commands/options, since you
> have to distinguish options themselves (--work-tree above) and option
> arguments (foo above).
Thanks for the explanation; I knew of the global options but didn't know
that the last command would be syntactically legal. For commands like such
iterating over argv[] wouldn't work (not in all cases). Though a beginner
may not enter commands of this sort, I agree we shouldn't rely on  that. If
it were only for stuck commands, regexes would've worked.
I can now see why a parser would be needed here, which can recognize global
options and the above command syntax. But for this example,
> In my example above, I played with global options (before "git" in the
> command-line), but I could also have done that with per-command options
> taking arguments, like
>
> git push --repo --force
>
> Here, --force is the name of the repo (again, probably a stupid name,
> but why not), not the --force option.
would the parser also be required to understand all options and arguments for
all git commands? Although --force could not be a branch name (git denies it),
but it may not be so for other commands.
>> I wasn't sure if we are allowed to code before the actual coding period begins
>> so I kept it that way. I'll update it now.
> You're not "forced" to, but you can write code whenever you like. We've
> already seen code written before the application!
>
Nice! I too would like to get started early :)
