Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A841F4B6
	for <e@80x24.org>; Sat, 13 Jul 2019 12:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfGMM42 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 08:56:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40672 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfGMM42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 08:56:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so6093141pla.7
        for <git@vger.kernel.org>; Sat, 13 Jul 2019 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4Dxq/UNYg910rv1OVmoKycwLTgHkw3lD1tLJHKGweI=;
        b=QWvFpRU4/i4kIdlFYSer4T/iasYV9mrxSNB6NThUXHWvAxWprMMxbam77ek+TbBUNr
         wTX88alMxwb+/KIcAzVtzxd2wbKP0bpLD591XOlIvMrAM016gXIleeEBqljxniwqliVL
         6scf0am13dBX13QFGJgRyYjJDPKCkvsEYsMFWI+rUv7SkCA4gDSozFnSD1z9B0bdMk3h
         Z9rTnMZNdP/jA0kdPwqKHPM+anSL/YVb5XAIlrgaQwpLNTzlarmWARhHEU3KPS0EQxaz
         Q/KXunqtSUiA2X9Dst0A+EGIsNiN6e4qoAndltPEhBdgtxLgVM+eXRlqcQDmGGoZ2lWG
         idMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4Dxq/UNYg910rv1OVmoKycwLTgHkw3lD1tLJHKGweI=;
        b=VynPgDiByhj0WKS8vJzYUKJZhNoEubb2O+JPdGxhL62xNRUpV3iB3W1fWv78TcUFAK
         9NSi+GlUuNoLysoTOMqrwP522DbR/wl8R5Ot6FLGSScSDm7u2p+j8S2ktox80wue3BBi
         CTMiysxxs+21vzOGB/PHjKAS7Ms3BEG7gUOutWl4HTId+9htHJ7dijAIKpKXtBkrgYFe
         qjL0Q+3Q1cD8JIuHWuEGwskzT+tkAlGToCrqK33n5DiVqahLuIz2EQKynTi91ZPhG4Ha
         oq7BxxejB0ZhHQF4rqpdMTCbC9QZMsMHXSWYServrzLkkulbZWx0F+3pw+fDv4tvPsYc
         ET3w==
X-Gm-Message-State: APjAAAWC8apfk13MqbrE4ENhxZDPwbZAb0GhIJcE9hC2sgQWqmFnzZT0
        E5pxSPhEiWM/ryq5ez2SJe1eKdQAbUBECrRwPvWH39Yj
X-Google-Smtp-Source: APXvYqzbT3hMvx1hQlEVqu9NnqmQAA2FmqU1cD6iRrBCnT3O5RR5U5OvGqAAcx5OoNL6uTd1xhqx2bV/k4TmtjgJS0I=
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr17434074plr.201.1563022587606;
 Sat, 13 Jul 2019 05:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org> <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
In-Reply-To: <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 13 Jul 2019 05:56:14 -0700
Message-ID: <CAPUEspgmkP_7K=eap3LpQSCp-k6HZ7FK-_LaBoBiJR1CqEMYmA@mail.gmail.com>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 13, 2019 at 3:46 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Using only = { 0 } for zero-initialization makes the code immune to
> rearrangements of the struct members.

But only by forcing to set whichever is the first element to 0, which is
exactly what sparse is complaining about, since it happens to be a
pointer.

> That is not the case with = { NULL
> } because it requires that the first member is a pointer; if
> rearrangement makes the first member a non-pointer, the initializations
> must be adjusted.

luckily sparse will complain loudly in that case as well as shown by:

$ cat t.c
#include <stddef.h>

int main(int argc, char *argv[]) {
  struct {
    char i;
    char *p;
  } s = {NULL};
  return 0;
}
$ sparse t.c
t.c:7:10: warning: incorrect type in initializer (different base types)
t.c:7:10:    expected char i
t.c:7:10:    got void *

Carlo
