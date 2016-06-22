Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705D120189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbcFVRi3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:38:29 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33170 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbcFVRi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 13:38:28 -0400
Received: by mail-pa0-f65.google.com with SMTP id ts6so4446917pac.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 10:38:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CzDyXz++NIZHSA1hWhvzWlbevf5Lhj3bs/8PNoEl9Gk=;
        b=mqtwoZmhEqIJ4x++G9L3Bl5mSIkYnjIPnUZiLLMA5ShlN4ZpZ81pDCSbm7PbOesvSa
         iFGDWjZ0EXE9f1LRg763UuI0dUQXhpQIbozSccOgNFUm55AkZpAkheGlMU5Wx+koXPEq
         pEdgZ0sk+gjxrynEc4SI2CDV2f7LVDgCBTRQKNLgMySyawTWh/xgCEmoWU6314Zz2Vtr
         m6IswdNUfePx+A9XNw17KxTbnUIukGhKZs/qOnWM5t7dWrfNbbE8Q+vJR6Q2L++zOlsR
         WHD+qmW5wtB6PQ7IJySEWjAWQISXs6VNKw0S27hc7s5Dhcp1LmpPE8XeQ4/7hK7Ezaj8
         5uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzDyXz++NIZHSA1hWhvzWlbevf5Lhj3bs/8PNoEl9Gk=;
        b=b6J2yRu9oBijXthJATE0TAtv3Y6tNTzdAD4kYeb/zd/tVlT4dMw5Ozk9N5BTcZQSeH
         R03clCoGhbEto0ZCqsECGCBvKBcHlgihv6BQ/8XOMmADqbA+Bob6hx5V9NONQVh4BzqX
         ydR008brzkK59vMeRxnNVveeoEgna4iPRs1U9lKmeRIfO4Lf4iVEsjBrKb0V1x2zteQG
         EINwJ1jFBnCP9Zs926HjapxRdidFOJ8r85ADQrT5j5szAK+kInZDYlAa38fCfI+15wMj
         zHplAknU8/fcBNvI0t68L7Ji+KfQzejFmOk1OnDcHVqdMMVfGBy9ur5zwyXn2MmEQaj/
         IHcA==
X-Gm-Message-State: ALyK8tKt07gefVz3V7wNeI8Uv7ChmPw+utyBo+Sx2d+NiLpkZ+kl3+yg5k0qAETLaSar2Q==
X-Received: by 10.66.126.179 with SMTP id mz19mr35994624pab.27.1466617107828;
        Wed, 22 Jun 2016 10:38:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c00b:e350:cdbe:8067])
        by smtp.gmail.com with ESMTPSA id ee10sm1292910pac.31.2016.06.22.10.38.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2016 10:38:27 -0700 (PDT)
Date:	Wed, 22 Jun 2016 10:38:25 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2] doc: git-htmldocs.googlecode.com is no more
Message-ID: <20160622173825.GD20206@google.com>
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
 <20160622024151.GA20206@google.com>
 <xmqq60t1noon.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60t1noon.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

http://git-htmldocs.googlecode.com/git/git.html says

 There was no service found for the uri requested.

Link to the rendered documentation on Jekyll instead.

Reported-by: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Even though we do have index.html -> git.html, gh-pages does not
> seem to let you follow it, so you need to start from git.html, and I
> suspect that it is why the below says "I wasn't able to find it" for
> (5).

Yup, that explains it.

> So perhaps list both?  I do not know how beefy repo.or.cz is, or how
> well connected it is to the rest of the world, but if I have to pick
> only one, I'd feel safer if we didn't have to exploit the "blob_plain/:"
> backdoor.

There's only one option that uses https, so let's just use that one.

Thanks for the pointers.

Jonathan

 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5490d3c..0fb14f1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -31,8 +31,8 @@ page to learn what commands Git offers.  You can learn more about
 individual Git commands with "git help command".  linkgit:gitcli[7]
 manual page gives you an overview of the command-line command syntax.
 
-Formatted and hyperlinked version of the latest Git documentation
-can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
+A formatted and hyperlinked copy of the latest Git documentation
+can be viewed at `https://git.github.io/htmldocs/git.html`.
 
 ifdef::stalenotes[]
 [NOTE]
-- 
