Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C76A1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 12:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdBFMRg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 07:17:36 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35865 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdBFMRd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 07:17:33 -0500
Received: by mail-wr0-f196.google.com with SMTP id k90so3021120wrc.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 04:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zWW4uxepzKnMffgZUXHztwwUt4p+CCD51mx/zsBDFVM=;
        b=FBB+7/wG8Qgsk7H2dNOihQTN3vOutuoiKx35jOpuAF3nimXZtDGEgXHfHCNog7cQPu
         yf7uDt240f2hr9FixSYXfYcrs3TI9ka3jVMXSbxX1pUfRx9eQqQnLIIHPioVWz12UmU1
         hJ3XjJQ0z9zGCBXcxhUijbrnv+LBtFqiUE7CiUCygZv/MNI6XNona3tcOB8+Vk6OSR+0
         lg9g0oE++c2eUjwqoywzunGz1MzvRH/YZp0JaRB3p2EN58OFcuP0fZ0/KhxRnAJsAOTr
         YfSjc1s5Fyp9c5ALcckxxUgIvFSJipT3bEkPMPKlhDkZ2nY8I6y87+Vu/PsrAw/RM+5O
         1byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zWW4uxepzKnMffgZUXHztwwUt4p+CCD51mx/zsBDFVM=;
        b=QCZJrc8Y2slA9W2emIrg3b4kyiXmhlvRON7DkwIRf0wmWwf79YZjO9nJMD5K3ak/IV
         J3vythtact7xWwr+8G4sWoTthS7yMZQUQoaBDHz3gzjS1tFGshPQbyLOCL4qIYs8HqGc
         TtEWp9yShDp/zscDYR7MF+wWRJe2qhr0+ebU300EtqPfr0oop4hdC9nj7WIuUoDs4WRO
         Y3YTazj9rXpLaTuDiVnbkVodm+UTDUtf4ZL5KyWR1pVgVFGRd4/8Y7AWP9ICmF9UqbFM
         pSeIHQYT9p5oIIOpqDFEIEyjEzCXE9zI50k8VuebI8VgCws0fGmvbZYWn1KTR5CW5PQl
         7XQA==
X-Gm-Message-State: AIkVDXLhtyOjEkajgYDanPzmF1+N3blSRMSABd3bJp6vc1QTSnDW6sPZ/raUlbEA4+3/Ug==
X-Received: by 10.223.153.144 with SMTP id y16mr8978872wrb.81.1486383452049;
        Mon, 06 Feb 2017 04:17:32 -0800 (PST)
Received: from [192.168.141.122] (27.21.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.21.27])
        by smtp.gmail.com with ESMTPSA id b15sm1201039wra.4.2017.02.06.04.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 04:17:31 -0800 (PST)
Subject: Re: gitconfig get out of sync with submodule entries on branch switch
To:     Stefan Beller <sbeller@google.com>
References: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
 <CAGZ79kaZUOO4qusCDF9=VJ-6QPjAvc5eSaazjWWEocRMHuTSug@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Benjamin Schindler <beschindler@gmail.com>
Message-ID: <7e54658a-dcb2-64a7-3c67-0c4fa221b2fb@gmail.com>
Date:   Mon, 6 Feb 2017 13:17:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaZUOO4qusCDF9=VJ-6QPjAvc5eSaazjWWEocRMHuTSug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06.02.2017 11:35, Stefan Beller wrote:
> Answering the original email, as I feel we're going down the wrong rabbit
> hole in the existing thread.
>
> On Mon, Jan 30, 2017 at 8:21 AM, Benjamin Schindler
> <beschindler@gmail.com> wrote:
>> Hi
>>
>> Consider the following usecase: I have the master branch where I have a
>> submodule A. I create a branch where I rename the submodule to be in the
>> directory B. After doing all of this, everything looks good.
>> Now, I switch back to master. The first oddity is, that it fails to remove
>> the folder B because there are still files in there:
>>
>> bschindler@metis ~/Projects/submodule_test (testbranch) $ git checkout
>> master
>> warning: unable to rmdir other_submodule: Directory not empty
>> Switched to branch 'master'
>
> checkout currently doesn't support submodules, so it should neither
> try to delete B nor try to repopulate A when switching back to master.
> checkout ought to not even touch the existing submodule B.

Well, it tried to remove the folder (the rmdir warning) but it failed so 
in some sense you are right. Is there a technical reason for this 
default though? Here, I frequently have to point out to people that they 
need to initialize/update the submodule on e.g. clone.

>
>>
>> Git submodule deinit on B fails because the submodule is not known to git
>> anymore (after all, the folder B exists only in the other branch). I can
>> easily just remove the folder B from disk and initialize the submodule A
>> again, so all seems good.
>
> by initializing you mean populating(?), i.e.
>
>     git submodule update
>
> would work without the --init flag or preceding "git submodule init A".
> That ought to not redownload A, but just put files back in the working tree
> from the submodule git directory inside the superprojects git dir.
>
>>
>> However, what is not good is that the submodule b is still known in
>> .git/config.
>
> Oh, I see. You did not just rename the path, but also the name
> in the .gitmodules?

I wasn't even aware that the submodule name was something different from 
the path because the name is by default set to be the path to it. So 
yes, I didn't just relocate it, it had a different name.

>
>> This is in particular a problem for us, because I know a number
>> of tools which use git config to retrieve the submodule list. Is it
>> therefore a bug that upon branch switch, the submodule gets deregistered,
>> but its entry in .git/config remains?
>
> The config remains as it indicates that you express(ed) interest in
> submodule A, such that when switching branches
>
>   master->renamedToB->master
>
> then we'd still care about A. As for the tools, I'd rather see them use
>
>     git submodule status/summary
>
> instead of directly looking at the config, because the config may
> change in the future.

That was my feeling but its good to know to have more solid reasons why 
that would be.

Cheers
Benjamin

>
>>
>> thanks a lot
>> Benjamin Schindler
>>
>> P.s. I did not subscribe to the mailing list, please add me at least do CC.
>> Thanks
