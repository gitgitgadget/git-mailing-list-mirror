Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B3A1F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937301AbeE3INq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:13:46 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46326 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935952AbeE3IMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:12:44 -0400
Received: by mail-wr0-f170.google.com with SMTP id v13-v6so16833428wrp.13
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASMfMzA788GY4DxyWjdxXp1asMzPgvlF/Cl2dZLRnHU=;
        b=oGvtBO1rJqLeS2CG+aGz6D9q8qgJi/7+bafJ3gMFcwlChwU/gUN4unks2NCfW1plIp
         X0iHpSvns8N70UYEJfIGBFb3EcY8ch+dlUoMW6PZsX3N4bNkOB+fZOuLQg8BkbV5RHkk
         hJFAabRjiZj3yA7gnQ77JvwYbdDni3rVVlWpW6QJr8v1gIYd9Fk1byDcqYzEIBqMBNo4
         R7RHTIko0Xld0Sr5cvDD0quvj+87uzKaA6VCdaQoQ3jVmnKLL6SKDkoTfgh997tj5Ukv
         gWD5HmVtQXzjjENEeMk0Eve1+V2fWu6KBl9pODrTCp/6m//8cQaJSj1TGom/iLMYxH/v
         bRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASMfMzA788GY4DxyWjdxXp1asMzPgvlF/Cl2dZLRnHU=;
        b=uTjTB1li2THfV+IarwbzzcN8TCCFBNcRcyVFpGAr7s92M5VO8XJRbcAqzLyd2S5624
         bOY44Ohm9Phn7LxK+tUhWC5XwZzc2FfurJn9krZR+iSVf5b/kVOE1YIxh4q0RP9KYfr1
         +La+bzFTRcrttUc3VB243xTOATemY3CY+boKMjakm5oCa6PytHZHkXEv43/vjZXB+Fp0
         RWzcV9bZAGJZdCl8omZ+asyxtUZOLv+MtWNL72nkqkZd4UB4EIIDM2aDxGZxc/wZkNOb
         B2nV9JeQ56eO9rFrUZHJi2Vc19MGqqOTYYSnF/pghp/qIZhELA5IIFLmHV6/pobiPO1p
         G4jw==
X-Gm-Message-State: ALKqPwdxv/PFOmXo35jEgAK0yBQRbWqfSfqkiSArLCqroDY9X7bLTWno
        5YQM7Vjsgh3lT1WtYqTdPMTVMSdF
X-Google-Smtp-Source: ADUXVKIc2ZWXM0p02puOcVDI8PbyCBYKMi3eFg7NR7yMFWofMjlES/7vSTLmqM1BDa50FWovVKXY+A==
X-Received: by 2002:adf:ae59:: with SMTP id u25-v6mr1217904wrd.157.1527667963151;
        Wed, 30 May 2018 01:12:43 -0700 (PDT)
Received: from [172.22.2.13] (p50993d65.dip0.t-ipconnect.de. [80.153.61.101])
        by smtp.gmail.com with ESMTPSA id n11-v6sm31352029wrh.10.2018.05.30.01.12.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 01:12:42 -0700 (PDT)
From:   "mana vortex" <manavortex@gmail.com>
To:     git@vger.kernel.org
Subject: [bug-ish] [convenience] fatal: only [12] (reference)s? expected, [12]
 given
Date:   Wed, 30 May 2018 10:12:41 +0200
X-Mailer: MailMate (1.11.2r5479)
Message-ID: <1B7D3974-AA1C-42B5-A7F5-C5A36B28C34F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; markup=markdown
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git folks,
I’m writing about something that annoys me since forever: The 
reference handling is not consistent between commands. For example, I do

git checkout origin master

but I do

git reset —hard origin/master

I always get it wrong the first time.

Is there a convenience option that circumvents the error?

If one argument is given, but two are expected, split the argument at 
the first / and retry - throw error if that isn’t valid
If two arguments are given, but one is expected, concat the arguments 
with a /.

Is that possible already, and if not, would you care to implement it?

Thank you for your time.
