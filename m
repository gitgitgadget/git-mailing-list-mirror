Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD681FF76
	for <e@80x24.org>; Thu, 22 Dec 2016 08:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757079AbcLVIPT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 03:15:19 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49988 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755014AbcLVIPS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Dec 2016 03:15:18 -0500
X-AuditID: 12074413-465ff70000000a33-30-585b8b940574
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 75.12.02611.49B8B585; Thu, 22 Dec 2016 03:15:17 -0500 (EST)
Received: from [192.168.69.190] (p57906F97.dip0.t-ipconnect.de [87.144.111.151])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBM8FFYi001895
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 22 Dec 2016 03:15:16 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
 <046b088c-afd5-66b9-fe3c-255e42a7d768@alum.mit.edu>
 <bfbd5992-da30-b1f0-59e5-a2f36d2e3062@xiplink.com>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <24a89c72-af53-0c87-d148-708e014ebe75@alum.mit.edu>
Date:   Thu, 22 Dec 2016 09:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <bfbd5992-da30-b1f0-59e5-a2f36d2e3062@xiplink.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqDu1OzrCYNdtGYuuK91MFitn3GC0
        WHNkMbsDs8fcXX2MHp83yXkcuPyYLYA5issmJTUnsyy1SN8ugStj48m5LAVbZCvO77/J0sD4
        TLyLkZNDQsBE4sa2PcxdjFwcQgKXGSUezJ8B5VxgkvjU2ccGUiUs4CfxeOIkMFtEwEdiefdc
        doii64wSCz+3soMkmAXEJdbNPQ9mswnoSizqaWYCsXkF7CW2zjvICmKzCKhK9C96yQJiiwqE
        SFyec5QNokZQ4uTMJ2BxTqD6iZdXsUHM1JPYcf0XK4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG
        5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIWEqvINx10m5Q4wCHIxKPLwO
        U6IihFgTy4orcw8xSnIwKYnyahRGRwjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4WXsAMrxpiRW
        VqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR407uAGgWLUtNTK9Iyc0oQ0kwc
        nCDDeYCGf+gEGV5ckJhbnJkOkT/FqCglzpsNkhAASWSU5sH1wtLIK0ZxoFeEeZ1BVvAAUxBc
        9yugwUxAg22bwQaXJCKkpBoYy9MXB5064b+S4VTdnd55BzXVrha+0k+tW1uwtbbHpnt6Q2fm
        7VMcG9ZM+Vhz3aJhpkXVnxip87fX6M30kMls/61T+rVSSnzrfGX3VRLfikRyLa5ubj0U3Mka
        vPbGosaOculTC5oLpLrD0+0/c397btBz33ji5CdLX3z6wVG2+duzng9y7vIRSizFGYmGWsxF
        xYkA2U1z2/4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2016 08:07 PM, Marc Branchaud wrote:
> On 2016-12-20 07:05 PM, Michael Haggerty wrote:
>> On 12/20/2016 04:01 PM, Marc Branchaud wrote:
>>> [...]
>>> Please don't change the remotebgcolor default.
>>>
>>> Also, perhaps the default remoterefbgcolor should be
>>>     set remoterefbgcolor $headbgcolor
>>> ?
>>>
>>> I say this because when I applied the series, without the last patch, I
>>> was miffed that the remote/ref colour had changed.
>>
>> This is a one-time inconvenience that gitk developers will experience. I
>> doubt that users jump backwards and forwards in gitk versions very often.
> 
> In what way do you mean it's restricted to gitk developers?

Maybe I misunderstood your objection.

While developing this, I realized that the very first time your run gitk
(i.e., when you don't already have a configuration file), it writes the
then-current default colors into your configuration file. If you later
switch gitk versions to a version with different default colors, the
colors from the first-run version are preserved (unless the names of the
variables used to hold the colors are changed).

So if you would run the tip version of my branch first, then the parent
of that version, you would continue to see the colors as modified by the
final commit. If you then switch to the master version, the remote
branch names go back to green (because it goes back to using
`headbgcolor` again), but the remote prefix stays light brown. I thought
you were unhappy about some form of this unexpected persistence problem.
But this problem will mostly be experienced by gitk developers who jump
back and forth between versions.

A normal user probably mostly moves forward through version numbers, and
only occasionally. Such a user, jumping from master to the tip of my
branch (assuming they haven't customized anything), would see

* local branches stay lime
* remote branch prefixes stay pale orange (they don't change to light
brown because the pale orange color from master is stored in their
configuration file)
* remote branch names change from lime to brown (because the
`remoterefbgcolor` configuration setting didn't exist before)

> Patch 12 introduces remoterefbgcolor, with a specific default value.
> Prior to that, the "ref part" of remote refs was rendered with
> headbgcolor.  Users who changed their headbgcolor are used to seeing the
> "ref part" of remote refs in the same color as their local heads.
> Applying patch 12 changes the "ref part" color of remote refs, for such
> users.
> 
> All I'm saying is that make the remoterefbgcolor default be $headbgcolor
> avoids this.

For somebody who thinks that most people will want local and
remote-tracking branch names to be rendered in the same color, your
suggestion would be an improvement.

But for somebody like me who thinks it is a good idea to render
remote-tracking branch names in a different color than local branch
names, this is a feature, not a bug. Even a user who explicitly
configured `headbgcolor` to, say, purple, wasn't necessarily expressing
a wish to have remote-tracking branch names rendered in purple. Until
now they had no choice to set these colors separately!

So even for somebody who configured this setting before, I think that
having the remote-tracking branch names change color when the user
upgrades to this version is a good thing, because it lets the user know
that these two things can now be colored independently. If they don't
like the new default brown color, such a user knows where to change it
(even to make it agree with `headbgcolor` if they want that).

But I understand that this is a matter of personal preference. I have
but one "vote" :-)

Michael

