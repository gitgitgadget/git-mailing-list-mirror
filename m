Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C703D1FF76
	for <e@80x24.org>; Wed, 21 Dec 2016 00:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbcLUAGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 19:06:00 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45651 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753937AbcLUAF6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Dec 2016 19:05:58 -0500
X-AuditID: 1207440c-e3bff700000009a1-8f-5859c7640e54
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 60.9F.02465.467C9585; Tue, 20 Dec 2016 19:05:57 -0500 (EST)
Received: from [192.168.69.190] (p57907272.dip0.t-ipconnect.de [87.144.114.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBL05sn5008337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 20 Dec 2016 19:05:55 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <046b088c-afd5-66b9-fe3c-255e42a7d768@alum.mit.edu>
Date:   Wed, 21 Dec 2016 01:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqJt6PDLCYPt6bouuK91MFitn3GC0
        WHNkMbsDs8fcXX2MHp83yXkcuPyYLYA5issmJTUnsyy1SN8ugSuju/sNS8Fx+Yq3G1+xNzDe
        l+hi5OCQEDCRWLZdvIuRi0NI4DKjxK8fK1ghnAtMErO+T2PrYuTkEBbwk3g8cRKYLSLgI7G8
        ey47iC0kkCNxZOkZJhCbWUBcYt3c82BxNgFdiUU9zWBxXgF7iQVv9rKBLGMRUJU49DUXJCwq
        ECJxec5RNogSQYmTM5+wgNicQOVt9/vYIEbqSey4/osVwpaX2P52DvMERv5ZSFpmISmbhaRs
        ASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQAOXZwfhtncwhRgEORiUe
        XgG7yAgh1sSy4srcQ4ySHExKorwZHUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxGx4ByvCmJ
        lVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJXkmQRsGi1PTUirTMnBKENBMH
        J8hwHqDh54+CDC8uSMwtzkyHyJ9iVJQS530MkhAASWSU5sH1whLIK0ZxoFeEeQ+BVPEAkw9c
        9yugwUxAgxd2h4MMLklESEk1MPbE+Pv+XDzZqGB1iuayWP0tzEc2GVQukfb+lDincrp9U7KK
        A09NqLVi59EKI7PnGZqBXfJt1wWc3EXZXnOeNOjSaaje8vZwlH1jTNpCDc7vAQUrH6ULccne
        W5O0+vimT3W7Te4v8pT7qlZ/xpDPXaV/2cUsruZb1TX893IvavBKpqhz9dxTYinOSDTUYi4q
        TgQAHc1pUPsCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2016 04:01 PM, Marc Branchaud wrote:
> On 2016-12-19 11:44 AM, Michael Haggerty wrote:
>> This patch series changes a bunch of details about how remote-tracking
>> references are rendered in the commit list of gitk:
> 
> Thanks for this!  I like the new, compact look very much!
> 
> That said, I remember when I was a new git user and I leaned heavily on
> gitk to understand how references worked.  It was particularly
> illuminating to see the remote references distinctly labeled, and the
> fact that they were "remotes/origin/foo" gave me an Aha! moment where I
> came to understand that the refs hierarchy is more flexible than just
> the conventions coded into git itself.  I eventually felt free to create
> my own, private ref hierarchies.
> 
> I am in no way opposed to this series.  I just wanted to point out that
> there was some utility in those labels.  It makes me think that it might
> be worthwhile for gitk to have a "raw-refs" mode, that shows the full
> "refs/foo/bar/baz" paths of all the heads, tags, and whatever else.  It
> could be a useful teaching tool for git.

Yes, I understand that the longer names might be useful for beginners,
and the full names even more so. However, I think once a user has that
"aha!" moment, the space wasted on all the redundant words is a real
impediment to gitk's usability. It is common to have a few references on
a single commit (especially if you pull from multiple remotes), in which
case the summary line is completely invisible (and therefore its context
menu is unreachable). I don't like the idea of dumbing down the UI
permanently based on what users need at the very beginning of their Git
usage.

Would it be possible to use the short names in the UI but to add the
full names to a tooltip or to the context menu?

>> * Omit the "remote/" prefix on normal remote-tracking references. They
> 
> If you re-roll, s:remote/:remotes/:.

Thanks.

>>   are already distinguished via their two-tone rendering and (usually)
>>   longer names, and this change saves a lot of visual clutter and
>>   horizontal space.
>>
>> * Render remote-tracking references that have more than the usual
>>   three slashes like
>>
>>       origin/foo/bar
>>       ^^^^^^^
>>
>>   rather than
>>
>>       origin/foo/bar (formerly remotes/origin/foo/bar)
>>       ^^^^^^^^^^^              ^^^^^^^^^^^^^^^^^^^
>>
>>   , where the indicated part is the prefix that is rendered in a
>>   different color. Usually, such a reference represents a remote
>>   branch that contains a slash in its name, so the new split more
>>   accurately portrays the separation between remote name and remote
>>   branch name.
> 
> *Love* this change!  :)
> 
>> * Introduce a separate constant to specify the background color used
>>   for the branch name part of remote-tracking references, to allow it
>>   to differ from the color used for local branches (which by default
>>   is bright green).
>>
>> * Change the default background colors for remote-tracking branches to
>>   light brown and brown (formerly they were pale orange and bright
>>   green).
> 
> Please don't change the remotebgcolor default.
> 
> Also, perhaps the default remoterefbgcolor should be
>     set remoterefbgcolor $headbgcolor
> ?
> 
> I say this because when I applied the series, without the last patch, I
> was miffed that the remote/ref colour had changed.

This is a one-time inconvenience that gitk developers will experience. I
doubt that users jump backwards and forwards in gitk versions very often.

I do find it strange that gitk writes a color selection to its
configuration file *even if the user has left it at its default*.
Normally I would expect only user-changed settings to be written to the
config file, and other values to use the default that is built into the
program. For example, such an approach would have made the transition
from "green" to "lime" easier.

> [...]

Thanks for your feedback!
Michael

