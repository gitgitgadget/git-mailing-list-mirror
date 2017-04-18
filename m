Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525011FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 11:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbdDRLu2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 07:50:28 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34954 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbdDRLu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 07:50:26 -0400
Received: by mail-wr0-f178.google.com with SMTP id o21so100700371wrb.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMyknREZpS1MD/2niqPtl1OF1nDjZL/tqv5UvrOZ0jY=;
        b=j1x5UWbVBo9DLnPCx+KXXeyctYb2CX41+SDCl90v4bDTcvsFfSwUzjwDdAXHG5yotf
         tI32l9TRaza4WvdPiWUIPLIh9l/fdxJVRDaQDhSg4F8aYmcFzh6LmbI5L+5eCWxQ53hz
         GyG04/ruBMfILlGHS0BoDLkiBzGuapYBGuL5onBYIT2MFNTlEmxIT1xyl1RZVVSnY98u
         Y/6HqYx5QKhzM/eqYtiosghcyUPp7g2iLp9rd4qN5xsL3BJoL3XA2vPcWmvd0ErLT939
         Oa7xQg3tICZoZmMEMyfchtHhwzBIH7rnZxNyzcsllW3gOdjV0hLoIvCJ9qRJkVmDIcCN
         FQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMyknREZpS1MD/2niqPtl1OF1nDjZL/tqv5UvrOZ0jY=;
        b=SBt5T54tfiUK4kb69fEobtCVORY138U/eVyjmO371YT2gWfOpu1dXsdu4v2X3j9HdE
         nTnwSTwXzlFJURtzpdIGPqB9S7UHPKvf1p267oJjGZ/59KM6X61gAwg5tp94kf2jxYWg
         dCZZ/P6E+eRxDXPdClok9e+qQcAw0tjeqp2UjxotIPX+IN5gaKpIVarz134U5hHoyzpC
         wpPHszpEsR6d6Ef91b1cAxWCa95rHWpNtg3x6G/fz/nBqJY5jdFT0zvawvZYsEE9WyNm
         qUrOpYACyFsymGflYaeQARJkRcgDSQ83K+BiNSH4FTGapYlvumtkyysmcevNq/Ax3KOQ
         M8ww==
X-Gm-Message-State: AN3rC/6zr1lTqVsSFvdduTctC538brDqizKeLXDchODgKAG9w8YEf/ml
        dYpF6MUD17VNYA==
X-Received: by 10.223.173.167 with SMTP id w36mr21285541wrc.68.1492516224417;
        Tue, 18 Apr 2017 04:50:24 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box (p5DD30C29.dip0.t-ipconnect.de. [93.211.12.41])
        by smtp.googlemail.com with ESMTPSA id o71sm18563624wrb.47.2017.04.18.04.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 04:50:23 -0700 (PDT)
Message-ID: <1492516221.5720.22.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Tue, 18 Apr 2017 13:50:21 +0200
In-Reply-To: <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley>
References: <1492287435.14812.2.camel@gmail.com>
                                 <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
                         <1492347718.19687.14.camel@gmail.com>
                         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
                 <1492368692.22852.9.camel@gmail.com>
                 <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
         <1492380399.19991.13.camel@gmail.com>
         <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
         <1492452173.11708.22.camel@gmail.com>
         <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-04-17 at 21:59 +0100, Philip Oakley wrote:
> I've added back the list, as it was accidentally dropped.

Thanks. I'm sorry. I apparently pressed the wrong button in my emails
client. What I wrote is visible in your quote.


> From: "Christoph Michelbach" <michelbach94@gmail.com>
> > I understand what the command does. It behaves perfectly as I
> > expected
> > it to. I did not find this script but wrote it to demonstrate that
> > what
> > the documentation says is different from how it behaves after having
> > read what the documentation says it should do and noticing that
> > that's
> > not how I expected it to work from experience.
> > 
> > What it really does is to copy all files described by the given
> > paths
> > from the given tree-ish to the working directory. Or at least that's
> > my
> > expectation of what it does.
> > 
> > The documentation, however, says that the given paths are
> > *restored*.
> > This is different.
> I don't see that difference in the phrase *restored*, compared to your
> 'copy 
> all files described by the given paths'. Could you explain a little
> more?

Suppose you have X. If you say X is restored to what it was half an hour
ago, I expect everything about X to be exactly as it was half an hour
ago. So if X is a file containing the text "Hello, world!", I expect
there to be a file (with the exact same file name) which contains the
text "Hello, world!", even if I changed that text in the mean time or
deleted the file entirely. If X is a folder which contains files, I
expect it to have the exact same contents as before. If there were 5
files in the folder half an hour ago, I expect there to be 5 files with
the same file names and the same content in each file, again, even if I
deleted, renamed, changed the contents of, or added files in the mean
time. This is, however, not the case. Suppose I renamed a file from
"foo" to "bar". Then there are 6 files, not 5. This is not how X was
half an hour ago.

If you, however, say that all files in the path X are copied back from
what they were half an hour ago, if X is a file, I expect the exact same
thing as before for it. And that's actually what happens in reality. But
if X is a folder, there's a difference: Because only the *files X
contains* are copied back – *not X itself* –, all the files in X which
do not occur in the state from half an hour ago, are unaffected. So now
I expect there to be a 6th file because there is no file "bar" in the
state from half an hour ago which could overwrite the file "bar" in the
working tree.


> > Yeah, definitely. There should be 2 separate entries for this.
> > 
> > I think someone thought it was a good idea to make `<pathspec>...`
> > optional in the synopsis because `git checkout` behaves in that
> > special
> > way if a patch *or* paths are given. But then, of course, with both
> > `-
> > p|--patch` and `<pathspec>...` optional, the command is the same as
> > the
> > first variation, just with optional parameters -- but the
> > documentation
> > (correctly) says those variations should behave very differently
> > from
> > each other.
> > 
> > I don't see how this can be avoided without having 2 separate
> > entries
> > for those cases.
> true.

So now we have to find someone who used that command with both a patch
and a tree-ish present a lot because I have no idea how that would
behave and don't even know why you would use it.


--
Christoph
