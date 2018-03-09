Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD6F1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 00:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeCIAXp (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 19:23:45 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:46230 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCIAXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 19:23:42 -0500
Received: by mail-qk0-f180.google.com with SMTP id 130so1816456qkd.13
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 16:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XolhJ087gpGQwyJeLOiFl2jTOcunfBne31qayNQKbX4=;
        b=hF9VreBmIQmrF8R+UPbn7dxV9yDlzYAXf9wa/uGqpI8bkoz/afkQmeWd4dnBl+vN2A
         XIx9r7LhZ36Da5sfQwuDpBzfJG+H7KU0R40mk/vU5SbhAqn9wz2+m2IwfmzyrOswaX+/
         47Vu28hFdIKPV72sk2RZngwsekcAj9WVQJvWRfCCPK+BLyl5fcHln12Tn1gzX+n2KvuN
         4dkfajuUQsnzJBCKTMW3uKNpPXslKfG21FTuBnpctI0hd1JVjJkzILmHJiwNceE6kykL
         XozwmenCHuAtd5gduGRAC90ridhT4KGNoBikIEV5yKLR8aigzjEdozKEAGa3p7oWNadB
         9k3g==
X-Gm-Message-State: AElRT7HRbV7RM0/swKSBHUoEmgGt1H8WDwsZA9iw1FtmSF9fLljBKY4Y
        ScTLSbbV/HZQzFr4qJ6FOUxwq4p2OEM=
X-Google-Smtp-Source: AG47ELt7TZbATfQXcjxrTQy6f/jmRD9NqWcRXXXbYHaCk5RlpbgDWLTWUs86UurUu40DkFNeWIVEkg==
X-Received: by 10.55.41.151 with SMTP id p23mr39827655qkp.52.1520555021641;
        Thu, 08 Mar 2018 16:23:41 -0800 (PST)
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com. [209.85.216.174])
        by smtp.gmail.com with ESMTPSA id v73sm3719749qkb.72.2018.03.08.16.23.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 16:23:41 -0800 (PST)
Received: by mail-qt0-f174.google.com with SMTP id r16so8923947qtm.4
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 16:23:41 -0800 (PST)
X-Received: by 10.200.23.235 with SMTP id r40mr42202415qtk.314.1520555021293;
 Thu, 08 Mar 2018 16:23:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.35.78 with HTTP; Thu, 8 Mar 2018 16:23:00 -0800 (PST)
From:   Jeremy Bicha <jbicha@ubuntu.com>
Date:   Thu, 8 Mar 2018 19:23:00 -0500
X-Gmail-Original-Message-ID: <CAAajCMbFEF+1i8+MOpOfdMgChi0FfdA1CoCjKLjjKMT2m-58KQ@mail.gmail.com>
Message-ID: <CAAajCMbFEF+1i8+MOpOfdMgChi0FfdA1CoCjKLjjKMT2m-58KQ@mail.gmail.com>
Subject: feature request: git-config: Add conditional include for gitbranch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use Case
======
Jeremy is a developer for Debian and Ubuntu. The same repository is
used for both Debian and Ubuntu packaging but with different branches.
For commits to the debian/master branch, Jeremy wants to use his
@debian.org email address. For commits to the ubuntu/master branch,
Jeremy wants to use his @ubuntu.com email.

Proposal
=======
The includeIf feature of git-config could be extended to offer a
gitbranch conditional include in addition to the gitdir conditional
include it already offers.

Thanks,
Jeremy Bicha
