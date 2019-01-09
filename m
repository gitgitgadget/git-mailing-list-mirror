Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9911F803
	for <e@80x24.org>; Wed,  9 Jan 2019 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfAINsc (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 08:48:32 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46296 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfAINsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 08:48:31 -0500
Received: by mail-ot1-f45.google.com with SMTP id w25so6678592otm.13
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vCjIQ+V5cB6XmHimWJs6EQfyI1WUWSXMIoENuYvSfz0=;
        b=qMC6PfhkMhnThfYKIdceD0xe8wcVn0P6WMmtaRzzzOkk0Qk/zwBuNZYXSGmCBMnNxT
         aImj/Gts4OvpctfsXB4+2KHD7VZUxlTdPJdFaEovzryS0BZlB3ItCvkL7ystREHl7iuF
         5uWBJTh4B/QNBS+Hil9J13FmkskZxhwcQ/vTAbWxBuSTfHBTchCTR1v5JxpRgFvNALbG
         ag7puvO9xzly8npKyr+pxAhQFyMOe5TljEVoaRG5nD9xxMaZKqxzeca9/cvtNhnHQkTv
         rrV7lPHo1ppZ7QLAAOJHdmHD7LFB77BcjX8wKGMJkyXlZaM1E9Z3Y6e/iIwSXOuPqzSa
         Kjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vCjIQ+V5cB6XmHimWJs6EQfyI1WUWSXMIoENuYvSfz0=;
        b=pl665NzsWImbI1OplZfUUiiZ7beiUmjmU7U71qm5FIL8FUP87pDYs45/HQGYjBmXny
         I46738wEawbkjaJGL96w19+JZ4SNbJ7WGELX507S8fwMFtUdLTEQshgnjs2uTQTC/70a
         +D46oiJAF+w9sw6Gpr2Div3rrCLfZRdWPToKutjc8DnhCQvD+VhzPWclUNcsKZCesuto
         F+Wnn3clBhjoivewBjdCr8ofNAuijwRqCPpaa4xJ62URtqyWRXbaCmShTeBzLSvDlfDu
         O1THPWzrdVWp8xFR7GAEY+dDw3AcDon37pQK+y/FWyE6WOjtZplkKn5k7rFbrKzdJrjG
         nyvg==
X-Gm-Message-State: AJcUukfV5poQ5UvavLojHyX7+nWylMpZfF6bKqyy2iEDgxYjwoQmA25k
        WT3d0oFkHgcqeGIlO0pWt6Ihc7FQvkcOJtzX/hgSlg==
X-Google-Smtp-Source: ALg8bN6u0z9IOESnoZAUKKklDQ3V5X1WcwMrQdsYarpEROsOoZNBSnQZ4aM9hUZQwudOzHCbLY3soeIvTyF1T+HbbQE=
X-Received: by 2002:a9d:263:: with SMTP id 90mr4424749otb.164.1547041710672;
 Wed, 09 Jan 2019 05:48:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
 <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com>
 <87r2dmc1q0.fsf@igel.home>
In-Reply-To: <87r2dmc1q0.fsf@igel.home>
From:   Markus Wiederkehr <markus.wiederkehr@gmail.com>
Date:   Wed, 9 Jan 2019 14:48:19 +0100
Message-ID: <CA+h-Bnu4mq9FZ7dBnCpKfaYeSQM-JTqNO6a1FBKyBSNQ3sR71w@mail.gmail.com>
Subject: Re: git rebase: retain original head?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 10:29 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jan 08 2019, Markus Wiederkehr <markus.wiederkehr@gmail.com> wrote:
>
> > It is not, depending on what happens in the rebase it could be any
> > entry.
>
> Don't look at the HEAD reflog, use the branch reflog, ie. @{1}.

That's exactly what I was looking for, thanks!
