Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C36D1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfHYWle (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 18:41:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:45956 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbfHYWle (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 18:41:34 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i21CV-0002TA-4b; Sun, 25 Aug 2019 23:41:31 +0100
Subject: Re: [Feature Request] Option to make .git not read-only in cloned
 repos
To:     Albert Vaca Cintora <albertvaka@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
 <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
Date:   Sun, 25 Aug 2019 23:41:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/08/2019 20:58, Albert Vaca Cintora wrote:
> On Sun, Aug 25, 2019 at 7:54 PM Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 23.08.19 um 22:43 schrieb Albert Vaca Cintora:
>>> However, I'm sure that a large percentage of developers out there will
>>> agree with me that having to use force (-f) to delete every cloned
>>> repo is annoying, and even worse, it creates the bad habit of always
>>> force-deleting everything.
>> IMO, the bad habit is to delete cloned repositories all the time. If
>> your workflow necessitates this, then you are doing something wrong.
>> Maybe you have an X-Y-problem?
>>
>> -- Hannes
> There are plenty of valid workflows where one would delete a repo.
>
> What you suggest is like saying I shouldn't delete pictures from my
> camera, because in that case I shouldn't have taken them in the first
> place.
>
> Sometimes I clone a repo just to grep for an error string and then I
> don't need it anymore, or I clone several repos until I find the one
> that contains what I want and delete the rest. Sometimes I want to
> write a patch for some software I don't develop regularly so I don't
> need to keep a clone of it.
>
> In any case, it would be useful to know the reason those files are
> read-only in the first place. Do you guys know who might know?
>
> Albert
Surely (?), if we are considering our stored revisions to be immutable, 
then removing the write bit is the right thing to do.
If I understand correctly (*) we don't separate the delete permission 
from 'no-write' permissions, so the consequence will be that such files 
are read-only.

Philip

(*) I'm primarily a Windows user, so certain Linux nuances pass me by 
;-). I simply delete the repo folder then click the gui dialog to agree 
to delete the r/o files. Simples.
