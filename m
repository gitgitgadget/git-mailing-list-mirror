Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F49202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 19:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdJRTmu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 15:42:50 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:53562 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdJRTmt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 15:42:49 -0400
Received: by mail-qk0-f169.google.com with SMTP id y23so7690029qkb.10
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/m9zPpAigWdPTDSs/8+z5k1IcI/EEOPiUuDUvY2b8ew=;
        b=Z+VAZCGwG5829WdIkv8y7QT0Gn1wy6j25Fxkyt3ybpwys6Sn5D5pSaNh+A5gyQ1ViH
         LblALcJHC1ltXBzWm2n8eqQy2AwW/f9VdsOKNRTExCCfOCkFj//vTnE++ctSI7X3amYl
         aa8ibuouKLUIpKbwLG+EAaeq3ZkNoQMajBrJ6QLv3yCO8oHg+etIfnouUQhjeJJr5huY
         nsYGDWdSJaDvXlLeq3HZezNs09ivMO8a2YJ3qRZbm1HT3SeQZRm7GZWCJuadUDen9qxK
         OeIZQkTjcXVTjWkUEKm/kybEqaRl2PSpwln7Q4HfARdtWai5Ry/scqlQpP6ztIr5B8tJ
         WT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/m9zPpAigWdPTDSs/8+z5k1IcI/EEOPiUuDUvY2b8ew=;
        b=Xfq81MPMDKf9subK0WSayTvUBnXgAhnTrUqy+FTe8AfZuvt6uWfsUBbz96YQ8cfG9r
         CipsswEEqgeh7aCGTghmEc5FUFAqbMW1yqiDqyhOd1PhPHf94EIKOquTsamtq8hCgoYJ
         4oNEfehQsMTGDe1SpqrACjS6/LB7l//wrxe2NJO9+uWWPCtuwFopfeebAmxQzlUr2nlu
         pbGbG9yLSWmiPGIF7Wuc4JXWq4h16jEtIhCFIEkd9VW28YjljB+F7eVCkGDIsDfokJSO
         IXkQDsTG1M9toE00a+cXtgw6ZqbOxt06UlDoWj6qwWLfNWxyPd2sEuN9EnwOSvQs20LK
         xNAw==
X-Gm-Message-State: AMCzsaUWBUuYO/X2ccfRjMc2Rb8XUGHsw8abpahgItr3eQ3vo+YxVXLG
        +GnBnEMOR6BCUfo4AOSyu28pjnZbG0z+0S6JxW8=
X-Google-Smtp-Source: ABhQp+TONfkgVwuU3mDXumqxzdUl3Km7nNQodpJE/z/02cKEQgfZXd/oEzO0n3T+OgmyZbmOl3AUiddUN8p3eVhVxmM=
X-Received: by 10.55.19.98 with SMTP id d95mr4198795qkh.123.1508355768738;
 Wed, 18 Oct 2017 12:42:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.20.18 with HTTP; Wed, 18 Oct 2017 12:42:48 -0700 (PDT)
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Thu, 19 Oct 2017 04:42:48 +0900
Message-ID: <CAC2JkrLR=RUN01AeYGd1YpOPMv=kArm9LWGtMvJ7DS5sz7c3nw@mail.gmail.com>
Subject: How can I debug git source code interactively with debugger like gdb?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wanna learn how daily git command works when I run specific git command.

I wanna know which function is actually called then, how variables
changes its value, and how some object is stored into database.

How can I debug git source code interactively with debugger like gdb?
