Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DA01F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 10:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbdATKzH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 05:55:07 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:54059 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdATKzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 05:55:06 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1C0A310C17AC;
        Fri, 20 Jan 2017 02:44:16 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9E3834B3;
        Fri, 20 Jan 2017 02:44:16 -0800 (PST)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id E8AAF4A2;
        Fri, 20 Jan 2017 02:44:15 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Fri, 20 Jan 2017 02:44:15 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Fri, 20 Jan 2017 11:44:13 +0100
Received: from [10.107.19.92] (10.107.19.92) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Fri, 20 Jan 2017 11:44:13 +0100
Subject: Re: Git: new feature suggestion
To:     Stefan Beller <sbeller@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
 <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
 <991ef396-3fc3-27d6-283c-b8dffa10a7b7@synopsys.com>
 <CA+55aFzGaxhRRHXUcfnUDcgyaAKy4jXLcKMXH8T61x8sxEJT+g@mail.gmail.com>
 <5207b04e-5e80-7100-4328-7e87ee619aea@synopsys.com>
 <CAGZ79kZ3g+J5=ZmP8zDCK8zBwMc7SwLdmgyB3Sab8qkTE=enhQ@mail.gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <0b6e3682-9575-7b4c-6cde-7b914364abfc@synopsys.com>
Date:   Fri, 20 Jan 2017 10:44:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ3g+J5=ZmP8zDCK8zBwMc7SwLdmgyB3Sab8qkTE=enhQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Stefan,

Às 10:03 PM de 1/19/2017, Stefan Beller escreveu:
> On Thu, Jan 19, 2017 at 1:51 PM, Joao Pinto <Joao.Pinto@synopsys.com> wrote:
>> Às 7:16 PM de 1/19/2017, Linus Torvalds escreveu:
>>> On Thu, Jan 19, 2017 at 10:54 AM, Joao Pinto <Joao.Pinto@synopsys.com> wrote:
>>>>
>>>> I am currently facing some challenges in one of Linux subsystems where a rename
>>>> of a set of folders and files would be the perfect scenario for future
>>>> development, but the suggestion is not accepted, not because it's not correct,
>>>> but because it makes the maintainer life harder in backporting bug fixes and new
>>>> features to older kernel versions and because it is not easy to follow the
>>>> renamed file/folder history from the kernel.org history logs.
>>>
>>> Honestly, that's less of a git issue, and more of a "patch will not
>>> apply across versions" issue.
>>>
>>> No amount of rename detection will ever fix that, simply because the
>>> rename hadn't even _happened_ in the old versions that things get
>>> backported to.
>>>
>>> ("git cherry-pick" can do a merge resolution and thus do "backwards"
>>> renaming too, so tooling can definitely help, but it still ends up
>>> meaning that even trivial patches are no longer the _same_ trivial
>>> patch across versions).
>>>
>>> So renaming things increases maintainer workloads in those situations
>>> regardless of any tooling issues.
>>>
>>> (You may also be referring to the mellanox mess, where this issue is
>>> very much exacerbated by having different groups working on the same
>>> thing, and maintainers having very much a "I will not take _anything_
>>> from any of the groups that makes my life more complicated" model,
>>> because those groups fucked up so much in the past).
>>>
>>> In other words, quite often issues are about workflows rather than
>>> tools. The networking layer probably has more of this, because David
>>> actually does the backports himself, so he _really_ doesn't want to
>>> complicate things.
>>
>> I totally understand David' side! Synopsys is a well-known IP Vendor, and for a
>> long time its focus was the IP only. Knowadays the strategy has changed and
>> Synopsys is very keen to help in Open Source, namelly Linux, developing the
>> drivers for new IP Cores and participating in the improvement of existing ones.
>> I am part of the team that has that job.
>>
>> In USB and PCI subystems developers created common Synopsys drivers (focused on
>> the HW IP) and so today they are massively used by all the SoC that use Synopsys
>> IP.
>>
>> In the network subsystem, there are some drivers that target the same IP but
>> were made by different companies. stmmac is an excelent driver for Synopsys MAC
>> 10/100/1000/QOS IPs, but there was another driver made by AXIS driver that also
>> targeted the QOS IP. We detected that issue and merged the AXIS specific driver
>> ops to stmmac, and nowadays, AXIS uses stmmac. So less drivers to maintain!
>>
>> The idea that was rejected consisted of renaming stmicro/stmmac to dwc/stmmac
>> and to have dwc (designware controllers) as the official driver spot for
>> Synopsys Ethernet IPs.
>> There is another example of duplication, which is AMD' and Samsung' XGMAC
>> driver, targeting the same Synopsys XGMAC IP.
>>
>> I am giving this examples because although the refactor adds work for
>> backporting, it reduces the maintenance since we would have less duplicated
>> drivers as we have today.
> 
> This sounds as if the code in question would only receive backports
> for a specific
> time (determined by HW lifecycle, maintenance life cycle and such).
> 
> So I wonder if this could be solved by not just renaming but
> additionally adding a
> symbolic link, such that the files in question seem to appear twice on
> the file system.
> Then backports ought to be applicable (hoping git-am doesn't choke on symlinks),
> and after a while once the there no backports any more (due to life
> cycle reasons),
> remove the link?
> 
> This also sounds like a kind of problem, that others have run into before,
> how did they solve it?

I am currently involved in the PCI host/ refactor process and that will cause a
total reorganization of the folder, because a new PCIe Endpoint is comming up
from Texas Instruments. Bjorn (PCI Maintainer) is ok with it.
The network subsystem, is a very busy one, with lots of activity, and so I
understand David Miller' point, because he already has work overload, but we
have to find a way to improve it and prepare for the future.

I think this a hot topic, that should be discussed, since it might hold back the
evolution of some subystems.

Thanks,
Joao

> 
> Thanks,
> Stefan
> 
>>
>> Thanks,
>> Joao
>>
>>
>>>                Linus
>>>
>>

