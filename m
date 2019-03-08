Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC1D20248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCHKtS (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:49:18 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:51639 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHKtR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:49:17 -0500
Received: by mail-it1-f174.google.com with SMTP id e24so20189454itl.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=8ApPUIfwiiFbWgFNs4u3UceTXmUqLdrCBfNeaBN2NYA=;
        b=HJVUkwbKd22yABH5bHEeFESIZokq95P6CwBg0nKZfH9ewuvvlZ3AY6r7xsMzO+IOou
         XtQ6scPMvJ2/6P09qz9cfnSMA0pPtAOhx8k+LPrdw8Ud+WAKlKC7/v1Og98FVmrIlvMd
         8UG5klqvwsFoS5VVb6sjltu+gjDl+7G7kF7bzoeEQvKA24uKbSmBbnR47kDmTuuus0w1
         FOP0rerbamXKn5de/cAi3ERvOK2zQetVgx4+dPXojyEInxizLW1pim8NCh7mqNwuGI4E
         jGJcuBVZQVBGOzvddiujireTa6OaggNoiLZp8LJ5X8tblpKNlrS/UvGhTmEvvE3AE8cN
         rDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=8ApPUIfwiiFbWgFNs4u3UceTXmUqLdrCBfNeaBN2NYA=;
        b=KeFnyh6mvZsy4ZnWnOlGFU0Y6SU6BtUZVwVbi/6s4M+fycB3JZK2nAR3yIvTQLGx6F
         nEth6FszFNRHHXLBfVwfyan7R/t5g9KYX+7eEN9F0I2J2pADeBwFrPp7TMPqkHXBgS9l
         zo8u3k+ocLqKIdSF3edxpd7FCQggfC0U01YdkSBF+43v03IqAsiS24ZQci3ZCysZGxUk
         4TZ0l4j7nVvKFAX0vf9/z9Y74PtNkHDFPsuwb6mukQbR6krCSg4BRq9xeYxccrsxT2sP
         u7SoRczQyROyny0r5+hAes5EHNcBkIeNQa9oFWS/MCBOH3Rzvox40132g5JDmZgsgG02
         s9ew==
X-Gm-Message-State: APjAAAX0O+CW3dV0aN+lSoERs3W2nsQKkl89eYeVrpB8F4vHalTcmLnd
        5DyS4ylKLiu9+Q9IEkGahUq9oU5Ib99iWkPN+JAwUOHa
X-Google-Smtp-Source: APXvYqw2WQFN3/SCfdlQRlUqVZFcLy63aegh+ZFDS0bU3XeRzFR1uZsMVFD20DUCDfjdFjlaRv7roDC5jSU8Zz3Gem4=
X-Received: by 2002:a24:3a12:: with SMTP id m18mr7347156itm.5.1552042156417;
 Fri, 08 Mar 2019 02:49:16 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 8 Mar 2019 05:48:55 -0500
Message-ID: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
Subject: One failed self test on Fedora 29
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fedora 29, x86_64. One failed self test:

*** t0021-conversion.sh ***
ok 1 - setup
ok 2 - check
ok 3 - expanded_in_repo
ok 4 - filter shell-escaped filenames
ok 5 - required filter should filter data
ok 6 - required filter smudge failure
ok 7 - required filter clean failure
ok 8 - filtering large input to small output should use little memory
ok 9 - filter that does not read is fine
ok 10 # skip filter large file (missing EXPENSIVE)
ok 11 - filter: clean empty file
ok 12 - filter: smudge empty file
not ok 13 - disable filter with empty override
#
#               test_config_global filter.disable.smudge false &&
#               test_config_global filter.disable.clean false &&
#               test_config filter.disable.smudge false &&
#               test_config filter.disable.clean false &&
#
#               echo "*.disable filter=disable" >.gitattributes &&
#
#               echo test >test.disable &&
#               git -c filter.disable.clean= add test.disable 2>err &&
#               test_must_be_empty err &&
#               rm -f test.disable &&
#               git -c filter.disable.smudge= checkout -- test.disable 2>err &&
#               test_must_be_empty err
#
ok 14 - diff does not reuse worktree files that need cleaning
ok 15 - required process filter should filter data
ok 16 - required process filter takes precedence
ok 17 - required process filter should be used only for "clean" operation only
ok 18 - required process filter should process multiple packets
ok 19 - required process filter with clean error should fail
ok 20 - process filter should restart after unexpected write failure
ok 21 - process filter should not be restarted if it signals an error
ok 22 - process filter abort stops processing of all further files
ok 23 - invalid process filter must fail (and not hang!)
ok 24 - delayed checkout in process filter
ok 25 - missing file in delayed checkout
ok 26 - invalid file in delayed checkout
# failed 1 among 26 test(s)
1..26
gmake[2]: *** [Makefile:56: t0021-conversion.sh] Error 1

Does anyone need a config.log or other test data?
