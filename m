Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95926203C1
	for <e@80x24.org>; Tue, 13 Dec 2016 06:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbcLMGQl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 01:16:41 -0500
Received: from mout.web.de ([212.227.15.4]:56656 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbcLMGQk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 01:16:40 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MF3Rz-1cQskC1z9X-00GH1d; Tue, 13
 Dec 2016 07:16:35 +0100
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it
 exists
To:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
 <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
 <c96d013c38df7737cfd551a0fce87314@drbeat.li>
 <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
 <xmqqr35dm203.fsf@gitster.mtv.corp.google.com>
 <954eed6b-c899-4f4c-eb3d-2b6d2ff4385d@drbeat.li>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d91b5e69-9b90-e21e-0dcb-8eace00ddd74@web.de>
Date:   Tue, 13 Dec 2016 07:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <954eed6b-c899-4f4c-eb3d-2b6d2ff4385d@drbeat.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Rvet94oREMAOuRmrCo+0NKNbSnPXKyaNU2yU7X8zeTg9ekTPq2W
 7pOpp3ONKFoTa4/A0l9otiiufEwlbmVdX3AS58U2TWY//5jaUXOey+ypFP6AfIiESFJZzYz
 9MdJsy9M5jbK0FMNsXCMaFfOWtGIRa8fkVufRYsLKkBYxQE2A7j2dP9SW58QpfiCAm8FMCv
 joA8earuBNNVBFG6z5pQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MFYkSgXfBsA=:4Vkn5huQTvdywZeXZeEkQY
 H0t7W42Sf1dc9cXQJXmCsvu32iS6xXRvTcFhDvaOck5mBkAP05VRFTaVz6XD/pBe73XPv2G4i
 zEs7nN5hpH43U61E9IZ8laxiFRoHPlNC3U5or3VzKV86PAF2KBHySn/W15lGvCmM9dYmunzdc
 hn6nGkAmH04I4Ti5tyTOoCl2SOxSd0Y2hyhimOCulbA+vijUgLGiiqLEOmK93W6Lwyk9Kc3rU
 d/MjNT6UAZViKVjuNmibNa2IKxKB+YHEHnOXPg4HVe4DdF7JXh5YUvvyIXHMJmsTzTPRKqIql
 Q3AqXGfyHNcNx1Jqd/xldgGpHS4plMAUXFqcWrWyd+cTkiF8DFlywR9KpSnZoAUcXAoHdzs6M
 9vqqefXuwXpfV0kAgWL+eU+PsJVIOTk2DQPKoAvZJ/HMR8Bdj1BQu737J4C2U4wYfZjYHg/Hh
 Tt/UScBgJy/a5AH8+IqnE5AYn0yXUBivjVTthTkSDZ+lse9RieEf42byFW71V9BXXpO8PHZ/V
 rGbiNDI0QNuGDrTj4XBq0aF/tJus3dvfxvJUEKfSdxsGtFgibav/RSCFqQbWerdGp5JqTzL4x
 vLiwrTa2MEE8VMWpCKzlgUC8tkZ9GF0qeWD3agTEzSw9b5HJa4lihqaiP2AWWvy8AbxNI4+5c
 Ua06WYpM5hUwLR0WnnNHoqt02/qyrfg69WkpET89C8zV5ZGNoN18035+4I8WgA3EERDz/DUtb
 3QYGZBo6mNsy/5vECwTqwWJ9zHHGm+B7zGI6p4bnlRTd4ebiglMZcfD/YdFzXe9Qd3Dms6/y+
 XwuvLIW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> Sure, and I'd rather see the update-unicode.sh script moved
>> somewhere in contrib/ while at it.  Those who are interested in
>> keeping up with the unicode standard are tiny minority of the
>> developer population, and most of us would treat the built width
>> table as the source (after all, that is what we ship).
>>
>> To be bluntly honest, I'd rather not to see "update-unicode.sh"
>> download and build uniset at all.  It's as if po/ hierarchy shipping
>> with its own script to download and build msgmerge--that's madness.
>> Needless to say, shipping the sources for uniset embedded in our
>> project tree (either as a snapshot-fork or as a submodule) is even
>> worse.  Those who want to muck with po/ are expected to have
>> msgmerge and friends.  Why not expect the same for those who want to
>> update the unicode width table?
>>
>> I'd rather see a written instruction telling which snapshot to get
>> and from where to build and place on their $PATH in the README file,
>> sitting next to the update-unicode.sh script in contrib/uniwidth/
>> directory, for those who are interested in building the width table
>> "from the source", and the update-unicode.sh script to assume that
>> uniset is available.
OK with the contrib - that's an improvement.
About the instructions how to download and compile:
(we don't need to change the  $PATH, do we ?)
I don't know.
The typical instructions I have seen are a sequence of shell commands
to be executed, which hopefully simply work by doing "copy-and-paste".
I find this error-prone, as you you may loose the last character while
moving the mouse, or don't check the error message or return codes.
Having a pre-baked shell script, which does use "&&" is in that way more 
attractive,
and the README can be as simple as run "update-unicode.sh" and that's it.

uniset is a small project and where should we put it ?
a) inside the Git tree?
b) /tmp ?
c) into the $HOME directory ?
d) /usr/local

a) is quick and dirty
b) probably OK
c) Not sure about tha
d) Needs super user rights
Can we try to find a good place ?

"contrib/uniwidth/" may be different to find, how about contrib/update-unicode ?
  

> OK. So please don't merge bb/unicode-9.0 to next yet; I'll prepare a
> reroll following your description.
>
> Torsten, is this alright with you?

sure

> Cheers, Beat


