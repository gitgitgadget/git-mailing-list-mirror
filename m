Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA6E1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeK0CgK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:36:10 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:39808 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0CgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:36:09 -0500
Received: by mail-vs1-f45.google.com with SMTP id h78so11595004vsi.6
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQJvvhLF0JE5gB8oacKl500dbpreLxdGtUM9MSGimxg=;
        b=nWuLMLFZQ74Nl3md74nerFYv9NDmGCtcJ/Dt3k8FSI6IjpO+L5B1Oiu+0NUsLH2qgS
         YMeuDIKlevHWUaYKb9sPGI1bXGHXRzXfADP23TwAHlmW0Jk+SG8CkB+QgW7BBMRbwJAy
         eXTnLEabGZfZC/iehjEhoKKlVxRD5wpAUON/5wwdwHEjHWCpJ+mE/STtyGK/DAqedILb
         DYQfO8qw4xgDEGG7/2m0ljN7ee9Zl501UIKlRQWQ+d5xSvtYjKDSryHtqhQ2RJ9RnCdx
         W0Uvdl1EG9FLscKDjrc6PlMxtyDPhlccPkg1lLvroJTi8N/FasByC3PUofbHrgaK608k
         sNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQJvvhLF0JE5gB8oacKl500dbpreLxdGtUM9MSGimxg=;
        b=NmqP3NgSxAr1jowZMo607TzgRDIhWaviZjL6FktT+iP1HDyKCTsQ9a6j+Kjz/aF2o8
         NxoCWckLgU95Nt03rIBPelS4rZ5A7TJE7Dj6vr1zSdhnp+/gZMRmxiEI9FXRw5m3ruxb
         eOGgpHkyrFoEFjHcmkF8MOdhqJS/G8RB1O0wg9mBPejNgds+XVWR5Y+mkRCq/5BuQcqZ
         cJSlg4gPAghlxgxSEaOkhFfdz3jQJ5Sru3y1VzBUdCIlIydnbocwvRmEbKAf6JPOZfIo
         VkXgZHw3dJVzBZPKgZH1JWAxmcj2Y8vGs5wOG/Pdj8Owuafp2x2Dg+HSbTbTZwbMTooz
         /2Jg==
X-Gm-Message-State: AGRZ1gLn4NcT1SIUvhhip7nhZOy3NIKWFKK0MbbYHEe0sK2qz6ACtMD+
        2uhyNES92J5gizdn8012is8gVv4N/2eov40NUP0=
X-Google-Smtp-Source: AJdET5dvgmYy/Ukr5ilsN4HyMPrfGgzOQCPDjH79sleU2wu2mTH/1qPOyrffOR4whfkkPot387ahZgG0gq0+enlEhYo=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr12318598vsm.116.1543246900281;
 Mon, 26 Nov 2018 07:41:40 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <xmqqd0qswau1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0qswau1.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Nov 2018 07:41:28 -0800
Message-ID: <CABPp-BFY-BmfgphwJ6UrGL0+kS3soa_fM9ayMwPZXQ2zNULRyQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 11:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Unless I hear otherwise in the next 24 hours, I am planning to
> merge the following topics to 'master' before cutting -rc2.  Please
> stop me on any of these topics.
>
>  - jc/postpone-rebase-in-c
>
>    This may be the most controversial.  It demotes the C
>    reimplementation of "git rebase" to an experimental opt-in
>    feature that can only be enabled by setting rebase.useBuiltIn
>    configuration that defaults to false.
>
>    cf. <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>

If we don't set rebase.useBuiltin to false, then there is also a minor
regression in the error message printed by the built-in rebase we may
want to try to address.  I have a patch for it at
<20181122044841.20993-2-newren@gmail.com>, but I don't know if that
patch is acceptable as-is this close to a release since that'd not
give translators much time to update.
