Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CC5208D0
	for <e@80x24.org>; Thu, 17 Aug 2017 02:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdHQCDt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 22:03:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34651 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdHQCDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 22:03:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id y192so7304157pgd.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=/EZiGvQPoeXgcE3UxrRuE81336FyFLNMw7iAmti55Mo=;
        b=HAVj3IOrc2fjn8Ijq4s1z5yTVLVCFnzqp5IFMt5MkK+ht/lmaY4eiiMIuVbJjm5vvW
         5hBshU6izMqfukNPRJz7kx9VBNqvi2vTq8ft7yaBUsJX5FFPV1HyTU0zaOPtb33Mk+6H
         7dna+PXaHTILltKOVZLQcJqnAOsBj8ftyfZfOeLGIGbTuz9zyCax8SleqpHCS8mtTUbx
         b9NK24+8p98XlHcGWfGZGqSWrpH7/d+yInBbJSKKWbgbmSTPDLsGdPJXuBnrDKmLJkMs
         uhV/H25p3FGNz92sc7h46WjzKz6xPOQzX14oArzmoZSs0DZvnoTZF0VtUe6B/uuaQIz6
         NoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=/EZiGvQPoeXgcE3UxrRuE81336FyFLNMw7iAmti55Mo=;
        b=qb60JGJ/HX9csBrBf3yaoPzOBVCnD9DB+MYsTYj1w8WJg2hwpxQY8RkFwVfUooF3rE
         0mP35SsFqtE5iFBm6hh6CAK9988z/MpwKZQeSH/x4/czbyGQrBW67W48HLUxIs9GX+yZ
         miKb8OIwL4eqAHCjHdts6CH5ZNw4R5w66Sx5QNM5WczvsnBGhEWSXhME/BsAL2sv6uuE
         YrZxQfClUdWg3m5mX3J9Zc7ryQ06oPWW6kUeKv7Ctoc1TFkCssEEfjuZhzPy0+4KDtL2
         4OHgafYEwZEamtNKY2x/1EZx7tecUmJT8ctboBwI5/0WIq1E+r1GVCoFSZ57t9vMMoOS
         Hgfg==
X-Gm-Message-State: AHYfb5iz01VNzvFJe2BeusWy8gLwdhfWJc/3FbEpp2NgRWdasQCj+d/j
        eF/sv44NckE8KKek/8E=
X-Received: by 10.84.209.142 with SMTP id y14mr4081157plh.286.1502935427795;
        Wed, 16 Aug 2017 19:03:47 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id l22sm3892055pfj.138.2017.08.16.19.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 19:03:47 -0700 (PDT)
Message-ID: <1502935475.1710.5.camel@gmail.com>
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use
 of --set-upstream option
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
In-Reply-To: <xmqq378rl479.fsf@gitster.mtv.corp.google.com>
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
         <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
         <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
         <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com>
         <xmqqfucsr73w.fsf@gitster.mtv.corp.google.com>
         <09ce545a-31ff-aa9f-d03c-3cb68ed26230@gmail.com>
         <xmqq378rl479.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 17 Aug 2017 07:34:35 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-08-16 at 12:09 -0700, Junio C Hamano wrote:
> You said that "checkout" does not do a necessary check that is done
> in "branch", so presumably "branch" already has a code to do so that
> is not called by the current "checkout", right?  Then you would add
> a new caller in "checkout" to trigger the same check that is already
> done in "branch", but the code "branch" uses _might_ be too specific
> to the kind of data the current implementation of "branch" uses and
> it _may_ not be easy to call it directly from "checkout" (I didn't
> check if that is the case).  If so, then the check implemented in
> the current "branch" may need to be refactored before it can easily
> be called from the new caller you would be adding to "checkout".
> 
> 
Thanks. Now I get it. What about doing that check in
branch.c::create_branch or branch.c::validate_new_branchname? I guess
creating a branch named HEAD isn't that good an idea in any case. Doing
the check there might prevent a similar situation in future, I guess.
Further "branch" and "checkout" do call branch.c::create_branch which
in turn calls branch.c::validate_new_branchname.

-- 
Kaartic
