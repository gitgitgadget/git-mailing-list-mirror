Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734661F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDFSq0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:46:26 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34759 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDFSqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:46:25 -0400
Received: by mail-wr0-f182.google.com with SMTP id d17so2627859wre.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=D2Qp10ixaj8i73od5RuHHH448KfVoW1Y6vJ5zI3e7Rc=;
        b=EZCdFz1MpkWMo0RBTCttmJMjBFDsTdKfqfdfAsZb3GdFiKWgkjSMjsnGtO/Urw7rqN
         Hvb4DzdHcxutnUHRwXb5R65m+AViNR7K13XJshFy6HKaqgJyz8nEsdG8mfPtHfE3gFez
         M0I9Jlf5Z4EAOcGU1M2Ea1E/CDywWpYdYmaeI6IK4Mc1WmtW8keBnMPYBIPhwpwJmnyK
         lKsc0ctGXpX4BtG05vnKapvJC9lcPYf6gSgemf0rmNuc0tm48+K59sQ48ADZyDAFwiNr
         MebVrkVaQTh0d62C2LWPeNNkyXYhjfBtGEjMY7LZ0dgtuUAAteQCGTGAPWGhK35lboOa
         icAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=D2Qp10ixaj8i73od5RuHHH448KfVoW1Y6vJ5zI3e7Rc=;
        b=NQQkKFAkOZZ/0/bKpFOQejTfrSXSrb2B9HblZkZZvaBtBKlNUFjuwA+zevi2dPikhU
         3V3/uhlUa9osvxNZHl6oJrhxqi/PS3p9UIr5LYYdmAvdfGa9uTum8Do1Z3XZ3TqVYuh4
         AE4NBhg/fU8dwxVgZoCRx4BJSzRsTWNByfwJVRbEGnWltyBY5Up2Fd4kd5spAXlA4PdQ
         n40mzbVZlSun/Pn0WkgW/1d6KrBsfwNMkGfxFcBo1haid/IFi6agCb2cGaOQ9vNnVfVu
         6AEL4aUIWJcV+lgs+WhmxOknfniTxxZ8iXZpky99PTRM0KhXFwv7xEDiYKQQvbuaBdgZ
         Qs/Q==
X-Gm-Message-State: AElRT7EG2hi9yBv8tqne3MBgovMUZMnHPngoQhrbRnWbCKKhIlkuK/FF
        gOttgKS7LrNV1iie9ATOY/w=
X-Google-Smtp-Source: AIpwx4+gR37qHI3kcAwMIjhrykb5wr7cX3OQvhWb3W/Vx6dWcgiVOKHyN7ZVwnrh4De+8winXmBkqg==
X-Received: by 10.223.196.204 with SMTP id o12mr19801203wrf.121.1523040384025;
        Fri, 06 Apr 2018 11:46:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 185sm14596618wmj.46.2018.04.06.11.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 11:46:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Satya Prakash GS <g.satyaprakash@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: reg. fatal: The remote end hung up unexpectedly on NFS
References: <CAJZK4X4-AZ6uEoVbAtQ9ErdJ2guKj9puXcpdX_3igBNPdQNp5A@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAJZK4X4-AZ6uEoVbAtQ9ErdJ2guKj9puXcpdX_3igBNPdQNp5A@mail.gmail.com>
Date:   Fri, 06 Apr 2018 20:46:21 +0200
Message-ID: <87woxkyxz6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 06 2018, Satya Prakash wrote:

> Hi,
>
> We have a distributed filesystem with NFS access. On the NFS mount, I
> was doing a git-clone and if NFS server crashed and came back up while
> the clone is going on, clone fails with the below message:
>
> git clone https://satgs@github.com/fs/private-qa.git
>
> remote: Counting objects: 139419, done.
> remote: Compressing objects: 100% (504/504), done.
> Receiving objects:   7% (9760/139419), 5.32 MiB | 5.27 MiB/s
> error: RPC failed; result=18, HTTP code = 200 MiB | 96.00 KiB/s
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
>[...]
> Please advise on how to debug this further.

I don't know what this could be, but have you tried turning on the
various GIT_TRACE env variables document in "man git"? Some of those
might hold a clue to what's going on here.

Have you tried to do other git-independent tests to see if in general
the NFS failover isn't resulting in data being written as applications
expect? E.g. doing a recursive wget of some data with known SHA1-sums,
or doing a stess test of some sort on a filesystem that uses checksums
(such as btrfs), which could be loop-mounted to a file stored on NFS.
