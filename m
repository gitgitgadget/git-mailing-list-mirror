Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033E91F453
	for <e@80x24.org>; Wed,  3 Oct 2018 12:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeJCTOe (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 15:14:34 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:44393 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 15:14:34 -0400
Received: by mail-qk1-f178.google.com with SMTP id y8-v6so3245389qka.11
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=38OYNW7IHEI8Ah05C/4ZPa0RdkbNREJixmNmRRe61rw=;
        b=lDDTp2fuNaZqq5fEZX4ozOF7DW8lZEMko6s5Z7vXsMieOChHonWCxcN1gX0p7vXc/V
         mIaPicHkDtxWBw5Yd5mC0rGi3d/65yfQO9tEL0mSCqa3xrQritZeLKX395a7mx8lY/mp
         616bTdzFbrRs/CRGnwjdoFxIOvuof+c/DJYXjMfUtuz6JMxEW8ftPN8nOOY26ljys3Y8
         QBU7RWQQWR1cd+DFQ5HOpAu+QbUb3FL+88ksG0kC6Jt7iQRC/fGUnBhM3sS2r5k435ro
         WssJna42xSbSPOvdkJsI8dH3ZlpIvLncU+0TCm+X2QM7FgudiHTUUC2QJmOW4k2e08Pz
         7fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=38OYNW7IHEI8Ah05C/4ZPa0RdkbNREJixmNmRRe61rw=;
        b=uNBryVBi2/hlX5SB/ItVFkPgh6GdWk3HEA7haVeVhV6z0DxMrRiIy8X7GxIfQ+1ew6
         td1dWwrHgdOQnYmseXx1C0I07w2D7mo1ZTY43jQOwOPsgtz6Wx6b9QBRjcYyb0Nw28XU
         jFcfvOMdeXmlWSKuDNvwARZsTrUH+AHviM0iF42ygx9psT1wWIqJceKnmOapLD1MW5v6
         Tdb0ARdH223hdXPVJM+XEhZ4BHdITZaWtNZLQUvMAUhizBNOUKPceZIQagDp/qiFwMkO
         VNKLCXjQtKaYIq/KHvEIJEhfFDB8kHipPmOzUgM0S2IZYoPzGKtoZf8T/2Mc6XD3CJM+
         gEJA==
X-Gm-Message-State: ABuFfohs3xhTULv7hgtFe5Ak9xINa8S1P+iee18dD7D4xYhEmh1ACaN2
        6irML362SOLvspg/3uuPqS8k5P3/4WHWn2pPw+P95s+8
X-Google-Smtp-Source: ACcGV60JB3t2Xxc/L3d4FSnOPE499VSItRbGWbxXYjJ6OA0EDXVUFcSPEhRHgYD0RThlgT5ZNOMwITuwzKDWm3czquk=
X-Received: by 2002:a37:61ce:: with SMTP id v197-v6mr865666qkb.19.1538569583429;
 Wed, 03 Oct 2018 05:26:23 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Jeschke <chrisjberlin@googlemail.com>
Date:   Wed, 3 Oct 2018 14:26:11 +0200
Message-ID: <CADWf5z4pAR20qeoT1RnYENBB7Q5fA2fVVTNqPzMzvOE5Dq02qA@mail.gmail.com>
Subject: inside the git folder
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey git-team,
I am working on a plug-in for a distributed pair programming tool. To
skip the details: I was thinking about sending parts of the git folder
as a zip folder with our own Bytestream instead of using the git API.
Is there a common sense about what should and what shouldn't be done
when working with the files inside the git folder?

Kind Regards,

Christian
