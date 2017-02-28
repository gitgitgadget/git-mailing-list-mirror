Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB0A2022D
	for <e@80x24.org>; Tue, 28 Feb 2017 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbdB1JQ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 04:16:29 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:35981 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdB1JP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 04:15:57 -0500
Received: by mail-ot0-f178.google.com with SMTP id i1so3935068ota.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 01:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jc3SfPT8iBV7SYIFhRT+/+FAfZUQEYh8DKLVuEpWO4s=;
        b=RbAlRjmC3v1oP5qiD52fBph1j7G6PENsJfrHlaTpbuiixEShiA004Z8S0bPKg8p71R
         0b0ru4NKDVmvPo/DC2V56W3Cc4gxEgYKNu5fNbdfl2X8QDRUcChrb22Gz4oQKCVmeJDG
         6hJ+9dnq4OxPWuiBahW/Xl7P8dbTcKI6JnCsQwfH1Zp+b5XsbOHVdb1jM6e87JmhZRb/
         y1jTvCpZ48UrYcMZwwjHmjIHBrleLjUvSWfckcbqW2jUN+/ylb+uUF0N/vYQd4p4j28Z
         3Tv6NCBjVyp5W5Kt3JGbSCLfgMKGNhMiFSl8R9uhRCHcut8eb3WiB67WkPm/wNt2jz3L
         W14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jc3SfPT8iBV7SYIFhRT+/+FAfZUQEYh8DKLVuEpWO4s=;
        b=UB+Eg05sUdJf9snSFoQZvS/w4ZJ/GvOZzDZT18ksiV6ZrGLPEy+e2vdbjMfMzgJHv2
         SVx5Hc9qYKT2s4SyaNOpsw01N2TynuHJ4QPyyT3NZFk+M59JEObTxx3JE0p4Z+qk9EQI
         hp4nzq3sC34hbBblmmRIFe6glWOJfOs71ZtCEoB/jv0yXo8LHCsl5n9NDVdUgzzsq5bV
         eKSr0aNM8jwaOj7bCtMIrCgdqV4Onoij01xw0jg4PPy+eCuQI9vFw0gAp5JzqeGkpQS6
         hCr5zazQmRIqA0DUVdN7KZYxA0EGhXQqEpJnWrAjz5L1yT99d4+WnAOhls+JJTYM/hS/
         Vg+g==
X-Gm-Message-State: AMke39k0y83vKLIub78drTPLUuoxVeMqv0y3iEQwxwKR5/r+7wjOo9ukdytHd0+yUEjycBjX+zH/7awb3go8HQ==
X-Received: by 10.157.6.233 with SMTP id 96mr608353otx.37.1488273332042; Tue,
 28 Feb 2017 01:15:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 28 Feb 2017 01:15:01 -0800 (PST)
In-Reply-To: <0E511C089BC341FBA9DC694C1CE770AE@daddy>
References: <0E511C089BC341FBA9DC694C1CE770AE@daddy>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 28 Feb 2017 16:15:01 +0700
Message-ID: <CACsJy8DQTi5s2BmHSkTTjVKZu+ToeVhywkZa2hzGtkzWo95LJw@mail.gmail.com>
Subject: Re: Bug: "git worktree add" Unable to checkout a branch with no local ref
To:     Alexander Grigoriev <alegrigoriev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 9:22 PM, Alexander Grigoriev
<alegrigoriev@gmail.com> wrote:
> git version 2.10.2.windows.1:
> If a remote branch has never been checked out locally (its ref only exists
> in remotes/<remote>/ directory), "git worktree add" command is unable to
> check it out by its normal short name (not prefixed by remotes/<remote>),
> while "git checkout" command has been able to handle such a branch and
> properly convert it to a local branch.

We call that "dwim" (do what I mean). Unfortunately "git worktree add"
does not support it.

In the early prototype, "git worktree" called "git checkout"
underneath and something like that should have worked. But I don't
remember if the dwim came up when we decided not to let "git worktree"
run "git checkout". And since dwim thing is checkout thing, the
feature is gone from "git worktree add".

Anyway, I think patches are welcome.
-- 
Duy
