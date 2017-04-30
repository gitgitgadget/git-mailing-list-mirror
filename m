Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D8B1FC3E
	for <e@80x24.org>; Sun, 30 Apr 2017 03:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035833AbdD3D0s (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 23:26:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49493 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030854AbdD3D0r (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Apr 2017 23:26:47 -0400
X-AuditID: 12074413-0e1ff70000001dc3-59-590559744388
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 41.12.07619.47955095; Sat, 29 Apr 2017 23:26:45 -0400 (EDT)
Received: from [192.168.69.190] (p57906CBA.dip0.t-ipconnect.de [87.144.108.186])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3U3Qf10026625
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 29 Apr 2017 23:26:42 -0400
Subject: Re: [PATCHv2 0/3] Make diff plumbing commands respect the
 indentHeuristic.
To:     Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170428223315.17140-1-marcnarc@xiplink.com>
 <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a0d14b53-01c2-c653-15c9-ff566d24a782@alum.mit.edu>
Date:   Sun, 30 Apr 2017 05:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqFsayRpp8PmhiUXXlW4mi5UzbjBa
        /GjpYbbYvLmdxYHFY8GmUo9nvXsYPT5vkvM4cPkxWwBLFJdNSmpOZllqkb5dAlfG2ctfWAra
        OSouHHjD1MC4l62LkZNDQsBE4vuluSwgtpDADiaJUwecIOwLTBJ/ZzGB2MICoRKfFzWA2SIC
        LhIz1jYA9XIB1SxilFj35BIzSIJZwFpi9YNmVhCbTUBXYlFPM1gDr4C9xO3dc8GWsQioSkzs
        eAxmiwqESMxZ+IARokZQ4uTMJ2BHcAItmPd9JhPETHWJP/Ng5stLbH87h3kCI/8sJC2zkJTN
        QlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZI0ArvYNx1Uu4QowAH
        oxIP74RjLJFCrIllxZW5hxglOZiURHkfarNGCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh9fQF
        yvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHhPRwA1ChalpqdWpGXm
        lCCkmTg4QYbzAA1vAqnhLS5IzC3OTIfIn2JUlBLn3Q6SEABJZJTmwfXCksorRnGgV4R5a0Gq
        eIAJCa77FdBgJqDB9WosIINLEhFSUg2MqdsYbxxOOhTX/66gW/PBdMnQZ/2cNcdnbdvxr15c
        cmJatvqUORF5UptWPJgl5bVvYl6r8vPUyRMNgg88Tjy8+fTCR5u2fPN3O/rg8JYrm5P1jy6S
        E3nMO01G+2mbafBdPveSrok+PvnGM9ds+/1zlsC8D6aVcq+F51R8jTHx0jvh9itxn/LqA0os
        xRmJhlrMRcWJAPJHL3gFAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/29/2017 02:40 PM, Jeff King wrote:
> On Fri, Apr 28, 2017 at 06:33:12PM -0400, Marc Branchaud wrote:
> 
>> v2: Fixed up the commit messages and added tests.
>>
>> Marc Branchaud (2):
>>   diff: make the indent heuristic part of diff's basic configuration
>>   diff: have the diff-* builtins configure diff before initializing
>>     revisions
>>
>> Stefan Beller (1):
>>   diff: enable indent heuristic by default
> 
> Thanks, these look fine to me. I'd like to get an ACK from Michael, in
> case he had some other reason for omitting them from git_diff_ui_config
> (from my recollection, it's probably just a mix of conservatism and
> following what the compaction heuristic had done).

That's exactly right. The only discussion I remember about broadening
the scope of diff options was with regards to `blame` [1]. I don't
really have enough overview of these configuration topics to have much
an opinion.

Michael

[1]
http://public-inbox.org/git/xmqqtwebwhbg.fsf@gitster.mtv.corp.google.com/

