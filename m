From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 09:16:01 +0100
Message-ID: <FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 09:16:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afNfo-000503-3H
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 09:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbcCNIQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 04:16:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32785 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933961AbcCNIQG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 04:16:06 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so90847864wml.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zoMeUv7yn/UgLrBUTkBZPeukrcfZChJC/BCPriYn6RI=;
        b=HrEDOFmdN3FWeAH/HrHzwxcbvhpp3vCS6fKMsE70Ii2eyeUh5wSxqKYNGUsPtWCv/h
         aV5CDJw0rdqwa3Ck8I0BkjXSvbwpjtQBoEgNcLbuuK+g7VAo54vE1TUwQP9ezzUSI3E7
         98bYouzyOQTATs9iIY64QqRC/N2wPvQxMuJZ8J0SgqH0pP1QI8V21BqUU3GBfZVWgXve
         24yiWMtgdqRgmZaqIvHjQXCdcO3pSNBV6m6lB8FjdoIIOkjUMIcv3w3Y23PAKSzJVJQE
         +qONRVSkTYb3wXWw6OuHkpFp0YmbtMnlxUuxSUkHhTYKDeN9VpQSrTdtT1T8Xgfer+qR
         pIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zoMeUv7yn/UgLrBUTkBZPeukrcfZChJC/BCPriYn6RI=;
        b=OHxmXlNaRjY7mqKCaRjrtDvmkdFHKvLXLRqb+J27lLIAuADovQJctKW1TFxdNzcZAR
         /VYES4oKwoutULT1DTBxvK8sZAqI7sVnLIpRyD/IxyvM03oUWkkRvh8j7E8bmhD1Scp2
         fEkxsppVJdxZuCWeILaR1C2ypmOsfKFpUWLQPA6PCmHXkkXU//AhsTvAs54tVns7U6G1
         zbxYIN4gmpYKPRW90UkLIZ4eqrrPFuWf67imuSi9It4qL3tG8styub44rvH/qFKx9IKz
         eKjW8dBHcIBH2HZLNJBaXcnv5BFGVKtUJewsWbfjFo1beoiwuIkI3/EKqdivyybG81Wl
         futQ==
X-Gm-Message-State: AD7BkJJ7MRjJ8NMtLxubGNV9U0628R0RIT+PVIPUjpVoNpPJxQ73yIcz3G03yQDDMlkgiQ==
X-Received: by 10.194.186.170 with SMTP id fl10mr25941438wjc.29.1457943364957;
        Mon, 14 Mar 2016 01:16:04 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA989.dip0.t-ipconnect.de. [80.139.169.137])
        by smtp.gmail.com with ESMTPSA id cb2sm21153683wjc.16.2016.03.14.01.16.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Mar 2016 01:16:04 -0700 (PDT)
In-Reply-To: <xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288773>


On 14 Mar 2016, at 07:57, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> I thought a while about this requirement and I wonder if a wrapper called 
>> 'ggit' (guarded Git) could be a solution. The wrapper would pass all 
>> command line arguments to 'git' and check for potentially destructive 
>> commands. If such a command is detected then the user would see a warning.
> 
> I recall back in the days when people said that Hg's command set was
> so much more pleasant to use that some people thought about building
> Hg's command line UI on top of low level implementation of the Git's
> data structure.  Even before that time, there was an effort "Cogito"
> to build an alternate UI on top of Git core.  If "ggit" can be made
> reasonably feature complete in such a way that it lets beginners do
> all what they need to do, omitting many advanced/hairy features core
> Git may let users use (i.e. making trade-off between power and risk
> of misuse differently from core Git), that may be a reasonable way
> to offer a "beginner mode".
> 
> The beauty of such an approach is that as long as "ggit" correctly
> talks the same on-wire protocol when interacting with other people's
> repositories, nobody needs to even know or care that you are using
> "ggit" exclusively.  Two systems can talk without problems.
> 
> If "ggit" is made too limited, there is an issue.  Beginners may at
> some point need to transition to the real thing to fully exploit the
> power of Git, and they may need to unlearn "ggit" and learn Git.

I think a "ggit" wrapper should not introduce any new commands or new
parameters. Everything should be passed unmodified to Git. The wrapper
would only add additional warnings such as "You are about to do X which 
will permanently destroy Y. Do you want to continue?". Therefore
a transition from "ggit" to "git" would not require any learning effort.

Maybe "ggit" could also be interpreted as "guided Git" (sounds more 
friendly than "guarded Git"). I have the impression that many Git 
beginners make mistakes because they don't have a mental model of Git,
yet. A "guided" Git version could explain the commands a bit more 
detailed as they use Git (e.g. with ASCII graph examples). I know
that's what man pages are for but I've encountered many users 
(especially on Windows) that are not aware of man pages.


> This approach, if it wants to become successful in helping users,
> would take quite a lot of thinking and work to avoid omitting too
> much to necessitate users to migrate to Git.  But I can very well
> imagine that a new "Cogito 2" project (I am not saying that the UI
> Cogito tried to achieve were superiour or anything of that sort--I
> just needed a name, and picked one name that came to my mind) may
> get done by those who interact rarely with the core Git community
> and may live as one of many independent and viable third-party
> projects you find on GitHub.
> 
> There however are two questions I do not offhand have good answers
> to: (1) if that kind of effort is of suitable size for GSoC, and (2)
> if it is suitable to be supported by the Git project proper.

Good questions. I have no previous experience with GSoC Git projects
and therefore I am not qualified for an answer. However, my gut feeling
would be that a proof of concept implementation of a "ggit" wrapper
that does not add any new commands and only adds warnings for destructive
commands could be in the GSoC scope. However, Sidhant must be aware of
the fact that this is a controversial topic and therefore any future work
on this topic might be never merged into Git.

I also thought about (2). The obvious advantage of having something like 
"ggit" as part of Git core is that it would be shipped with the standard
Git distribution. That would especially help beginners. However, 
maintenance is a very strong counter argument. Maybe "ggit" could
start as a separate project and if it picks up then Git core can still
decide to merge it?
