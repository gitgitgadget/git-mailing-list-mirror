Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AFD1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757594AbdJKR4O (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 13:56:14 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:51177 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbdJKR4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 13:56:13 -0400
Received: by mail-io0-f174.google.com with SMTP id 97so2671770iok.7
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tZZjiU1CCCPgma+dwG3dxgVane2iueZ9p/pQPwN6+BU=;
        b=rkfn3liyJ0BO/Y5lPHs5yLlpl8pWLKfXd6QjJMrCsRY8DwmJY5gTzxa7VwhXVcJ0s6
         fCBHYgyI27AIOLUWtItUkyqkdBzRLF/XY60gGPYWFTlTPdLfytLhlWKl5e8FZcwIcz9e
         rKEwL4mCJnS+sMVrhDUrIUTkZYZTrzaLUMx14e5Prqma8CpabNYSAuDXpL8sAO2jVVAl
         TX9G2byipnYiBMzxRlXgPa6xX9iMNd5r5Dy1/ujYWD4xC6Npsaeb3Zz5DMpDJ8HED7WJ
         M/jkytZ+ORrG3Hw2XrZIoXzaPy7Dx+x5kZ7JuCUS8UyTtk+E4KKH8FqJAOUW4FxcrUjK
         w0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tZZjiU1CCCPgma+dwG3dxgVane2iueZ9p/pQPwN6+BU=;
        b=cWb9+XKjIRALJMdxPohxe0tqhr6JVGKYSlqu6y4gpilJ5S4EMmOcgPwDsfy3sYvaLf
         Zbj1vytgIL+gt1B7huH9HQlHO5oLsedFVC0aR1WmirjOIocgfOPrSqWbc8vKmNMciNcJ
         iZAelLDoYu4bik9BAig4RvOUBQMA0qTG1KBkTv2rPHzAj/DYOsTomVJhiwzIYNzn/E1G
         v6W0T7gtXSesGMbVqr7/AzLGSSlV+bo18EGGadRT2klxcKvADnQuHz0/UMtad1FKFuOb
         xv4WnVodKeU8lqxpZVv3H4Rmd57BgxRwwPdrJ9HoMc+wrGBblfwpcULOFeYDsT3Folov
         GT2Q==
X-Gm-Message-State: AMCzsaUdEkR3Us1nSX5WrLRjde75bhdf/EYGB8H0z2n9VTDscEty20tW
        L0AgNqx86rtBjznXbfSkRbIJ1vAYkP6KgGkXFYk=
X-Google-Smtp-Source: AOwi7QANEdi/FwMkYRiLqwyJwnAdbseXaSyRXpPU6nRZgtvFgZDO3NxNc0Isoc+AO+uK7LENmTpTnbnVm7nMYN8rhLY=
X-Received: by 10.107.24.133 with SMTP id 127mr113755ioy.115.1507744572535;
 Wed, 11 Oct 2017 10:56:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.145.215 with HTTP; Wed, 11 Oct 2017 10:55:52 -0700 (PDT)
In-Reply-To: <20171011174952.almye3qa2tmyrmol@LykOS.localdomain>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
 <20171011174952.almye3qa2tmyrmol@LykOS.localdomain>
From:   Ayush Goel <ayushgoel111@gmail.com>
Date:   Wed, 11 Oct 2017 23:25:52 +0530
Message-ID: <CAEBs8jKAsb3B-6WJ=ptL2AsGvDRFVPYLCsztpdTN6KCBLOo1XA@mail.gmail.com>
Subject: Re: Unable to use --patch with git add
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Santiago,

Thank you for picking this up.


On Wed, Oct 11, 2017 at 11:19 PM, Santiago Torres <santiago@nyu.edu> wrote:
> It'd be helpful to know:
>
> - What did you do?

I have recently updated to git version 2.14.2. The problem started
happening after that.
Made changes to a file. Tried `git add -p`.

> - What did you expect to happen?

Enter the patch add mode of git.

> - What happened instead?

Usual git patch mode is that it shows a patch and expects user to
add/skip/split etc. Instead it never stops to take input from me.

See this ->


git add -p
diff --git a/Tests/OSXTests/TDTStreamingTests.m
b/Tests/OSXTests/TDTStreamingTests.m
index 35757bc..525fe56 100644
--- a/Tests/OSXTests/TDTStreamingTests.m
+++ b/Tests/OSXTests/TDTStreamingTests.m
@@ -116,7 +116,7 @@ static NSTask *compressionServerTask;
 }

 - (void)breathe {
-  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];
+  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.01];
   [[NSRunLoop currentRunLoop] runUntilDate:date];
 }

#### Expecting git input mode to stop the process here #####
#### Instead git exits without any error #####

>
> I suspect you are using --patch with a new file, so you probably need to first
> add it with -N or so. This is just a shot in the dark though...
>

Not adding new file.

> Thanks,
> -Santiago.
>
> On Wed, Oct 11, 2017 at 11:16:39PM +0530, Ayush Goel wrote:
>> $ git --version
>> git version 2.14.2
>>
>> What more details can I provide to help debug this?
>>
>> --
>> Regards,
>> Ayush Goel



-- 
Regards,
Ayush Goel
