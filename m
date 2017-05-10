Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA63F2018D
	for <e@80x24.org>; Wed, 10 May 2017 00:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdEJAGx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 20:06:53 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33738 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdEJAGw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 20:06:52 -0400
Received: by mail-yb0-f195.google.com with SMTP id d72so590844ybh.0;
        Tue, 09 May 2017 17:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=KSI00XENXVt+hFmnwbTnkYFMJ2a7CnKFzIaeHWnJagI=;
        b=CpkkO2j6N13DLRLbkl0Ra21G1hZWbEMKfJoROtAeEY78xZ6ykTtzr2g4lx4ziAQwoR
         lS1gZjH5nV1bIX+r20LhNMzvD1yMuhQSWR2FkoxVe48ZFGiDXvn6ByTdH1bRh+qjfPMD
         CzsIvpWJqVViEz7Lcw6Mf8/uoHfYHNfeESqLswdbZDUQVCMdwk9thrQvIsOhJ2I4YHI1
         g8GFrRzrPWRtCSjcznSmjR0zefwtPGftsYRb4SWMkHZUoTAZ2jy8ArQJCWjQZqmRILrW
         M1YmDO/2M546Kc/JmQTsKNIMcTGuIEEpCdMO0x9jIcoHpT322/xDliUnFUFoJiqbY/O6
         SzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=KSI00XENXVt+hFmnwbTnkYFMJ2a7CnKFzIaeHWnJagI=;
        b=eIY5Ci94aAWmFqZzvHOdg/JV9FbFirnu5sFqLdUlSu6SfLyZwozyCy3OM68A6BxfvZ
         5/CB3CCed0n1SNwFBIi1pACdHXU49d12TXinfal9kz9iJAcaiLhoIlKqIzki+Pfpbzik
         jCu+TrxXx4gjz3vgeHcxYZK4/VHLMkxTgAp8YHRN9HjDU3sFctbymjLWC8hwxUOcnkUY
         HoaD3CwQMh1ZE/JBcz+Ext/kVndoYOf0oAsSSK5jOkWZfq1bS9m6lu/ZLg6tsf+R9NsT
         M6eqU7ks2lPp/b6g71BlTUkFE9o39K7g+SWZvNnrPCPjw+B+LjLYqIj1neTDJ1Srr/TF
         Nfqw==
X-Gm-Message-State: AODbwcAaO8rfmXV7jPL1I/m5JPbQ5ovofea2/X/+g1eeGEng4bmqWJBH
        S/r/JMGTgt+DIw==
X-Received: by 10.37.164.102 with SMTP id f93mr2596054ybi.152.1494374811724;
        Tue, 09 May 2017 17:06:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id g38sm941956ywk.7.2017.05.09.17.06.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 17:06:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.12.3 and others
Date:   Wed, 10 May 2017 09:06:50 +0900
Message-ID: <xmqq8tm5ziat.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintenance releases Git v2.4.12, v2.5.6, v2.6.7, v2.7.5, v2.8.5,
v2.9.4, v2.10.3, v2.11.2, and v2.12.3 have been tagged and are now
available at the usual places.

These are primarily to fix a recently disclosed problem with "git
shell", which may allow a user who comes over SSH to run an
interactive pager by causing it to spawn "git upload-pack --help"
(CVE-2017-8386).  Some (like v2.12.3) have other fixes that have
been accumulating included as well.

"git-shell" is a restricted login shell that can be used on a server
to prevent SSH clients from running any programs except those needed
for git fetches and pushes. If you are not running a server, or if
your server has not been explicitly configured to use git-shell as a
login shell, you are not affected.  Also note that sites running "git
shell" behind gitolite are NOT vulnerable.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of these tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git
