Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECF91F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 12:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409360AbfJQMYR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 08:24:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfJQMYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 08:24:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HC9Pug014774;
        Thu, 17 Oct 2019 12:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2SOi+yOvifARKTdZueuOWwzS6KmvruH+Cv9v65kxebg=;
 b=WMgijF4mCJHTNbCWNF+6WBUnk0LMSICmdN+PfRdJJGNvlPMJlErr0D/Ybys2x3zLVTHB
 xAhrEipmmMUlWU4Tqa96MzPW8KQFuhOw/rTCKyucJfBzg7pcIHS5KaX4mPfKJCLEpcaL
 vYH84951E0cWzV22BRgSh3JYQw5cBezWpJ/i2vowvAo57zGHKphhdaahj3oeDFlakkMs
 f0DvElYXbWJSJ+QG2WAmWYNCZp0r4cdq+0FrWcD8WRlwTSFM3OARKxZpznzRYBH9VPSg
 TgHwAJKtMdEPud5Xk1k4s6N6dkjm96Xze204BjsK+qY5o4YU+oft324x++BfhI6sHVzG 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7frnrtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 12:24:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HCMtB4032584;
        Thu, 17 Oct 2019 12:24:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vpf13s0ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 12:24:08 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HCO4lD004813;
        Thu, 17 Oct 2019 12:24:04 GMT
Received: from [10.175.56.189] (/10.175.56.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 12:24:04 +0000
Subject: Re: email as a bona fide git transport
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com>
Date:   Thu, 17 Oct 2019 14:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170113
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/16/19 5:00 PM, Pratyush Yadav wrote:
> On 16/10/19 12:22PM, Vegard Nossum wrote:
> Just to play the devil's advocate, even though I'm in favor of something
> like this, I'll add in another disadvantage:
> 
> - The maintainer can't make small edits before pushing the changes out.
> 
> I do that every now and then for git-gui, and Junio does that sometimes
> for Git. I don't know if the folks over at Linux do something like this,
> but using '--exact' would mean that contributors would have to send a
> re-roll for even minor changes. Its mostly an inconvenience instead of a
> problem, but I thought I'd point it out.

I don't think this is a problem.

The point of 'git am --exact' is not for maintainers per se (although
they should use it if they don't have any manual changes to make), but
for the bot that keeps track of patchsets submitted via email.

The important part is that there is a git reference to the patchset that
was submitted in the patchset that was merged. You could see it as the
maintainer rolling a new version of the patchset locally and merging
that instead of merging what was submitted directly.

Of course, this relies strongly on actually having (correct) sha1
references to previous versions inside the changelog. In my original
idea, this reference would only appear inside the merge commit that
binds the patchset together to minimise churn, although maybe it is
feasible to also append it to each patch -- in that case, the "patchset"
command from my first email is not sufficient to create a new version of
a patchset.

> One more question, not strictly related to your proposal: right now,
> when I apply patches from contributors, I pass '-s' to 'am', so the
> applied commit would have my sign-off. The way I see it, that sign-off
> is supposed to signify that I have the right to push out the commit to
> the "main" repo, just like the author's sign-off means that they have
> the right to send me that commit.
> 
> Looking at git.git, I notice that Junio does the same. The new '--exact'
> would be incompatible with '-s', correct (since the commit message has
> changed, the SHA1 would also change)? So firstly, make sure you account
> for something like that if you haven't already (I haven't found the time
> to read your patches yet). Secondly, is it all right for the maintainer
> to just not sign-off on the commits they push out?

In the Linux kernel at least, only the front-line maintainers add their
signoffs; higher-level maintainers take pull requests and don't add
their own sign-offs. Only Linus (and Greg, perhaps) has commit rights to
the main repository, but he only signs off on the patches that he either
writes himself or applies directly from email.

In any case, I don't think this is a concern because of what I wrote
above -- somebody who wants to add their signoff can do it by
essentially rolling a new version of the patchset that has the signoff,
but refers to the sha1 that was submitted to them by the patchset author
so that you can still find the original commits (without the signoffs)
and reviews/discussions.

I don't want to create extra work for maintainers, so I think any
solution should involve having the existing git tools/workflows do the
right thing automatically.

How about this? If 'git am' or 'git am -s' (without --exact) finds an
email patch where the exact commit metadata is present, it automatically
appends a line to the changelog saying where it was taken from:

     Submitted-as: 111122223333444455556666777788889999aaaa

or

     Applied-from: 111122223333444455556666777788889999aaaa

Although, again, this would modify the changelog of the patch itself
rather than just the changelog of the merge commit... Maybe this is
enough and we can have the "patchset" command also add references to
previous versions of each patch rather than the patchset as a whole.


Vegard
