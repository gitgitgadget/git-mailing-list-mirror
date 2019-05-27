Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297DC1F462
	for <e@80x24.org>; Mon, 27 May 2019 15:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfE0PcM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 11:32:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:60269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfE0PcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 11:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558971129;
        bh=AMh3hQwawklaoE20mESDVlmljSYWshiTSeDdRj2wxEI=;
        h=X-UI-Sender-Class:From:Subject:To:Date;
        b=QbS6rJcir9lL//FP1imKe1akwh2eaarrA74UIPo/52FWwZNgKO/BAtcIbWZlCz1V4
         I43V37tyu15aVo5gKbXHiTcgYWj66LOOf2qvUA2XjE/5OixUzRuwlngRsLMuqy63KW
         RUUd1qSuZf9E5aOI3tkOfNFD3osBWXoHQp91ozck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([78.54.16.150]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1guZwR1riM-00cB1J for
 <git@vger.kernel.org>; Mon, 27 May 2019 17:32:09 +0200
From:   Ingo Wolf <ingo.wolf@gmx.de>
Subject: worktree add already exists
To:     git@vger.kernel.org
Message-ID: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de>
Date:   Mon, 27 May 2019 17:32:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZKS5t1g/YnddaIh5d7oazrDnwknSBXEPPV4jBylnvtfl1bLgyG
 b5UFR8PHz6m8ztjThWdLqAgij/4wTDehc7EHCn8H827CmDOJeSBFatVkOUxR5y9WZHKTr2N
 WORaeTN49TNz0pbXAfHl4cn7R670CfGS8fvgeitDhnXJI6tzcMtYrKWIIYnmzfVFRenZqF2
 D4zRw2CSGBk0ESiFZHFiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IZ2IDiUqaD8=:J9fvMoe2dwBv5s2Y/7kRTh
 SShmE+kbJDnFeLeGUUQL50nhBgkp+oURgHyMsAn/Qe+Ri8dpf7JVHVLbiqNCDn0RUsi32J/Du
 61JL2WcFoT2tizRsterNLFFJw34ebSsVlWGPLTpJahGKAJ/zpFmMPqW1STBVR3ezGk4C28bDK
 3fDmGz3TS4lDfML8aMBJmqzjpykKpd/plakMpW59k9MXTEQjB2LzReDtl0dFRmpuLycH96rkg
 CqDbwDCaddnSR/cU/tLDNZ+iqZ/fft6fQYAF24AiRMdGsuW3BerwLHLiudskvGligAGgCo1/5
 UFGmi9pyg2uWKnExSWVy/QkY28wzf91dYVqKGRjJbo5P/DgzfPd5wDqtolnZwl7ZV0saPYisQ
 7IYGcPoqqyJFzBwOg4iC+R4eNL8fA6mmnD5DE8O76NOUTa4x5Ej4zJXfp0qedgNJnHgC7BkUE
 5sEwA3DVHf7uSuCyfFa7CZMyX+QUDuZw9/XOBqfYKBMo8ndVvNbHr56jAD3JaqtJGpxgxNQCi
 AeJBPDP5mWTzBwYCxJbdlbotvMM4MkqcEH7SlwXc5tp/wGbhevSJLzsrvsAc8sAf6SHZvkOum
 HWpjraohYsTSdAbcDGdqFTEcS2/PrSV2Zpb5qVU0yJibeKjm/rKcRFktG/bwl5fuJVv+EzVqF
 k2SwGDnAJEvMqwx8mN+5Ldl5rNwfRkymtBFD0Fn3SFnmsTpzvlvsWiehDr0nHXxjOC1LDosY6
 3XBEZgRELsGIQeYsoHvhgWYxgcbDAMW4d0wswxs8YFJEN92McARxGFFxhxdJvS5HXzDMcCxdj
 FR1E9pJQc7uIEoSEzhgeBY6fk7M+1YxQ8u9ruQzAp9nfNNcfPPSWObiE7ENVqMMR5KCsdZ6hH
 JKQcK1YNwnG5SNDemA2/Sg9xvQl8HJ6u+J21DtV99z8F8L5FjIbwsw+utp6iyEsbuwrCEnMQy
 CcUdJwA+R27i6IXX4rHBe/vu/LsLiKKa3HjEWZ5v4RwS/hQODz/tF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


x@y MINGW64 ~/gittest
$ ls
bare/=C2=A0 barework/

x@y MINGW64 ~/gittest
$ ls -a barework
./=C2=A0 ../=C2=A0 test.txt

x@y MINGW64 ~/gittest
$ git -C bare branch
* master

x@y MINGW64 ~/gittest
$ git -C bare worktree add --no-checkout ../barework
Preparing worktree (new branch 'barework')
fatal: '../barework' already exists

x@y MINGW64 ~/gittest
$ git -C bare branch
 =C2=A0 barework
* master

Why this doesn't just work and if not why is barework branch made then,
why at all ?

I would like to attach an existing dir to git (make it a workdir) and
then update the index with git reset and checkin the differences.

I can do that tricking around with a little dir renaming, new empty dir,
move the .git file and rename back...


