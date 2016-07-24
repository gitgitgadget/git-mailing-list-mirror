Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F287D203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 20:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcGXUmn (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 16:42:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36630 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbcGXUmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 16:42:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so14000546wma.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 13:42:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kj1qDnsruyG7qkK3oxW2HIn4ZjWRPx1BawmjjQCVl1s=;
        b=zBo8sa0Dkc+keVYkOEnoWw6fsRbqRJhdGcdXdbLpzA30FSKXW5F8BxPBhg0pGEoyV9
         04p7UxkgEemGMilujkp0JVUP+RK2AyrDzvP9NaH70HGphogf019UG+nixIZ/C7Bl45rc
         HuVNKCbuCXJSW+gvN6IGGKATiZSoV3k/MFrN4etCru4Jqf9cqJUH+zE200A40aIMbI6c
         0ev1qKwwXqJzXMoCRg4m6T4SeQGr+oN/WGa4k+tPlvYv7AaUcGPTp1MDW1retSwPbUTF
         i6a93t5o9bJQIVcl9aSnnYjgcl9ztqKCAi7I8k+W4ZsPACsKssHPcSz3ZKxEDeqbAWrT
         hGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kj1qDnsruyG7qkK3oxW2HIn4ZjWRPx1BawmjjQCVl1s=;
        b=hQD9R0e0KL6RezkzbtTeB1C1672GXJLYPCOPacb89yPpHLFxdm2XMR+0TPFUEBiJCs
         JtovmjLU7d+EJJ8ca9nktxo3otcyDYAlBMB3h1CVofNMi2D0DEE/IAR0haiNjvUodoAE
         eUrK0XWzamk+6gCRBiHStwaXBU/Q1d/u2jMX79tCq+gRStPqVe2sW3NtLx2M5eZfq1wW
         IYQp1va05zG5dGDBkzMwZbDt9TWablqGU57/DPcrHuu6atquBAy2r2K9PzW+LzaVNvxb
         PUhtFl7linUrWbLc9Txh1lFvIPkuPzWwPbiNAopSe/Sax9IMsJ3OQloA5vXJKkE+V/QB
         bW1Q==
X-Gm-Message-State: AEkoousQxpbCP26dcW8GY6DtYOoTH+H1H0TNGtC890gYILebp3bdK6SQOyE2KFtjg0blOg==
X-Received: by 10.194.175.201 with SMTP id cc9mr11937434wjc.38.1469392960663;
        Sun, 24 Jul 2016 13:42:40 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id i3sm12252919wjd.31.2016.07.24.13.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 13:42:39 -0700 (PDT)
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
To:	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
References: <nn30dv$5sn$1@ger.gmane.org> <57950D12.2000607@gmail.com>
 <cfff11c9-e212-88a1-c00b-3e7a361e0db9@gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57952834.60706@gmail.com>
Date:	Sun, 24 Jul 2016 22:42:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <cfff11c9-e212-88a1-c00b-3e7a361e0db9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-24 o 21:20, Jon Forrest pisze:
> On 7/24/2016 11:46 AM, Jakub Narębski wrote:
>> 
>> Another possibility is to set authordate and committerdate to some
>> specified time by the way of appropriate environment variables.
> 
> That sounds like a great idea. Assuming it
> works the way I envision, this wouldn't require
> any changes to the source code.

This would however require for user to write more.
The environment variables are GIT_AUTHOR_DATE and GIT_COMMITTER_DATE;
their format is described in the "DATE FORMATS" section in the
git-commit(1) manpage.

And it is not something that the user would do when working
with Git themselves, for their own project.

>> What I think you don't realize is that "commit" objects are not
>> treated in any way special. Object identifiers of all objects are
>> SHA-1 hash of uncompressed loose representation of said object
>> (type + length + contents).
> 
> I know this, but I thought that commit object IDs were the only
> ones that included a date in what gets run through the SHA-1
> hash function. If there are others, then you're right - they'd
> need to be included in this proposal.

The problem is that many function in Git are object-type agnostic.
Changing how 'commit' objects are treated would require heavy code
surgery... unless done as filter (see below), but even then extra
code would be needed, for small benefit and large maintenance
burden.

Now that I think about this, it could be done when displaying
object names (in `git log` and `git show`), replacing true commit
object with SHA-1 of those objects with dates stripped. Still
needs work.

>> Well, you could not record dates in commit object, but I think
>> Git considers such objects broken.
> 
> You mean that Git could, after the fact, detect commit IDs
> that didn't include a date? If this is true, then your
> idea of using fixed dates from environment variables
> would be the only way to do this.

I think^H^H `git fsck` can check that objects are well formed,
and warn if they are not.

$ git fsck
error in commit 6deb0829fecdf1feab0cc7c66061a92a93cb19e7: 
  missingSpaceBeforeDate: invalid author/committer line - missing space before date
error in commit 762f28c2567c07d378d485c3e2a498947d49f406: 
  badDate: invalid author/committer line - bad date

>> IMVHO it would require heavy surgery of Git for little benefit
>> (see the beginning of reply for alternate solutions).
> 
> Even using your environment variable solution that wouldn't
> require any code changes?

No, this do not need no changes to git code, of course.

-- 
Jakub Narębski

