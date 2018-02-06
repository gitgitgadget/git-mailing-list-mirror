Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8B11F404
	for <e@80x24.org>; Tue,  6 Feb 2018 13:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBFNYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 08:24:34 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:50312 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeBFNY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 08:24:28 -0500
Received: by mail-wm0-f53.google.com with SMTP id f71so3743804wmf.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 05:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ok04b36Iz/Wvo93PVQ+98DL1GZyBCX0Va6E5vMlViTs=;
        b=Z80J0GWFT+Kmi/yfHf4/cguy7NascH4EpzyImMW3com2mzHdUTYF7tseuzU1LQ1CbO
         qo3goSHraTqrCmYfNzbTPkgJ6L6LC6UE/TmipoK+RmibjwRpkB4naIe/Jl7hZSw6TGyr
         qVgaC/gXUOeGaBaCRI0D14Lh03SV3NwO/sJWmgSheSY9NcsagDmusF2E/24dCO5A+aJ5
         POd9K7dxM9K2200HQDHu59ERzmGX5+6R6SYM4RrDbaLpBDTyxuAL+s7/OOmZLnAn5uW2
         9r2Axtrew9x7XJAGkbOV9BeF4S2pVUtOaqGYLYs6ePAHO65K9X4MA6Q5qzLqCVsf8ytY
         vmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ok04b36Iz/Wvo93PVQ+98DL1GZyBCX0Va6E5vMlViTs=;
        b=EJGs32hKV9vaXv6QcUirBZtDtWf7MSMwcZiT2epnmWpQHpAsHmS8fXtby26rwtpvmW
         3wejU7CnpHr3+hiL2UacOFrlRkQBHNb3NUOvA4swY6UoL8/A+ZmD8gBeuog0Piv3dtae
         uh8n6vpRx9+h1KGYrJsduJTt1Kfec782Ky2TxtRQZNF47KBFPke2wpLjD3LG4q/cgrho
         p0oUUsCr76ol1y6oJX6Xc9Ycj8rL0U9hMNP8eJuw/fRV5JMusEt5hYvwtEhzyyBS6O4R
         51z4qm7JHisNa9+BHG1Dyg25fwF6MzSBpE/IBSr9P9H56I5qynyst9PzIuOqocsjp4hm
         DLFA==
X-Gm-Message-State: APf1xPAP90BZqmGgHylVhnUwdh6zwKltdwzgcMSW1F06LZrd+8Hv9hpS
        zySsZEyD7SB25sReqp4wEMBigWhm
X-Google-Smtp-Source: AH8x227QcXqmwEZYKbpZfa7kMfvzJYLa6IpRoqIPosbGQbgmbbuwY1I/LaUMotaoWqmU5kltQXBDCw==
X-Received: by 10.80.170.195 with SMTP id r3mr3730627edc.230.1517923466836;
        Tue, 06 Feb 2018 05:24:26 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id c45sm8684346edb.17.2018.02.06.05.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 05:24:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Filip Jorissen <filip.jorissen@kuleuven.be>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be> <87607nvzrd.fsf@evledraar.gmail.com> <20180128075731.GA17412@tor.lan> <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
Date:   Tue, 06 Feb 2018 14:24:25 +0100
Message-ID: <87lgg6l08m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 06 2018, Filip Jorissen jotted:

> Hi all,
>
> Thank you for your quick responses. I was able to resolve the problem based on your feedback!
>
> Based on this experience, I would like to suggest that git is somehow able to avoid these problems by doing a case check itself rather than relying on the host OS for this?

I think it would make a lot of sense for git to ship with some standard
library of hooks for people to enable that covered common cases like
that.

