Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6BE2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 17:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbcGRRnB (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 13:43:01 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35318 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcGRRnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 13:43:00 -0400
Received: by mail-vk0-f41.google.com with SMTP id w127so190576796vkh.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 10:42:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Hy8Ze1E79Js+ai7U8TZQsOeGiJvZERL1ep0Bff4XcrI=;
        b=ADjkGtNpQvmPFJFajN9VoMsydj39450uT8HdVN3FL61WZiGnnz7WvtznU4Ymv1P1K+
         qxGqp6a3fJjDVGkIp5j96OOOPinhDfKWiBR0pmEsrReBe/4miEO/WqdB7NPATyMgLvOm
         gqHJCWYZNoGD2jkz629pqDfLMTpMJolYooQSDAc59JF4Ifn2XM9AFXG20HXGEsbhDHmb
         lGdRJz33YrRZdHsz+9lvXziqP+oaSbjqmTVon0HBiYpmrxmwoiuH+yX9odkhe9zVcGpr
         1yqzFrMuHQmcv/h9dnkYdyVOV1ZHN8kHTBJxUsUM3xPJk5zrBGEitl3Ga5TUL1sW7QW/
         riaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Hy8Ze1E79Js+ai7U8TZQsOeGiJvZERL1ep0Bff4XcrI=;
        b=iduSTH3DDlBrcdWHc/vQGwXOKXTksx/ALUb8S0f44d7Okqva0iEMzrw7YQ1NWskaV1
         dpGwN1CV9FE+XgFylINzs7h559NJe+Un0th2IV1tSVlBqyXzv9i+Tqy8qMRde8SSyXrI
         UGhtuf7Dv+Y9qxECyqiKIOJMNjoRK++zn/hDWDSaTtgq7EIvlyp7IHxkOV7wEwTeG7TA
         MX8sSc6430ydW0lBzC/nswzEttEpZXJ6sLdx2epeOdhTLEGqYLr7nypjDN83DRm+CFui
         3ZE/FLuSx4tlX8OwBWQPaVmd+uojcQJ6YIxHuI4xwnTbm7nI6syltl3qAAVJ5tz/FrTF
         pd+g==
X-Gm-Message-State: ALyK8tLj+NswlZTZnnPOhWtAwmuYF270N3vugGRlwWtfB/TMlOSjO2t689dWgWfrVrj+KsE+LBVvF5f4OMw8KQ==
X-Received: by 10.159.54.143 with SMTP id p15mr19176517uap.148.1468863778008;
 Mon, 18 Jul 2016 10:42:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.83.197 with HTTP; Mon, 18 Jul 2016 10:42:57 -0700 (PDT)
From:	Ehsan Azarnasab <azarnasab@gmail.com>
Date:	Mon, 18 Jul 2016 10:42:57 -0700
Message-ID: <CADWjqk40KK=AuKqqdpKjkBuUvhQb4k4fMR4bPfdo8JkGRs-Y9w@mail.gmail.com>
Subject: Feature request for automatic worktree checkout
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Currently if I have a branch checked out in a work-tree, git-checkout
will show this error message when checking out that branch:

$ git checkout master
fatal: 'master' is already checked out at '/home/dashesy/development/feature'

It would be very useful to instead of this error just change the
current working directory, so git checkout would become a `cd` command

Ehsan
