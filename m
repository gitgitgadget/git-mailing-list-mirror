Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176AB1F859
	for <e@80x24.org>; Thu, 11 Aug 2016 07:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbcHKH6u (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 03:58:50 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:33192 "EHLO
	mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbcHKH6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 03:58:49 -0400
X-Greylist: delayed 33331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Aug 2016 03:58:49 EDT
Received: by mail-yb0-f181.google.com with SMTP id e125so21811278ybc.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 00:58:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bxvaYp6Gce+5kcXUMI6+lGApz+czhJ4S5AYHct99WOQ=;
        b=Vmw8VOfryFcmSf5mKofG2OD+zjq6dzmgwQu+HV5zkoW6HrZnzSu+toGub8VdaTfCZB
         9ADbxDo0pe+Sq5HI2j/lYt6jphJuufOS0eW0n8bVEr/YrrlHqbTK7LdB2SUMe/7kSdDs
         ya0FhteeLXpYYC4S7sAv0N6Rjrf/KwbO4HOzH+tWw+3V3wo/Wa/FuI2mzvIqmpiL2Vzh
         SNObQXdEaB5Ix7pIJrMKXt5U/cYMfQOrl2j+DUPrY7BQg/9T64J7Xp/by8uIJQn05fsP
         6ArfKmpi5OGbkZ2O5OfTU7jU3JEKCn4wzpdIiypA5nR0oHZ+MhDx/xfQoaWZe3pYmmXK
         b44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bxvaYp6Gce+5kcXUMI6+lGApz+czhJ4S5AYHct99WOQ=;
        b=NTe4ZlR90NGOB6Mkuw1F0lQ5T0R28bxgOdagY12LUAaec5NrLgvEUoNFZi6FGS2NGn
         Mp4ZFCU+m1oEx9imcR7pPcyMBd4nS9sWyMy9p660zFWEh3wITsYt97dQDRYqgj64+Z8o
         Z4F6ibs+93AXcZzWiwTnmnZYla3b3qY53oRN+kPCJYN279Kv/6ZJAsyak62443W0XXlc
         cvsKugopAxLeS+dcMwQpKt/Kp8KxNC2/hHJcADvRsRB3CpHZa7C/b1GfxSMyQWvTJefY
         6sq8ywdD5OWIBTeBSZttk/L/SBa98+NYgvOsdnKIwJIaljTbxyTiUaeKVKcK9eI3htOq
         z4xw==
X-Gm-Message-State: AEkoousI3kfZGdHrh3jHLcgHHhKJbcV7Vy2cnWcp49XM7zjLmS+VgbaeCYCCs53UuPRJCT+G/GwGfcArQ+ibBA==
X-Received: by 10.37.97.149 with SMTP id v143mr5447775ybb.164.1470902328438;
 Thu, 11 Aug 2016 00:58:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Thu, 11 Aug 2016 00:58:28 -0700 (PDT)
In-Reply-To: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley>
References: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Thu, 11 Aug 2016 00:58:28 -0700
Message-ID: <CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com>
Subject: Re: Can cc's be included in patches sent by send-email
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 12:32 AM, Philip Oakley <philipoakley@iee.org> wrote:
> While 'git send-email' can have multiple --cc="addressee" options on the
> command line, is it possible for the "cc:addressee<a@b.c>" to actually be
> included in the patches that are to be sent, so that different patches can
> have different addressee?
>
> The fortmat-patch can include appropriate from lines, so it feels as if the
> sender should be able to add cc: lines at the same place. Maybe its just
> part of th docs I've missed.
>

Yes, just put them in the body as tags below the signed-off-by. It
should be on by default unless you change supresscc or signedoffbycc
configuration.

Thanks,
Jake

> This is for the workflow where the patch series (including cover letter) is
> reviewed before send-email is invoked to send to all adressees.
>
> --
> Philip
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
