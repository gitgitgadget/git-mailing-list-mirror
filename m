Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9460C1FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 03:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbcFVDjn (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 23:39:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34007 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbcFVDjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 23:39:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id 66so2823051pfy.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 20:39:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YrW8M2RVjG1j4EM2iKFMnvSg71QImnPFtDnifiE2TmE=;
        b=NUL2/6hm0wRe44Vz3WNMMSsy+j1sWXNB67CnD1A71A0xL9JgYiLlWr6ZBKM2Qov5aT
         K8h4ZxHZUBZUjK6NIWJhHZNCq+KxLKjZ6tR32AW7ICta+rBRjvr1bDjKGnIJgHjVIX2M
         6ArWewIUUZGkJetoabCxUnO2EeBdULjyBtwsF2RjfE1+Le5kENn6cKc3K/DsfPdwSMzL
         97mS6ArZf8vIy3veAfeQOfyX0ugHmSwjjrN9FOFC8LPNipFoqkFoDpDSpoRTGCnv/Sjg
         cPLjXq3G8Zb+Xlozcn4AE/ZBVzf/l8Jzn8cf3bUbht3WKSfB1HdpWvpf7QwgkZBflY4s
         uOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YrW8M2RVjG1j4EM2iKFMnvSg71QImnPFtDnifiE2TmE=;
        b=Os9+pofzAyk+hR8KsVOmdoJntaNxsrscw5BrbZTF9QPEK1OYYOI9Tox66T8UcxWZbe
         RR8zTn7QQaRhSGEya09gnv3oVgQE5kMhP7guF7XsQJGiGb7QDeTm3aeWVKLvpHygYFHs
         eWnsKjrASFaQ1AyKHSiZleJSR2JF4MfKubk750AX8lL+0Y4FEUKP7coiTC5RXnA2yBxg
         4XpnGPQqR/pg98cxJiyXOeb4uoq8Kwi+81FxviqKMKyqry5FUTVZmWqD+6TlxiXVT87o
         Gr+ax4tcdcnW5RPwGKa5zXM615u6fr0RKc5CPE4p2AYOxgGGhuDVB/e65O1ZMQjJ4Jj8
         Z9lQ==
X-Gm-Message-State: ALyK8tJZVeRtj/nGei0oZ66T/qZUzHH4B9LhZJm7GaXTg5bvOcqS4hx3u+yo2wKwCf6Hlg==
X-Received: by 10.98.68.84 with SMTP id r81mr32111058pfa.26.1466563345603;
        Tue, 21 Jun 2016 19:42:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:283a:27bd:7d15:7c1c])
        by smtp.gmail.com with ESMTPSA id 4sm36392702pfi.24.2016.06.21.19.42.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2016 19:42:24 -0700 (PDT)
Date:	Tue, 21 Jun 2016 19:41:52 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Andrea Stacchiotti <andreastacchiotti@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: git-htmldocs.googlecode.com is no more
Message-ID: <20160622024151.GA20206@google.com>
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146652690896.29270.13813898006180324611.reportbug@duelitri>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

http://git-htmldocs.googlecode.com/git/git.html says

 There was no service found for the uri requested.

Link to the HTML documentation on repo.or.cz instead.

I'd rather use an up-to-date https link for the rendered
documentation, but I wasn't able to find one.  According to the 'todo'
branch, prebuilt documentation is pushed to

 1. https://kernel.googlesource.com/pub/scm/git/git-htmldocs
 2. git://repo.or.cz/git-htmldocs
 3. somewhere on git.sourceforge.jp and git.sourceforge.net?
 4. https://github.com/gitster/git-htmldocs
 5. https://github.com/git/htmldocs

Of these, (1) and (4) don't provide a raw view with content-type
text/html.  (5) might be available as HTML through Jekyll, but I
wasn't able to find it --- e.g., https://git.github.io/htmldocs does
not show those pages.  I wasn't able to find (3) at all.  That leaves
(2).

Reported-by: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Andrea,

Andrea Stacchiotti wrote[1]:

> In the git manual (`man git`), the documentation link:
> > http://git-htmldocs.googlecode.com/git/git.html
> is broken.

Thanks for reporting.  How about this patch?

Thanks,
Jonathan

[1] http://bugs.debian.org/827844

-- >8 --
Subject: doc: git-htmldocs.googlecode.com is no more

 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5490d3c..de923db 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -31,8 +31,8 @@ page to learn what commands Git offers.  You can learn more about
 individual Git commands with "git help command".  linkgit:gitcli[7]
 manual page gives you an overview of the command-line command syntax.
 
-Formatted and hyperlinked version of the latest Git documentation
-can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
+A formatted and hyperlinked copy of the latest Git documentation
+can be viewed at `http://repo.or.cz/git-htmldocs.git/blob_plain/:/git.html`.
 
 ifdef::stalenotes[]
 [NOTE]
-- 
