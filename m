Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0BAD20970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbdDJKJr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:09:47 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33945 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdDJKJr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:09:47 -0400
Received: by mail-qt0-f175.google.com with SMTP id c45so58336299qtb.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7obixnzNJoBlBpHSVfpLzYs4pdVcIvsf4EZkUd2NnSE=;
        b=YDGsyz66Ok5q2yijIg1TdwYVHGfZ6kDFq/cetNXzvzFNNNAJdlOvyewR/IpNW36WHK
         AVFTdwTrwS0UQJplIKvHbUXna4cSitCm5WUZh6NIDihbkgtymiEB4u6x+KXbQXl8YrC0
         NiigdrK2svGUnjd8d6UcEHNVNw7hrcBgZinF3tM+Zmxyyd/7JLGf4EdVORv/DLDx8F5D
         pxzkyEdzP4LYeysRZj+RYOcEk0MpG97MRCsx7QBnrf9MWtQF3LMcsPZnfnHJ3pMaDHdy
         6YQ3wdjDUcnKlhgQgqKZyUygKdG41fT4kQlokxDEAlsaxufhVOEnNdCvvCdafXNKkUpr
         huiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7obixnzNJoBlBpHSVfpLzYs4pdVcIvsf4EZkUd2NnSE=;
        b=mL+PsPtQ9bNVwPUsvpGuiutA62+7aJI9e42amQZLlFPMGg+6CzOgcJck+EzfKgYDop
         6Qxh+U1HjY4Cx96oieEMnH6RNZWInOr3rQHe1mMBEd2BuHyGsH+9jfzWF02vtaHqlSdW
         m2Ftrp0hhjKOoZys6MX7K7ayWBhwa99Wdg7Bw+L4PBb+l+VR4HVEh3d8Oy7wvBHopFU0
         VRHpDKqDhxKfYl28nS7DTHb/f2wyk6wJhwUcxOTM7u1Dx1sgcd637hVl/mOfLSh6WJGH
         lZNcv1M9OUW95+7f7fKvlGspV0kslJw0wN+DWUaGAxXKkwgsxdnMTWMkd2EhK5x07Mgf
         vQ8A==
X-Gm-Message-State: AFeK/H0jCZtW6OTQyDJpmZ9izuGjj16cXoge5UfxmAACyF7pC9GC2/k9y8xYQ8n5m+WODxvNLx2e76vN+aYQ2g==
X-Received: by 10.200.34.37 with SMTP id o34mr52085513qto.213.1491818985992;
 Mon, 10 Apr 2017 03:09:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.32.164 with HTTP; Mon, 10 Apr 2017 03:09:45 -0700 (PDT)
From:   Julian Goacher <julian.goacher@gmail.com>
Date:   Mon, 10 Apr 2017 11:09:45 +0100
Message-ID: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
Subject: Modifying a bare repo directly
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

Is it possible to modify a bare repo directly? e.g. is it possible to
insert a file into a bare repo without first cloning a non-bare copy?
I'm thinking along the lines of a command or sequence of commands that
modifies the file index and then copies the file blob into /objects,
but in a situation where the new file exists separately from the
target repo.

Thanks -

j/
