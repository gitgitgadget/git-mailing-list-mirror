Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C512013A
	for <e@80x24.org>; Fri, 14 Apr 2017 22:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbdDNWpT (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 18:45:19 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36475 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdDNWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 18:45:17 -0400
Received: by mail-it0-f46.google.com with SMTP id b15so1847655iti.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JAEYILnr9KSU43H3VMDOOZRxTmdKoHw9/Xb2hA5Xf7A=;
        b=gJ69tPMmH0ZL3/8WGmZQ1N2lWNj3kwPUMsb4hbQgNlUcawbgctDSvpOjcgyi2VSLqj
         mElziHZc4143RGTWcAJIP4mVK1UbNd+aHcEbkLBnLgFR4pAtFZzmBJjZ6/oSqfXfm5eP
         7IbolOg23Mb+ZZO0mvFLUDJyp2jl1gIERA5SErj72CjoS7hAeBtzCSlVkIu1mX/W2iSG
         sHqiPlWnuA4rq07ylYjKR5Ztiz84MpsUjwtNOVi1zM65St2++q+iSLXEImetNKtX+8Ki
         dG6bY8zIuxajHiSmuebmwQ29cDP+ti+jfW3IXSl9jsfSf8j+kNkc6k1yFoOFyfxc+SJb
         iylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JAEYILnr9KSU43H3VMDOOZRxTmdKoHw9/Xb2hA5Xf7A=;
        b=Pvc3mzFdkgYmQHmec/2sluiu0vgEVFdlNbk4e00JW0IhDyv5vJmsnq0CnS9x0gE/yx
         CQxIaLoEqqhDYPlqgZRq5u5QGIc5r8s45WBbMea7CeObpqNWJyn2yn3dqCGgEASfox39
         v/o+exlXPWQh+He1ySyx5tW/f8Ukvav2IupYQCZJ4anUxG9NidWupL7YrTGIWK7n/7tB
         9DHZVFtcAEPG+shuePIa4CIpA4ZCtY/tYlRqG6w6b8YAPhXTQZNyG90c2tu0iSOS1b96
         NN7g3Xio5njWCDIJ4BqqPkuUuEF+KrF5QqIaNj2QWDJZjlRhy/czWXU+yaivYILo4FY3
         vXAw==
X-Gm-Message-State: AN3rC/56dP+c9UlU48toqaLUd84bt7vpCsY1YSZJ+/O4ZwRs7nFYU0Yz
        umZByIOxx9v2UpsLUA/R6cKJ/f+N0A==
X-Received: by 10.36.115.12 with SMTP id y12mr924639itb.24.1492209916931; Fri,
 14 Apr 2017 15:45:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 14 Apr 2017 15:44:56 -0700 (PDT)
In-Reply-To: <20170414165044.13990-1-giuseppe.bilotta@gmail.com>
References: <20170414165044.13990-1-giuseppe.bilotta@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 15 Apr 2017 00:44:56 +0200
Message-ID: <CACBZZX4_yTbJ77XZYGGyh1B_Lo=OqteQTDXyaSjdoR9RvVuHAA@mail.gmail.com>
Subject: Re: [PATCHv2] rebase: pass --[no]-signoff option to git am
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 6:50 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:

It should be --[no-]signoff, not --[no]-signoff, since the latter
implies that ---signoff works, see my 2c7ee986c7 where I fixed some
existing instances of this.
