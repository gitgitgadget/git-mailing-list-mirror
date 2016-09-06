Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B5F1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 19:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933579AbcIFTtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 15:49:08 -0400
Received: from mout.web.de ([212.227.15.4]:54630 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932904AbcIFTtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 15:49:07 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LocJe-1b9vQT1bbO-00gbEC; Tue, 06 Sep 2016 21:49:03
 +0200
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     john smith <wempwer@gmail.com>, git@vger.kernel.org
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
Date:   Tue, 6 Sep 2016 21:48:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LUCaXBZ3jvdU6Karq0E+WtmKlDFZ/RqXWKDsYKSmMPsiPU6AN9i
 9Ix4Q0YkKxRCxrz3gRG0XRV09kaV+/1IPFT8/ubNOURqekuxTQkqGHYQOLxTmikyWJ1JSsF
 rAEhS6RQniQw7WuMc0Y33H9Z2CXCwrz4ofzeXNjneozm0R2OznMeGHWyXAAZSY6io07UK4c
 PAO4iL6YOleN+lHMeoPBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I5A9V0+bIpY=:aCvSNJqZyifMHDoxJmal0Z
 rdw/2fIWcS+DvIEJpZ7nLWZq4tQdjqj+waiYumWioEtTckm4/ouqWBRH2jmRwrT6zs22I+mhc
 1yTuwypnauwo8yELAKP70T0NmHRVWHAsIP/ds6uGRaOnVduYfTLdT/Tq4tL/0CDo7/S7uGaB6
 exQpHE+bSkdRmDD5ssvVKCc7f0guK5N90VwuzOfdPogpfVwaqSvXmPbfEbaqaKmwoDnYrrw7d
 9Vc2BrApCKqZUUrUel2Q25C5KzvusQXyy4sd2MB/InpElZra7MbWJqs74eWOotqaPN7FeAMfx
 SqOZkdVGHOoTmyEv9Irw1g08EV6z8AnYQGjr08JpuVVKuRNxxw2eyuu8L2/VlXq16Agt3WfaS
 0rQbbC8pXZIC2dUTEFc2gJaFGFnKZHESOQT8FF/5+KRCGveZ00506EsSb9YAtTK6BY+gFcxJz
 faiNDzese31Y+cxdqDr9ulJHUrJx8QNawMBZYtlLP88dRsuakLQtPfzQuR7rt7y4MBl0dl//Y
 6I5ELdjAg+Nj8n4LvOBa7VWvA9xv8GxgazyC67VnQ8vyMvbOlfmobqDAth9CMaoMwGuKKDO7x
 Bd0C3ijQ+fB1PFz7w4e+/BWvFiqIEPHjuenf7yTgJxNsbTC3cuyIAF/o7nxAwjje0672e2HjC
 s5N+vpZp8FQzCL/R61alAWnmAOMq9jlIgys1duPmJuTeNoUv5T7MwuMnTWJuKnCvUwCPTcAvZ
 GMPn+NKTyjfgBDTs2R60an+7c2Ravg+u3k5EkTlPrnPpmPdVd4zuZTPlxKmyxMK4nzEVXULQp
 tWORqg5kEssln1z/P0r7LOwONvPHAE9/BuY5NWzzY5E9cupOrv6B0I7gwi4XgHA6D0PK+N7+R
 cwAVK4H7fVXvzldhQrxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.09.16 19:47, john smith wrote:
> I am looking for a way to force smudge filter to run by simulating a
> real life checkout. Let's say I just created a new branch and did not
> modify any files but want to test my new smudge filter. According to
> some answers such as
> https://stackoverflow.com/questions/22909620/git-smudge-clean-filter-between-branches
> and
> https://stackoverflow.com/questions/21652242/git-re-checkout-files-after-creating-smudge-filter
> it should be possible by running:
>
> git checkout HEAD --
>
> but in doesn't work with git 2.9.0. Method suggested in accepted
> answer here
> https://stackoverflow.com/questions/17223527/how-do-i-force-git-to-checkout-the-master-branch-and-remove-carriage-returns-aft
> works but I don't like because it seems fragile. Is there a safe way
> to do what I want to do in Git still today?
>
It depends what you mean with "safe way".

git checkout, git checkout -f or other combinations will only

overwrite/rewrite the files in the working tree, if, and only if,

git comes to the conclusion that "git add" will do something,

like replace a blob for a file in the index.

(And by running "rm .git/index git will evaluate the "clean" filters,

and the CRLF->LF conversion).


If you want to test a smudge filter, simply remove the file:

mv file /tmp && git checkout file




