From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Tue, 17 May 2016 10:07:16 +0200
Message-ID: <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com> <20160513103621.GA12329@dcvr.yhbt.net> <xmqqpospap8g.fsf@gitster.mtv.corp.google.com> <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com> <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <e@80x24.org>, Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 10:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2a2M-0003lW-LA
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 10:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbcEQIHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 04:07:24 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37522 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054AbcEQIHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2016 04:07:20 -0400
Received: by mail-wm0-f48.google.com with SMTP id a17so16297610wme.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9NMLa4slkQPVXJ0SVpsuxkGqctbhBKMe7/bznTjGkB8=;
        b=aXpcXfl8r5kXuT1M8LOOpJ6jEaY+6lMm7BbViudOS7b+v/BgAVtFJCUFCeF6bSu07k
         ntMbPlFvUiIWsIpZRNXJxQp/SNqtQchJtpKqwSc8R5jwiM3yWVF5pdUiYw44n2DroOVK
         +UVXdk2vbSWVcIVye9JFGt64cePs5NLoXU6DFQd68HbudGm2Vkyk/p6rGTqjUR5djVKD
         oZXiFwgGdtYGQlxfV0tTVqM/Bi/F/u0ohe45U5fvNi13+xLym16YzrT0R4lXvWe9niHt
         U0YIhb5NQzTeCJBy1qiMs4LexXbkLh/FVSLF1VYO8aOqFNfyRz+cAdD0ScB0XNjFuZqe
         naDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9NMLa4slkQPVXJ0SVpsuxkGqctbhBKMe7/bznTjGkB8=;
        b=Ifh2As99cQqPxRAJOkA/iN2dvQBHWeJlsfRV1xq1roLWIz/eUMuMEniEuLqPPQaXjc
         jea1jBvetYq8nHajqqo8MlOxmROp5YzM/62v2fvCiQX02eUbZr12WeyGMqwz+LhpdsQq
         NHxABKuopA+lviL6CLxkhC6dZvmuwpU+o+ZyoFs23Uf8gGfOGP1zEuYpfOd4sLo3hXaF
         /thR/V44oao3XgoMvUwZdfSzx9av5bQAf8UD5pwAZHhfw/zU7gCUYf4lpXolFzIx0OV7
         jmV+clmnqZ2zwAT2pru05xZnnLtYP8BeMSi+SsBQ7YQiaO4GIW221u8Jx8B2G+JK6rO8
         XPOg==
X-Gm-Message-State: AOPr4FV5LV6qHwK5JrUB/1qHd385SyOo9LWX1RCGvTY3x0oBvUnxE6KFhh1FHH28NbMR8A==
X-Received: by 10.28.101.215 with SMTP id z206mr21328586wmb.37.1463472438869;
        Tue, 17 May 2016 01:07:18 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA3A9.dip0.t-ipconnect.de. [80.139.163.169])
        by smtp.gmail.com with ESMTPSA id i1sm1655526wjm.12.2016.05.17.01.07.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 May 2016 01:07:18 -0700 (PDT)
In-Reply-To: <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294859>


> On 14 May 2016, at 20:15, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> On 13 May 2016, at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> Are you saying that "git p4" itself breaks unless fast-import always
>>> writes a new (tiny) packfile?  That sounds quite broken, and setting
>>> unpacklimit to 0 does not sound like a sensible "fix".  Of course,
>>> if the test script is somehow looking at the number of packs or
>>> loose objects and declaring a failure, even when the resulting
>>> history in p4 and git are correct, then that is a different issue,
>>> and forcing to explode a tiny pack is a reasonable workaround.  I
>>> couldn't quite tell which the case is.
>>> 
>>> Puzzled.  Please help.
>> 
>> t9801 "import depot, branch detection" is the first test that fails
>> with a fast import error:
>> https://github.com/git/git/blob/78b384c29366e199741393e56030a8384110760d/t/t9801-git-p4-branch.sh#L110
>> 
>> fast-import crash report:
>>    fast-import process: 77079
>>    parent process     : 77077
>>    at 2016-05-14 07:48:40 +0000
>> 
>> fatal: offset beyond end of packfile (truncated pack?)
> 
> Hmm, does that suggest Eric's "explode them into loose instead of
> keeping a small pack" insufficient?  It sounds like that somebody
> wanted to read some data back from its packfile without knowing that
> the updated code may make it available in a loose object form, which
> would mean that somebody needs to be told about what is going on,
> namely, these objects are not in a half-written pack but are found
> as loose objects.

I think that is pretty much the problem. Here is what is happening:

1.  git-p4 imports all changelists for the "main" branch

2.  git-p4 starts to import a second branch and creates a fast-import
    "progress checkpoint". This triggers:

    --> fast-import.c: cycle_packfile
    --> fast-import.c: end_packfile
    --> fast-import.c: loosen_small_pack

    At this point we have no packfile anymore.

3.  git-p4 sends the command "commit refs/remotes/p4/depot/branch2"
    to fast-import in order to create a new branch. This triggers:

    --> fast-import.c: parse_new_commit
    --> fast-import.c: load_branch
    --> fast-import.c: load_tree

    "load_tree" calls "find_object" and the result has a "pack_id" of 0.
    I think this indicates that the object is in the packfile. Shouldn't
    the "pack_id" be "MAX_PACK_ID" instead?

        myoe = find_object(sha1);
        if (myoe && myoe->pack_id != MAX_PACK_ID) {

    --> fast-import.c: gfi_unpack_entry

    In "gfi_unpack_entry" this condition evaluates to "true":

        struct packed_git *p = all_packs[oe->pack_id];
        if (p == pack_data && p->pack_size < (pack_size + 20)) 

    In the comment below Git thinks that the object is stored in the
    packfile. This seems wrong but the flow continues:

    --> sha1_filec: unpack_entry
    --> sha1_filec: unpack_object_header
    --> sha1_filec: use_pack

    At this point fast-import dies with "offset beyond end of packfile 
    (truncated pack?)".

I am no expert in "fast-import". Does anyone have a few hints how to
proceed?

Thanks,
Lars