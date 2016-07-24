Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A665203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbcGXS1Y (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 14:27:24 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37251 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcGXS1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 14:27:22 -0400
Received: by mail-wm0-f47.google.com with SMTP id i5so128262363wmg.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 11:27:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=o7LJF6PpiM0owcoFu+fWcee/8RzA47NaZf4FQJ78cxE=;
        b=rS03hdHxNWR4rW6C2h2CNRJexmgmITDg3xQeC77T6TXV9Uk5CbZNNopQOchfqaaW2o
         lCMOpuQ5FZ+nh79axZeIdafvgKE2C3bhESVXXgnbomZcXtUrklNxJNhZ2Df6RCVMrRdX
         FIMewEr8NnV+TtjDeD5N0YBLpI5UZTKOSGOYSxUkyzotNDcHiWeOuXZVoaz79v33yT9/
         SlxGEx1cvQPVJVgyS1MyDyEEE6Vv3/e2Y6Z0Ycc11bQ+Bb+ZIyzVGGWIVmGHNJO9Z8Et
         LhanAJmkPWrt+1PD8fHp+K4+kWzrEj5wAeqQTcXkzDzgl/1TsXpy9o1gYKSK7p+979J0
         qL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=o7LJF6PpiM0owcoFu+fWcee/8RzA47NaZf4FQJ78cxE=;
        b=cz2daFzLcUHfvq9tCuT2Fj8kdXMsmbJG7IcUMhBCJE+uXZnXcWMTTy2fKBdZavTTuk
         Ew3hYHlBRng6/FpKQa3jo8Vp1Qwnrf64t4uGKRKgNSQs32DiiEAnBDhHrxw90VlJ1ZJT
         WT1OUEszTvE2Rrb0jIDqvUHFOd+QE40QRDaeE6LlhgxFpLphuCBkvitMt5BzIi/EDz9z
         Qn8lc8L1sVtRteFZPclOrjNhBzh+gk1VnmPykZFRHaCLjBfRX2ii/Lfr+Bz7YqFyU9cP
         p3AmA9Z0/VgFPk/m1woYW5RlCILhh4dENHgC3WZENRfUWxclSrLJYi1wwv3NOzUCWBEL
         J+rw==
X-Gm-Message-State: AEkoout/C20bUehi4tvHoQA2GrhbGlqrry8+6Ity/rNaVgT3MxAb1zk0jhZfoBs3eNHzag==
X-Received: by 10.195.13.18 with SMTP id eu18mr11617215wjd.121.1469384841183;
        Sun, 24 Jul 2016 11:27:21 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id k186sm20999305wmd.13.2016.07.24.11.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 11:27:20 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Jon Forrest <nobozo@gmail.com>
References: <nn1euf$h6q$1@ger.gmane.org> <579483B7.4090508@gmail.com>
 <6f7eea6b-2446-5740-cbec-141d71a33ea1@gmail.com>
 <CANQwDwcy_AXTmG02ynNanNvoNVnK+t3uxf5r1J5tHn1hxaZ9kg@mail.gmail.com>
 <d7918e4a-c4c7-c85f-1aba-3cb9a59e6eba@gmail.com>
Cc:	git <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5795087C.4010503@gmail.com>
Date:	Sun, 24 Jul 2016 20:27:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <d7918e4a-c4c7-c85f-1aba-3cb9a59e6eba@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-24 o 19:34, Jon Forrest pisze:
> On 7/24/2016 10:19 AM, Jakub Narębski wrote:
> 
>> As far as I can see you cannot view it online (without downloading).
> 
> True. I changed the way the HTML file is generated so that it
> contains all the images downloading it is as good as viewing
> it online. I'm not current with the thinking about the merits
> of online viewing vs. downloading. Is one more accepted than the other?

In my opinion being able to view it online has its advantages.
Even casual reader can check it, and point errors or offer suggestions
for improvements.

> Also, I realized one potentially major disadvantage of sharing in
> Google Drive. This is that the URL will change each time I update
> the book. Apparently Google is taking away the ability to create
> a static link at the end of August 2016.

I think you can share a folder instead, and this would be stable.
Alternatively, when updating the book you could update the link
in the GitHub repository description and/or the README for the
fork.

> If this book turns out to be popular enough that I have to change it
> then I'll have to revisit how to share it. Github Pages looks interesting
> but it isn't clear to me how to put this book there since it's written
> in AsciiDoc.

Well, https://git.github.io/htmldocs/git.html is on GitHub Pages
(for a project, that is in https://github.com/git/git.github.io repo
that is also used for Git Rev News), and it obviously uses AsciiDoc.

You can use Jekyll, or you can just upload HTML, as described
in https://help.github.com/articles/creating-project-pages-manually/
(this one is for per-repo GitHub Pages, i.e. using orphan branch
gh-pages, not a special named repository like e.g. git.github.io).
After each change / release you would need to rebuild HTML version
and upload to GitHub pages. This can be automated with hooks.

BTW. I thought that Pro Git used Markdown, not AsciiDoc?
 
>> Ah. Could you tell me the summary of those changes?
> 
> There are too many to summarize. Some are of the type that the proofreader
> should have caught, and others are my attempt to clarify things. Since I
> don't claim to be a Git expert it remains to be seen how successful I am.

All right. One issue I have after browsing through changes is that
description of changes and their granularity is severely lacking.
"A few more very minor changes.", "More piddly changes.", "should have
included this in last commit" are not good commit messages.

If I find time to comment on changes, I would do that on GitHub,
commenting / adding notes on changes there (like the one I posted
as demo: 
  https://github.com/nobozo/progit2/commit/43ae203c2ccf1a017153de1b41a8c47eb166dba1#commitcomment-18372006

Best,
-- 
Jakub Narebski

author of "Mastering Git"
https://www.packtpub.com/application-development/mastering-git
http://shop.oreilly.com/product/9781783553754.do
https://www.amazon.com/Mastering-Git-Jakub-Narebski/dp/1783553758
 

