Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C3E1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbcGTN4b (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:56:31 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38174 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbcGTN43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:56:29 -0400
Received: by mail-wm0-f49.google.com with SMTP id o80so70392288wme.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 06:56:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2GqOm7iAObaGrzFYrb+0N9MxgEMltUL4iOee2MiNQr4=;
        b=I+raihQI5q08I4Ef2vmEDM//3+rOgLmslNf7pZmUhll9kcfdKkgPCzS8Ua5GbE9x5P
         I2HLwve9k2YoINcZdL8jblZspaIVtUEutIpRSYnOvNuiRscyzCjBsBzTvI7mbtkeFWBp
         yscRDLBqZdZ1r59Th64AphziJv/YirBwLmaIINC6yRFEChZdh3mRtlVWylBDEkw/u9Is
         zh4v1KHUrf+UYDkONhbMJ/476n99XLsHJ7xsmkJ1btgYcNrN+TZR9o89/XTIO1ceX/Ty
         HdPcaF14JCoEDiXJM+2oPJBm1HNKlv87nZG2pmh39HYRzu41keiJyYx37hltRyTkX1XH
         KEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2GqOm7iAObaGrzFYrb+0N9MxgEMltUL4iOee2MiNQr4=;
        b=itHnFXzdsIm3Rl65g0/sGp0J5Obm2VWZyjfN/yKML019Bg7fYRD/S8f/Nmw0T9hn5d
         BA3fzNkishO1tNcctNK9o0x56FeamngsTmPQTvD9OiMTdstE1STLS21J/tfSYylpd0Za
         kFHEwicr4/sgp0z2zNSHbRoefZI7AbJiXi+UMNzM9JVpfc6gkE0HKUysK4aqd0VX1l/M
         7TgJI3o5+K7yC/u8//H7BN0bBXsz+W8VOYlwCgy+I1/BeIvGh35ev+76XLz9dWpETEb1
         RYqTaHahCSQvbggJObaQISuCZWM9Eu3MEU5Vqqp9Cv+mBCBJjN5pb5Navd8AhVE8b95M
         HAQQ==
X-Gm-Message-State: ALyK8tIpldMcY4aTKGdafP+PrhShHdRieU69ZaoY7y2v2i3VTJXLEzzPzwaW4D4hFwnj2g==
X-Received: by 10.194.78.80 with SMTP id z16mr1498561wjw.17.1469022987922;
        Wed, 20 Jul 2016 06:56:27 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id v203sm5320659wmv.2.2016.07.20.06.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 06:56:27 -0700 (PDT)
Subject: Re: How to generate feature branch statistics?
To:	Ernesto Maserati <ernesto.2.maserati@gmail.com>,
	git@vger.kernel.org
References: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578F8306.3070306@gmail.com>
Date:	Wed, 20 Jul 2016 15:56:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 10:05, Ernesto Maserati pisze:

> I assume that feature branches are not frequently enough merged into
> master. Because of that we discover bugs later than we could with a more
> continuous code integration. I don't want to discuss here whether feature
> branches are good or bad.
> 
> I want just to ask is there a way how to generate a statistic for the
> average duration of feature branches until they are merged to the master? I
> would like to know if it is 1 day, 2 days or lets say 8 or 17 days. Also it
> would be interesting to see the statistical outliers.
> 
> I hope my motivation became clear and what kind of git repository data I
> would like to produce.
> 
> Any ideas?

There are at least two tools to generate statistics about git repository,
namely Gitstat (https://sourceforge.net/projects/gitstat) and GitStats
(https://github.com/hoxu/gitstats), both generating repo statistics as
a web page. You can probably find more... but I don't know if any includes
the statistics you need.

I assume that you have some way of determining if the merge in 'master'
branch is a merge of a topic branch, or of long-lived graduation branch
(e.g. 'maint' or equivalent). To simplify the situation, I assume that
the only merges in master are merges of topic branches:

  git rev-list --min-parents=2 master | 
  while read merge_rev; do 

You might want to add "--grep=maint --invert-grep" or something like
that to exclude merges of 'maint' branch.
	
We can get date of merge (authordate with %ad/%at, or committerdate
with %cd/%ct), as an epoch (seconds since 1970 -- which is good for
comparing datetimes and getting the interval between two events)

     MERGE_DATE=$(git show -s --date=format:%s --pretty=%ad $merge_rev)

Assuming that topic branches are always merged using two-head merge
as a second parent (--first-parent ancestry for master in master branch
only), then we can get the first revision on a merged topic branch with

     FIRST_REV=$(git rev-list $merge_rev^2 ^$merge_rev^1 | tail -1)

We can extract the date from this revision in the same way

     FIRST_DATE=$(git show -s --pretty=%at $FIRST_REV)

Print the difference (here to standard output, you might want to write
to a file)

     echo $(expr $MERGE_DATE - $FIRST_DATE)

And finish the loop.

  done

Then pass the output to some histogramming or statistics tool... or use
a spreadsheet. Note the results are in seconds.

HTH (not checked much)
-- 
Jakub Narębski
