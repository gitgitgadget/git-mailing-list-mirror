Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE835203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 18:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbcGXSqy (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 14:46:54 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36570 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcGXSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 14:46:54 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so111071892wma.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 11:46:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iL0SFDW3hzrfo0jHe+LT/ZXefURxOz54Chz7tHC7MXM=;
        b=j8ervw5XMLOx+UF0SpqqDOOGKGgplNQkysIltEplK9xUo7JOH2reWjHZhu+ov6JsW9
         0/VHy6E4lWS/QyTn6v7CWKB+qk1zJXN7Pe4Xn0DfPt1ZWJSkX64LQBaZeiIQ3N3NC3/q
         dvdwEEAUpPyNWgeBzMY+9vqVaGiNndCgxWGyrHMbNh8FvvUgcBXYLBQqoHIyltdCkb0Y
         k8HUE5qH4hMgFwwnq/9oQo8An3o5ZP8c4AYplTwGCOFDrZPU25JxXDryh/K7MxqGgDth
         pGTUG07WWoZXiPZMdF4GExgv5z0NH53MJgUBIkQ0v36RKAeFjCUXYKxoadtpNOdOI5+6
         fUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iL0SFDW3hzrfo0jHe+LT/ZXefURxOz54Chz7tHC7MXM=;
        b=KRGv8z8Y0litJz+FsH6xNNZvJixe7autQAVfsWpXU9JkuxrKEdBOvQpdMXmafAFNCj
         jLe3pDAi7ElyqDjzhtdzYDrn0v3VBqHp5+1qAIK9UcSN/KHzPSWF+kgxJz3r5zr0E3Xb
         fcixhhzrOGK0dox2p0FXNIX96BI+RNnDxWoTOseKOSYdaydlu41dDmt8VzRcNO7qN0WZ
         5PEcKZKltE2/occTuZB0c2dEcI7dLUIU4AjyYCvbPN/iY51+z2bZSsL9L5+9aJ+BsN+9
         /TJa81NVACzzqpgw6dt/UgYLCNE2keXDuWMCn3Z0d+Uu0+MNKMoxYXSsLQ8ZRtM5RBOx
         YA5w==
X-Gm-Message-State: ALyK8tKTJRWCJF8v7e9/F7EL1De3USp2pUqiPFFW+cO8UDo52kVj1hbGThOpFIwTjSISXg==
X-Received: by 10.28.197.68 with SMTP id v65mr37987751wmf.2.1469386012508;
        Sun, 24 Jul 2016 11:46:52 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id p1sm11838834wjd.37.2016.07.24.11.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 11:46:51 -0700 (PDT)
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
To:	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
References: <nn30dv$5sn$1@ger.gmane.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57950D12.2000607@gmail.com>
Date:	Sun, 24 Jul 2016 20:46:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <nn30dv$5sn$1@ger.gmane.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Please try to keep to the 80-character lines.

W dniu 2016-07-24 o 20:12, Jon Forrest pisze:

> Those of us who write instructional material about Git all face the
> same problem. This is that we can't write step by step instructions
> that show the results of making a commit because users will always
> see different commit IDs. This is fundamental to the design of Git.
> 
> Even if the instructional material tells users to use standard author
> and committer information, (e.g. john.doe@example.com) and shows the
> text of the file being committed and the commit message to add, the
> resulting commit ID will differ from reader to reader since the
> commit will presumably take place at different times.

There are two options: first, to tell the reader upfront that objects
id would be different / would change.  This has the advantage that
you do not need to update those objects when you change instructions
in the middle. Note that commit objects are not the only things that
change; for example the result of `ls -l` would also be slightly
different.

Another possibility is to set authordate and committerdate to some
specified time by the way of appropriate environment variables.

> 
> What if it were possible, for instructional purposes only, to somehow
> tell Git to relax this requirement. By this I mean, the commit date
> would *not* be included when constructing the commit ID. This would
> allow tutorials to show exactly what to expect to see when running
> commands.

What I think you don't realize is that "commit" objects are not
treated in any way special. Object identifiers of all objects are
SHA-1 hash of uncompressed loose representation of said object
(type + length + contents).

Well, you could not record dates in commit object, but I think
Git considers such objects broken.

> 
> I realize that questions would remain such as how to turn on this
> behavior (e.g. command line flags, environment variables) and whether
> 'git log' (and maybe other commands) should somehow distinguish
> these mutant commits. There would probably be other issues to
> consider.
> 
> Again, this is for instructional purposes only, and only when the
> committer explicitly chooses to use this option. I'm *not* proposing
> a general change to Git's behavior.
> 
> Is such a thing to ridiculous to even consider? Is there a better way
> to achieve the same result

IMVHO it would require heavy surgery of Git for little benefit
(see the beginning of reply for alternate solutions).
 
-- 
Jakub Narębski

