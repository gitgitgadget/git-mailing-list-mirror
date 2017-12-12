Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6FB1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 16:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdLLQxR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 11:53:17 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:34519 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdLLQxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 11:53:14 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Onnse53XbAp17OnnsenRYY; Tue, 12 Dec 2017 16:53:13 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=5rxgeBVgAAAA:8 a=dIu3SnmMAAAA:8 a=NEAV23lmAAAA:8
 a=H-5mch-6-YSsrHaLek4A:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=PwKx63F5tFurRwaNxrlG:22 a=Ua9G7VpiFza3u12uuhVB:22
Message-ID: <5400ED3ACDCF49BA84399FDBFD7DDFF8@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christian Couder" <christian.couder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "git" <git@vger.kernel.org>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Jeff Hostetler" <git@jeffhostetler.com>,
        "Ben Peart" <peartben@gmail.com>, "Jeff King" <peff@peff.net>,
        "Lars Schneider" <larsxschneider@gmail.com>
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com> <CAP8UFD3Jt+0Lq9Yx_7x3sJD+jG+A25bAgDg7zp+dZV43+1-vow@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
Date:   Tue, 12 Dec 2017 16:53:11 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171211-6, 11/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPBs4L38l7KQYCx28WWRiErC3wzRWLf0GMz0esFiW304zW/JxVs8VHdrNsv5fkiUZtkiX4bjxjhlJpVIMMYdx5s3cltFpaEaEMw2/ZFZbXv7TPLjCxhA
 03xxdUV30Kfi2bMBwTR3hcJGrOPer3RKBlL/rmeoQecE1ebC80DdkzDvM2TOduyxZTPsOz0pGojKTRWRZwvzd5gqYSjdi6nKvK4c3eH3HEBoZID3MT2zKrav
 r5p9DwMmEtndnDA7ftL4alSpo4s8vn7hkiNOkhXhLOWE7x07e3OBo8ixdxA5h+xK3FK16UkuXEIeCWZi32EU2bZ2mzNoOxApPvAYf1FYrijn9QxP6s576XC5
 CVXgOjPA9QSzpXelKbzMyFUs/iCH3I/P/LFVk5xmrz6CmpekTEc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christian Couder" <christian.couder@gmail.com>
> On Thu, Dec 7, 2017 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * jh/object-filtering (2017-12-05) 9 commits
>>   (merged to 'next' on 2017-12-05 at 3a56b51085)
>>  + rev-list: support --no-filter argument
>>  + list-objects-filter-options: support --no-filter
>>  + list-objects-filter-options: fix 'keword' typo in comment
>>   (merged to 'next' on 2017-11-27 at e5008c3b28)
>>  + pack-objects: add list-objects filtering
>>  + rev-list: add list-objects filtering support
>>  + list-objects: filter objects in traverse_commit_list
>>  + oidset: add iterator methods to oidset
>>  + oidmap: add oidmap iterator methods
>>  + dir: allow exclusions from blob in addition to file
>>  (this branch is used by jh/fsck-promisors and jh/partial-clone.)
>>
>>  In preparation for implementing narrow/partial clone, the object
>>  walking machinery has been taught a way to tell it to "filter" some
>>  objects from enumeration.
>>
>>
>> * jh/fsck-promisors (2017-12-05) 12 commits
>>  - gc: do not repack promisor packfiles
>>  - rev-list: support termination at promisor objects
>>  - fixup: sha1_file: add TODO
>>  - fixup: sha1_file: convert gotos to break/continue
>>  - sha1_file: support lazily fetching missing objects
>>  - introduce fetch-object: fetch one promisor object
>>  - index-pack: refactor writing of .keep files
>>  - fsck: support promisor objects as CLI argument
>>  - fsck: support referenced promisor objects
>>  - fsck: support refs pointing to promisor objects
>>  - fsck: introduce partialclone extension
>>  - extension.partialclone: introduce partial clone extension
>>  (this branch is used by jh/partial-clone; uses jh/object-filtering.)
>>
>>  In preparation for implementing narrow/partial clone, the machinery
>>  for checking object connectivity used by gc and fsck has been
>>  taught that a missing object is OK when it is referenced by a
>>  packfile specially marked as coming from trusted repository that
>>  promises to make them available on-demand and lazily.
>
> I am currently working on integrating this series with my external odb
> series 
> (https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/).
>
I too had seen that, as currently configured, the 'partialClone' could be 
seen as a method for using the remote as if it were an object database (odb) 
that was part of an 'always on-line' capability. However I'm cautious about 
locking out the original DVCS capability of being off-line relative to some, 
or all, remotes and still needing to work in 'airplane mode'.

It should be OK for the local narrowClone (my term) to be totally off-line 
for a while and still be able to work when back on line with other suitable 
remotes, even after the original remote has gone.


> Instead of using an "extension.partialclone" config variable, an odb
> will be configured like using an "odb.<odbname>.promisorRemote" (the
> name might still change) config variable. Other odbs could still be
> configured using "odb.<odbname>.scriptCommand" and
> "odb.<odbname>.subprocessCommand".

The future work Jeff had indicated, IIRC, should be able to cope with 
multiple promisor remotes, which it's to be hope this could handle. I'm not 
sure how the odb code would handle a partial failure where a partition of 
the odb stops being available.

>
> The current work is still very much WIP and some tests fail, but you
> can take a look there:
>
> https://github.com/chriscool/git/tree/gl-promisor-external-odb440
--
Philip 

