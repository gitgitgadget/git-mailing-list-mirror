Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF1A1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 12:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeILRvq (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 13:51:46 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:45746 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeILRvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 13:51:46 -0400
Received: by mail-oi0-f51.google.com with SMTP id t68-v6so3339248oie.12
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DCSaqs27oqKUojWvkYRW9eXewWvs9hcGYX+qmk1t4XI=;
        b=Q1I9CBhAkkTaYFmQK1rgKkzFurueFG5Y6st9/jISWaVWeZZkPqvbIGFmQu692TXmNo
         p8VTiR9b2gN1un/6GS4ngJTS65HPfd0vAAOouGX/tDhHYBFs/kUhTbkDoSDusc/FVXTd
         vNp7Vhk4l/UXm1vsN6PVRue/K0Sce5L+S5S/7KXUDIegVUHbFwtOcpOCP9RTRabJesto
         uJ+MyNSmAQmhlqqL3a6TJQOtv2nI2LsUMXN/lDiesjg4qNL55vNK5pOQ4c+as8dpeFcF
         Xqwsm2qwYbx7b+TdegwFU7LULZmWmzTv9mrVDS/+pJtkJ9NiBbKi0b+v+Nj74S+gGYYZ
         P3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DCSaqs27oqKUojWvkYRW9eXewWvs9hcGYX+qmk1t4XI=;
        b=V5n1NvNQSOdxyX85BrdEEmnCbYy0QyKRLkhJQ75Fs6KrcGOMLcIzT1XgQIW7/QzOoU
         MenK2Akdsb82+NIHzzdhUhQ2nCRei4SBCXnK3Z54kESFmaLwxmxQU9wpgFMRrX/FPM5W
         KeIxrmWHV2rynjUX2I4iVWezuV711z0O5Y/noWSkVC9YsTM3/u6r3aGjYVjf1IRXwmJL
         u4gjQYejg3DkTyog+aFNF+lENk9nRkMHGZ22S7ETwJ4hHA9N2IfrRaW5prWfBZuEU5AJ
         9O9HMloImWEvp5rnbKv6LxSK2ixvwd3673aCRHAwEym6leAcoQoXev5UDJgFLcjeH9iq
         KdKQ==
X-Gm-Message-State: APzg51BwOg75pfTILY94X/aHDl3+4roFwFMxBhjKu1mnp4Gbozc8DhVd
        aH6wBbqFLmjEGVhQuycg3DL8T0Sl8B2ifFPnBC7luw==
X-Google-Smtp-Source: ANB0VdbzS7AxvJXzygiZGSRy86tvsQxzXl6v71Z9VrDI1hICLt/MRACoatdmWS27fbTZvM2gpFouYNg3Gj+5GEPmkGQ=
X-Received: by 2002:aca:5e83:: with SMTP id s125-v6mr1955819oib.20.1536756444256;
 Wed, 12 Sep 2018 05:47:24 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Wed, 12 Sep 2018 13:47:13 +0100
Message-ID: <CACoUkn5ZVo=3-XMPRihx-R7Rn281p9K_Q-ybuDCPJsqoS8CsJw@mail.gmail.com>
Subject: Re: git-credential-libsecret not prompting to unlock keyring
To:     paul@myitcv.io
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies, forgot the crucial details post that log:

$ git --version
git version 2.19.0
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.1 LTS
Release:        18.04
Codename:       bionic
