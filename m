Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DBB1F576
	for <e@80x24.org>; Fri, 16 Feb 2018 10:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbeBPK6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 05:58:03 -0500
Received: from fallback7.mail.ru ([94.100.181.128]:47386 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934610AbeBPK6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 05:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=D68VoRdZRdJl82SVY1kjG73a1F11AaDqBLusYH31UC0=;
        b=PKuiRlMrXbdEzE31PYH1sP9thILhBcErZ3SUyNRz2dWrq3AWPD9KKDkLBiLE/ALS5KnGVSvuwxE/TRER5Cc+kfTWPok4A3H2nPAZ2WiOlELrtfIBQPONpmCQykSFwp3WCp90L1ka60Tz26KeHjFGs/5MYvCoo1Q0jBLdZ/FpXlM=;
Received: from [10.161.25.36] (port=40746 helo=smtp59.i.mail.ru)
        by fallback7.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
        id 1emdiK-0006hc-0c
        for git@vger.kernel.org; Fri, 16 Feb 2018 13:58:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=D68VoRdZRdJl82SVY1kjG73a1F11AaDqBLusYH31UC0=;
        b=PKuiRlMrXbdEzE31PYH1sP9thILhBcErZ3SUyNRz2dWrq3AWPD9KKDkLBiLE/ALS5KnGVSvuwxE/TRER5Cc+kfTWPok4A3H2nPAZ2WiOlELrtfIBQPONpmCQykSFwp3WCp90L1ka60Tz26KeHjFGs/5MYvCoo1Q0jBLdZ/FpXlM=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1emdiH-00059z-MS; Fri, 16 Feb 2018 13:57:58 +0300
Date:   Fri, 16 Feb 2018 13:57:56 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     hgfds jhgfds <lvl100p@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is the -w option for git blame bugged?
Message-ID: <20180216105755.ouexuzktevnxrqwf@tigra>
References: <CAOrVMvvM4XUsE0v7oxotD8yPHkmstG-mQYuhF0OsC-bETGQ-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOrVMvvM4XUsE0v7oxotD8yPHkmstG-mQYuhF0OsC-bETGQ-Og@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A550B0302E3E13AB5B70A469DFBB528F5EEE928EAF31F0B597725E5C173C3A84C3AA8C68A3574AB3B4CFF6FDE959DE6282463FC242DBD691A6C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4CC21984B17E27C07BF71FFA19A2D047E6A493BF296159046FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 05:47:41PM +0800, hgfds jhgfds wrote:

> I recently asked a question on stackoverflow regarding what seemed to
> be erroneous output from git blame when the -w option is specified.
> However, no one answered my question, so I decided to ask here
> instead.
> 
> The question is available at
> https://stackoverflow.com/questions/48808281/git-blame-ignore-whitespace-option-bugged
> 
> Hope someone can help to shed light on this issue soon.

This is indeed the correct place to ask such questions.
Still, the next time please literally ask the question - inclusing its
full text - rather than dropping a link: few people bother do to that,
and even fewer of them have an SO account to actually answer it.
So it's both just basic netiquette and increasing the circle of the
potentional helpers ;-)

In order to remove the churn, I've copied and pasted your question here;
hope you have no issues with me doing this.

--------------------------------8<--------------------------------
Based on my understanding, the command `git blame` is supposed to show, for
each line in a file, the author and the commit in which the line was last
modified.  So for example, if I run

git blame -- "<filename>"

and get the following output for line 5:

106b77db (Walrus 2016-03-24 10:01:36 +0800   5) .root {

it means the line

.root {

originated from the author Walrus in the commit 106b77db.
In other words, if I inspect the patch produced by 106b77db using
`git show -p 106b77db`, I would expect the line

+.root {

to show up in the diff. Indeed, this is the case.

Snippet from 106b77db's diff for <filename>:

 /* JavaFX CSS - Leave this comment until you have at least create one rule       which uses -fx-Property */
+.root {
+   -fx-background-color: transparent;
+}
+

Now, when I run

git blame -w -- "<filename>"

(the -w option ignores whitespace changes, i.e. traces each line backwards in
time to find the last author which introduced non-whitespace changes to that
line), I now get the following output for line 5:

b6a6e8a2 (Walrus 2016-03-31 23:32:50 +0800   5) .root {

However, when I inspect the patch for b6a6e8a2 using

git show -p b6a6e8a2

the diff shows

.root {

rather than

+.root {

as expected.

Snippet from b6a6e8a2's diff for <filename>:

+
+/* setting window to be transparent================================ */
 .root {
    -fx-background-color: transparent;
-}
-

Has Git given me erroneous output, because according to the diff, the line
.root { was not modified at all in the commit b6a6e8a2?

I am using Git 2.13.3.windows.1.

EDIT: the repository is https://github.com/cs2103jan2016-f14-2j/main,
and the file is JimplePlanner/src/application.css.
After upgrading to Git 2.16.1.windows.4, the issue still persists.
--------------------------------8<--------------------------------

