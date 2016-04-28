From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 14:08:43 -0700
Message-ID: <CAGZ79kZF4UeNuwBoA-Vw0OFHin4=8GTWPK-GT+5fsEuCFe7Now@mail.gmail.com>
References: <20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
	<20160428210026.GA12268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:08:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avtB8-0000el-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbcD1VIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:08:47 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:32881 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbcD1VIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:08:44 -0400
Received: by mail-io0-f178.google.com with SMTP id f89so89749625ioi.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IyNW69NPekhHi196UE+nsUkhaEKch2dnhE4h95Stj3s=;
        b=c+uxMHjLfZkN/Ebkrh4uOZTs7kYbc62aBilLOvcz2om1h7mDxq9g/b3pTU1Tz2MCjH
         nspNaa9qAel9CwKPWz2m+XA3GzB0hUi++Pemcm1Onm2vyt335af6xSDXAwrl6lkEoRCW
         YXLoAHyUsbbFVMzHj4Xt780p+DySv/JR6CnWOlMs4iyQQPNbkjssT16QXQJAMlqpOCjA
         JP85XJlI7oJF4MiR/7kXvVsN1pEjyk6SCqDtHJVv2Zu5xN1QAAv+qaLuSdT3B1oeo+cX
         dlhFQL0FDLmzJrMKNT0twBdH2Xlg4kN9GulguqWTScgUsL5vmXl+f9f0lyPCahGRLSND
         fY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IyNW69NPekhHi196UE+nsUkhaEKch2dnhE4h95Stj3s=;
        b=G4EPnqkR218HGiMou0KY/eOoQ3lDnN9IeWYIzz5effzUEE0/S6L63UcnLIGZxOympS
         wjGHm00X9hz0N25rWdU8EoEaNDCOymTqOvUnmwYNvGUyEY7fHTJIFi93aFgrhmlL5XOL
         e/C9ML0Y4zreMagbLgWBMnsX83hpFG3IKCxHgOaAhtS5LNmZyTvKw9YPaURs8+Ry93CB
         0PGPnFoj0yN2vMNR9jSX5e4cE9WZO1Ua9GnwiehKV4yd4y26t1d66dgtmoxhO6CIb7cJ
         E2Q+NNOwpreblwH3HCZG01vkYpGqhRI8wPuiY2v5/TrfjSmcYheg5o7O0wfru8BvfkSk
         VtDg==
X-Gm-Message-State: AOPr4FVrGioqfjswKMVvwqWoowJSnj+bEfSpY23b9gbLof6/vjfc7xhuEojjuvSeix2/pksI80BhIWQdyTo5aaeC
X-Received: by 10.107.161.68 with SMTP id k65mr22622969ioe.110.1461877723578;
 Thu, 28 Apr 2016 14:08:43 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 14:08:43 -0700 (PDT)
In-Reply-To: <20160428210026.GA12268@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292954>

On Thu, Apr 28, 2016 at 2:00 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 12:28:21PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > It's definitely sufficient, it's just annoying if a user shows up every
>> > week and says "I want X.Y", and then somebody else shows up a week later
>> > and says "I want X.Z".
>> >
>> > Are we serving any purpose in vetting each one (and if so, what)?
>>
>> Personally I do not think we would need to filter _anything_ if we
>> can tell that the user directly said
>>
>>       git -c var1=val1 -c var2=val2 $cmd ...
>>
>> and "git $cmd" ended up needing to spawn another "git" subcommand,
>> possibly in some other repository (i.e. "$cmd" in this case is
>> likely to be "submodule", but in principle it does not have to be).
>> If the user somehow gives variables like core.worktree that are
>> inappropriate to be applied across repositories, that's user's
>> problem, i.e. "don't do it then if it hurts".
>
> Right, we are talking about that direct case here. And any time our
> filter heuristic lets something through, it is probably "if it hurts
> don't do it" as the worst case.
>
> So I think the only two cases worth filtering are:
>
>   1. Ones where we _know_ that the config is nonsense to pass along,
>      _and_ where a user might conceivably make use of the
>      just-the-top-level version of it (core.worktree
>      comes to mind, though of course they are probably better served by
>      "--work-tree" in such a case).

My gut reaction to this:
In this specific case I would rather error out, as you never want to have
core.worktree to point at the same dir for all of the repo and submodules.

Thinking about it further, I am not so sure any more.
(What if you have multiple submodules tracking the same project
and you want to see each submodule version with the one worktree you point to?
Highly unlikely edge case, but it voids the /never/ assumption of my
gut reaction)


>
>   2. An option where we think there may be some security implication.
>      Setting "http.sslverify" to false does have some security
>      implications ("oops, I only meant to turn off verification for the
>      root repo, and I got MiTM-attacked for the submodules!"). But it's
>      so obscure and unlikely that I think the benefit outweighs it.
>
>      And I can't think of any other cases whose security implications
>      aren't similarly unlikely. But I haven't carefully gone down the
>      list (and as I said, I'd be hesitant to support a blacklist until
>      _somebody_ takes the time to do so).

I think in this case, it is more likely for the user to say:

    I know my ssl is so borked, so I want all traffic with no ssl
(including submodules).

>
>> If we are doing any filtering, however, it is always hard, if not
>> impossible, to take away what we originally granted, even by
>> mistake, for any reason, even for correctness or for security, in a
>> later release.
>
> Yep, agreed.
>
> I am OK staying with a whitelist. But I think we should be fairly
> lenient in whitelisting hierarchies that people have a use for, and
> which do not violate (1) or (2) above.
>
>> We probably could sidestep it by introducing an end-user
>> configurable "whitelist" somewhere.
>
> Ugh. Please no. I do not want to have to think about explaining to
> somebody that they can accomplish what they want with submodules, but
> only by pre-configuring their ~/.gitconfig to allow certain keys so that
> they can pass the appropriate config on the command line.

I view the whitelist more like an "emergency knob to turn, because the
developers did it wrong and I want it now". the general case should be
covered by a mechanism we provide?

Thanks,
Stefan

>
> -Peff
