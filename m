Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545AB209FD
	for <e@80x24.org>; Fri, 26 May 2017 00:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970470AbdEZAYf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 20:24:35 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:37280 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763132AbdEZAY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 20:24:29 -0400
Received: by mail-it0-f50.google.com with SMTP id g126so968347ith.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=STXYlS6ctTjQVWjuuqIPGV9VY12d2In+0Tf49sr08XM=;
        b=oQLWri9sqrBICLmdC8bwxSUifBccUqd0DTS7Fkyu0eCNbF4wGkNFVLvkIoLlGcGsEv
         05e3ehSnQCbaPt9/hDKwqtZjsldQ4Y9p15EjC8M532ykhB20x7t1fWXPVeNujFoi6ZDY
         0zHwP1WtZxLFcY4MIQ8ZJ9HEB19MXrSQ/H56NVZpw+VD1ozn1sFNgGY/Fv22XYsrjJZS
         VE0JTwvqHK8qlmVEhL1FphpOAJmQCxBA10QeJjy9Q0WwrZmLY0VmfO4twjxlU+06Fh/T
         HJ8LnU7mdtd9Ey5HKMx240+1MwgUGUIZy2gpiiKzQXDBo+vbXB2lkJiO74UuO2uXMjE9
         nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=STXYlS6ctTjQVWjuuqIPGV9VY12d2In+0Tf49sr08XM=;
        b=PE2ozmASeafmfk7rNpywEamoK0oYwtarS0hJls1rG/32320LfQldVaC41mBF2RG9Pv
         4wIBYfPfXju9e4A1FtP3UXRKy+9RZmj2zGa8ArmupxV4RqZOfmk76lbxGHKj1BtdlVK9
         +ZDEWZZRP+L7QUOMhEH88Oo8O/UjNG/OBRVS2cdDquQzRifN9euHvq96fb7ZeuJj0YE2
         gq13caeaNx1qWOq37Y+FHBpvyMApKU2K8ZZEHm7ZIp7NqqUsmBCckVsAUkslKvoarZft
         BHzofBrw/inuB6nlsokvPBE/iIdaj4fvXVuFkZh535b5o4srVJoLgquiQnNNxBKLU3gD
         8k6g==
X-Gm-Message-State: AODbwcAnScHyBwxfKCocrkz/P715+XAItwX8ZmUNNDr5Jx5Zh+wryNxh
        kapdSkORRfl6ovvtg5u14h6fDHnxF8mJ11M=
X-Received: by 10.36.194.129 with SMTP id i123mr330282itg.9.1495758268557;
 Thu, 25 May 2017 17:24:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.32.195 with HTTP; Thu, 25 May 2017 17:24:28 -0700 (PDT)
From:   Zhomart Mukhamejanov <mzhomart@gmail.com>
Date:   Thu, 25 May 2017 17:24:28 -0700
Message-ID: <CA+9OxukkO8khvPtYdSMLL0pa5vmOCZaTJbx+CWYXze-TC2nrpQ@mail.gmail.com>
Subject: Feature request: "git status" highlights files that are larger than 500kb.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So it will be easy to track that we don't accidentally commit huge files.

What do you think?
