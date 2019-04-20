Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F0D20248
	for <e@80x24.org>; Sat, 20 Apr 2019 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDTNVv (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Apr 2019 09:21:51 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:22149 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfDTNVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Apr 2019 09:21:51 -0400
Received: from [192.168.1.12] ([92.21.144.249])
        by smtp.talktalk.net with SMTP
        id HpwCh0rIQgI7iHpwChelgC; Sat, 20 Apr 2019 14:21:49 +0100
X-Originating-IP: [92.21.144.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=Dgn57AdRJ25t4HaDIyq3iQ==:117
 a=Dgn57AdRJ25t4HaDIyq3iQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20 a=eMzIYPjOC_qz7ZhTCx0A:9
 a=QEXdDO2ut3YA:10 a=APqgjxcRD6nqXdMuohh7:22
Subject: Re: Git subtree error on windows 10 with 2.21 version
To:     Nicola Farina <nicola.farina@gpi.it>, git <git@vger.kernel.org>
References: <1509193182.25902858.1554893159368.JavaMail.zimbra@gpi.it>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <bba4ef95-7ec4-e755-23da-28c34abda8dc@iee.org>
Date:   Sat, 20 Apr 2019 14:21:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1509193182.25902858.1554893159368.JavaMail.zimbra@gpi.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfG1wciOXMVRbDGqw86bBo9jafT6/wrC95GQmpUd3s0LPWWXqoZNdrCnf4heeJXfTeadn6wQd0cZGCz0UxfJVq6+r+ewxOEQsUl+C5INStFS00Zn78bMK
 7Y9fmsgpRJ06652vL9Negg+rm9+mmasxbIqfxvRJ6Asy/Fpo8TyT+ZL5DFWSyFzdEiSYKVHqJp8EejPGcbtsIWye2JfpEADYbJ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nicola,

On 10/04/2019 11:45, Nicola Farina wrote:
> Hi
>
> After upgrading to 2.21 issuing this subtree command:
>
> git subtree push --prefix ouverture Shared-Ouverture master
>
> I get these errors:
>
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory
>
> I have installed git choosing the option "use git with bash only"
>
> thanks for any suggestions/help
> Nicola
I don't have any solution at the moment, but given it's Git-for-Windows 
it is worth also logging it as an issue at 
https://github.com/git-for-windows/git/issues and searching for 
additional clues on the GitHub site (including closed items)

Also what are the commands at those lines in the code?
--
Philip
