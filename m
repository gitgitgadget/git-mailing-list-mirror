Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6AF1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934439AbeBLPE4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 10:04:56 -0500
Received: from pannous.info ([81.169.187.238]:41692 "EHLO mail.pannous.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933449AbeBLPEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 10:04:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.pannous.info (Postfix) with ESMTP id C100570DA45
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:04:53 +0100 (CET)
Received: from mail.pannous.info ([127.0.0.1])
        by localhost (h1642655.stratoserver.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q5udoiuoRMLt for <git@vger.kernel.org>;
        Mon, 12 Feb 2018 16:04:50 +0100 (CET)
Received: from [192.168.1.27] (46-59-172-54.lsn6.wtnet.de [46.59.172.54])
        (Authenticated sender: root@pannous.info)
        by mail.pannous.info (Postfix) with ESMTPSA id ECFC670DA41
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:04:49 +0100 (CET)
Subject: please change stash
To:     git@vger.kernel.org
References: <76c2d8b6-b001-8ae5-4e66-fdeed4a1190a@pannous.com>
From:   Karsten Fluegge <info@pannous.com>
Organization: Pannous
Message-ID: <5f712f6e-ecb4-db85-02de-b48be1bf1f44@pannous.com>
Date:   Mon, 12 Feb 2018 16:04:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <76c2d8b6-b001-8ae5-4e66-fdeed4a1190a@pannous.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear great team,

Normal git tooling creates different files file.ORIG file.LOCAL
file.REMOTE in case of conflicts.

However `git stash pop` manipulates your files directly resulting in
lines like:

<<<<<<< Updated upstream

>>>>>>> Stashed changes

This can seriously corrupt files and workflows.

If it is «the user's fault» or negligence then at least we're not the
only one:

https://github.com/search?q=Stashed+changes&type=Code

300000 'idiots' might hint at a UX problem. (factor 10 in darknet)

-- 
Kind regards,
Karsten Flügge, CEO
GmbH

Hagenkampsweg 10
25474 Hasloh
Germany

Mobile +49-176-64638989   
Support +1-855-447-2666
E-Mail info@pannous.com
Homepage pannous.com

Handelsregister: Amtsgericht Pinneberg HRB 7795 PI
Sitz der Gesellschaft: Hasloh
Steuernummer: 18/291/16961
USt-Id Nr: DE264064657
CEO: Karsten Flügge


-- 
Kind regards,
Karsten Flügge, CEO
GmbH

Hagenkampsweg 10
25474 Hasloh
Germany

Mobile +49-176-64638989   
Support +1-855-447-2666
E-Mail info@pannous.com
Homepage pannous.com

Handelsregister: Amtsgericht Pinneberg HRB 7795 PI
Sitz der Gesellschaft: Hasloh
Steuernummer: 18/291/16961
USt-Id Nr: DE264064657
CEO: Karsten Flügge

