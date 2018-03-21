Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B951F404
	for <e@80x24.org>; Wed, 21 Mar 2018 23:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeCUXuE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 19:50:04 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36887 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeCUXuE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 19:50:04 -0400
Received: by mail-it0-f41.google.com with SMTP id p67-v6so3957435itc.2
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9BeV9g42Km+YQCLYgXInhuXc3II40b4r+oG8coQTmKw=;
        b=B73rRuRvQPHjb4SWFE4ZDJhf9t3BU+gmzSrAwJuiAGYVgV15OnF+06LqIBY5dq/Sxo
         3r5hBlPkBhQtuxFPWUWnhxv5R645OqsONMDrp7H6jHEBXAtTK48mMwsMzmc0jHHO9mNd
         wczZyTyrUwX3/ZGBC5qAWZwDxRAKwUM1xteRnAtpfBheGetPFCHXBNFsW5LepgkdZMI6
         YhaOvT7LMx3vB1o04amgL1Eyv4+WlVtLH1Gg1DevlU8JuB2GedoBHJyp067t8jKXBsIw
         G6QEMikF61wMEt1kqmK2bKWr3JVDL7Q6BWyECWz59mwlqiQaiz4iWEnttX+I6/9kIGyZ
         50oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9BeV9g42Km+YQCLYgXInhuXc3II40b4r+oG8coQTmKw=;
        b=Tcoz8EpiaAzzqKdiW9UdJdnAUTYf4kIXLu7AScSp1JKHl85xaxK9UYgyf+X4Z8Ty34
         q6SEPWL+eIKsRHDVhpO7E499QB0lTVvHRIRnAH9J/F8uSxHe7kuYmrdr6JRBLuMSPcVn
         /SK3Ik6ybNQRV1UfOWDAUAbjgTFsFTS5VfqjrRo2oSJ6ei41fzTgkoeOlWaMBuH4U7j4
         FRTYQBSyoZsv1k2j1oHtb+cD/X+KeV6mbzyksF0g5QBgHgo5NdKwHBMBMGMmwklzswg/
         Rt1wCL53s7iWRkKdwu6pvPzunJmWG9l4GCCAoEDzw1SqCdOTNmnHBx9NMt++IyM9I05j
         GB7g==
X-Gm-Message-State: AElRT7HfkRHhpA+m3ToUFexOf+a674J+c/Elj+CZvv1TBQnNHgt4xSmO
        +I992b0NYI5BNJlnWqUBs8mExJaQmsyduVIlq8Q=
X-Google-Smtp-Source: AIpwx490eMfyDsiQHnhnAnHLQExVR6VI86lOsCIcUbKIl3Rzm44G8+kiTeTQUCa386iQRdXe48vzs3GwnWf4HXpRXe0=
X-Received: by 2002:a24:1753:: with SMTP id 80-v6mr6478551ith.35.1521676203532;
 Wed, 21 Mar 2018 16:50:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.229.11 with HTTP; Wed, 21 Mar 2018 16:50:02 -0700 (PDT)
In-Reply-To: <xmqqo9jkvwjh.fsf@gitster-ct.c.googlers.com>
References: <20180317033142.20119-1-david.pursehouse@gmail.com>
 <20180317033142.20119-2-david.pursehouse@gmail.com> <xmqqo9jkvwjh.fsf@gitster-ct.c.googlers.com>
From:   David Pursehouse <david.pursehouse@gmail.com>
Date:   Thu, 22 Mar 2018 08:50:02 +0900
Message-ID: <CAM5Va3kECqGmw-oMQ_PJuVqfC8-OWWnfkPJQW1Q+bL7TgOEVfQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix typo in merge-strategies documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Pursehouse <dpursehouse@collab.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 1:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I somehow had to stare at the patch for a few minutes, view it in
> two Emacs buffers and run M-x compare-windows before I finally spot
> the single-byte typofix.
>
> Will queue with a retitle.

[resending as plain text]

Thanks, and sorry for the confusion.  I'll provide a more detailed
commit message next time.
