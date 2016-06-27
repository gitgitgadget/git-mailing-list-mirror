Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943872018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbcF0P4M (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:56:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36010 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcF0P4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:56:09 -0400
Received: by mail-io0-f195.google.com with SMTP id s63so24863703ioi.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 08:55:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Nb7jjnxd0mDGxrT7eJ058Ck92V11i8Pp9QtS9vZRXM=;
        b=zxR0rB5gFj3AG4r+Hqg7sgAfNTTE5MYIbBNLd0Kl1fJ+7Din0U/OHNiAb6v/PL5Iaw
         jm02dD0aB3TujxFL/anW0Rh6JEUuG+bSq08qlTk3sfN15SRES3n+IWToRLQlE7D8FEPp
         9Dno/NmjgUUE8MlGcMFNVv7t4LcqY5/N/ntsDHU3nK6V67nUqiyx+/FtD2hIe6KuiyMw
         hr0KmTNEmCvbmB8RKWUHdXMuVR/CZ+TwTmVqpmtVbc16OcdFXkvi8Rifn23cp9R+uutR
         FafO0CJlKpFKqCweGVHJo8zLlYuyS6yWWUqA45i9bMtJlNj5NreaRwJgPx13lRr4JuUl
         t0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Nb7jjnxd0mDGxrT7eJ058Ck92V11i8Pp9QtS9vZRXM=;
        b=EJsOXWZ30Ul+x1ddUdVcDQSR5Y2RTjG3/FWL39YCXBRUNbAn1wmcs1/5jRQi2JbgtZ
         o+CHNG3js/Dh7X07FfjOnNG79J7nAcebuMj2jkVjNMbthpra0w5Qx7FOYG971V5hHZ3W
         AMNR41G/cY91Ao+RqaPaijUhWv0XMzwBAPg4S7+HZDdo0NfpjCVu7UMtz81PoZtV5QEg
         fKweipGGD36jSU1erbWXUMJOnaCSpsdq3H63wgQglCqxVbIOeFcZMiCRzcJ6SYJmuA/X
         L8nZUy2Nvm9d/Yu7OChUzN4/lWWuVNFEyaB1+N8njN5267PYpjF0rhOlc7/Z3MDB2oFd
         c1YQ==
X-Gm-Message-State: ALyK8tKPJ4MFjpRmfrRQAiGni0tkisJ07M3OGzUT4tqMKD3QzxlxEBtfI95llxyy1a8QOp7424X8VKPW3tP9UQ==
X-Received: by 10.107.22.6 with SMTP id 6mr1479547iow.128.1467042955795; Mon,
 27 Jun 2016 08:55:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 08:55:26 -0700 (PDT)
In-Reply-To: <1466963679-9947-1-git-send-email-novalis@novalis.org>
References: <1466963679-9947-1-git-send-email-novalis@novalis.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 17:55:26 +0200
Message-ID: <CACsJy8BTtJ79L9EMJbwVCh-oqd2L-7zJKOquwoHbXkmr1hzAMw@mail.gmail.com>
Subject: Re: [PATCH v13 20/20] index-helper: indexhelper.exitafter config
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Keith McGuigan <kamggg@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 7:54 PM, David Turner <novalis@novalis.org> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 385ea66..336d5a2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1860,6 +1860,10 @@ indexhelper.autorun::
>         Automatically run git index-helper when any builtin git
>         command is run inside a repository.
>
> +indexhelper.exitafter::

Super minor and not worth a re-roll if this is the only change. We
follow the camelCase naming convention here, so indexHelper.exitAfter
instead.

> +       When no exit-after argument is given, git index-helper defaults
> +       to this number of seconds. Specify 0 to wait forever. Default is 600.
> +
>  init.templateDir::
>         Specify the directory from which templates will be copied.
>         (See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
-- 
Duy