But it's important to realize that:

 1) That's all this would be, this check would just be something you can
    do via a pre-receive hook now (or in this case, that big hosting
    providers like Github could offer as a pre-receive hook).

 2) Case collisions are just a subset of these issues, if you look at my
    CACBZZX4qH-w3YevoaW8RXAoFrjpfGerLWpBhetrO2tV-FGr3cQ@mail.gmail.com
    here on-list you'll see an issue relating to unicode normalizing
    that triggers a similar problem.

 3) Such hooks slow down pushes, especially on big repos, you can
    optimize things a bit (e.g. only look in the same directories), but
    pathologically you end up needing to compare the cross-product of
    changed files v.s. all existing files for each changed file.

 4) It's not something hosting providers like Github, Gitlab etc. can
    just enable, because some people want it like this. There's a lot of
    repos that have e.g. case collisions or other problems that only
    manifest on some OS-specific limitation (e.g. paths that are too
    long for VMS), and none of the users care because they don't use the
    repo on those systems.

    So it's not something that can be enabled by default, even for the
    most common case of case collisions.

Right now you're probably best off setting up a CI check on Github that
checks whether someone commits a colliding file, and poking Github about
maybe providing some opt-in feature to check for this.

I think the most performant way of checking this is:

    git --icase-pathspecs ls-files -- <changed files>

Which should never emit more lines than you give to it, you'd run that
either for the tip of the push, or if you want to be more thorough for
each pushed commit.

If someone can think of a better way to check for this I'd love to hear
about it, I'll probably add a check like this to some of our internal
repos soon. We semi-regularly have Mac users up in arms because someone
pushed a case-colliding file on Linux.

>> Op 28 jan. 2018, om 08:57 heeft Torsten Bögershausen <tboegi@web.de> het volgende geschreven:
>>
>> On Sat, Jan 27, 2018 at 08:59:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Sat, Jan 27 2018, Filip Jorissen jotted:
>>>
>>>> I think our git repository is bugged. The reason why I say this is the
>>>> following. When cloning the repository, the newly cloned repository
>>>> immediately has file changes[...].
>>>
>>> If you run this:
>>>
>>>    git ls-files | tr '[:upper:]' '[:lower:]' | sort | uniq -D | grep '^'
>>>
>>> You'll see that the reason is that you have files that differ only in
>>> case.
>>>
>>> You are using a Mac, and Macs by default think that files that are
>>> different binary strings are the same file, since they don't consider
>>> case to be relevant. The file FOO, foo and FoO and fOo are all the same
>>> file as far as your Mac is concerned, but would be 4 different files on
>>> Linux.
>>>
>>>> How can I fix the repository?
>>>
>>> You could check it out on a OS that considers files that differ in case
>>> to be different files, e.g. on Linux, move them around, push it, and new
>>> clones should work on your Mac.
>>>
>>> Alternatively I hear that you can create a loopback case-sensitive FS
>>> image on Macs.
>>
>> You can even fix the repo locally.
>> There are 2 files with uppercase/lowercase collisions.
>> I show you how to fix one off these, the other one goes similar.
>> After that, do a commit and a push and pull request.
>>
>>
>>
>> Changes not staged for commit:
>>  (use "git add <file>..." to update what will be committed)
>>  (use "git checkout -- <file>..." to discard changes in working directory)
>>
>>        modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
>>        modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Utilities_Psychrometrics_Functions_Examples_saturationPressure.txt
>>
>> no changes added to commit (use "git add" and/or "git commit -a")
>> user@mac:/tmp/IDEAS> git ls-files -s | grep -i IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
>> 100644 f56cfcf14aa4b53dfc5ecfb488366f721c94c8e2 0       IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
>> 100644 e345e1372111d034b4c5a1c75eb791340b93f55e 0       IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
>> user@mac:/tmp/IDEAS> git mv IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump2.txt
>> user@mac:/tmp/IDEAS> git checkout  IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump2.txt
>> user@mac:/tmp/IDEAS> git checkout IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
>> user@mac:/tmp/IDEAS> git status
>> On branch master
>> Your branch is up to date with 'origin/master'.
>>
>> Changes to be committed:
>>  (use "git reset HEAD <file>..." to unstage)
>>
>>        renamed:    IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt -> IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump2.txt
>>
>> Changes not staged for commit:
>>  (use "git add <file>..." to update what will be committed)
>>  (use "git checkout -- <file>..." to discard changes in working directory)
>>
>>        modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Utilities_Psychrometrics_Functions_Examples_saturationPressure.txt
>>
>> user@mac:/tmp/IDEAS>
