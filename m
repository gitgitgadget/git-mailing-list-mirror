Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8E92023C
	for <e@80x24.org>; Fri,  8 Jul 2016 07:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbcGHHvK (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 03:51:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33842 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbcGHHvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 03:51:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id m2so3519079qtd.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 00:51:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vo7oGAn1iKp1MZZZvDe99PrPFEoBj4E1mvIi79MUX1c=;
        b=yiM32oyJHNO65rg2WMSyzR/NFGwRFEXrrKkuKjz87wtnvP23ONti6NRBXTW18+Wjgm
         iTXAMie/6S+nHb+lKSPSwxyD75WSQ8UI2Ekk9bDqH8hl7+ujAFWRu7EjjeCKTE5L2rVP
         QtQr1supSb0Grl4S/5Ce5Kzwbz9mxp9VlsBig7PkQkAvb/A5WnT+pi/TIVUz5yKWXvjM
         M3xeQT+pjb6lE1oR7Xk79X7hScgwD1JPisJmo3aveqhUQk9/4DFX0CL44MGZIQHsF+Tq
         aMJBs+YDI+Um7PX/jcKBeOEi+IHGfC8G5NiwCEGg3QW97DJmHs0OI1T/4wKumKlZa9Cc
         OWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vo7oGAn1iKp1MZZZvDe99PrPFEoBj4E1mvIi79MUX1c=;
        b=RIz/Amk8OYt3jsk6+NrDME1MXO/E46gNCzq7z3JKrBNml1QoIG3DVUQibQUuJJhBK1
         W7WoUjffzXyf1jbwNut0WbbxAIIxWBxKDzI0MIyDFmO4XSn2ywUlaFUU7mUgDEvC7mo0
         hImU+nYbiwfk/JoRnJzeZOVcnilZg0ZA31ktQo4C5TqVshcbKKnlRHUXw+5D+JZzQP+n
         482PFy8DG9XnKnzI3ewDbXnpMeLtgmsJnC7+ZUXAcXr3TwZabtBj6Py6TcXFQhwRM9ve
         BMVFDiCd5pGG78BctyIlFpFPylQybO4SbK5LB5gaGiw+/7tI3pKq21OAns2O+h8zWUoF
         +/RA==
X-Gm-Message-State: ALyK8tLfNCFHECQlzoB1uXX0AwrAufRmHw1KhW2Tqngq1kEewE8CRZ3Hv8oYu1bz6wKE50LjwrsU1PXvXZetBw==
X-Received: by 10.194.178.199 with SMTP id da7mr3877011wjc.123.1467964266365;
 Fri, 08 Jul 2016 00:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.33.165 with HTTP; Fri, 8 Jul 2016 00:50:26 -0700 (PDT)
In-Reply-To: <ceb80e45d1f02b71cc5ad2d7ded04360c530a9a8.1467962234.git.johannes.schindelin@gmx.de>
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
 <ceb80e45d1f02b71cc5ad2d7ded04360c530a9a8.1467962234.git.johannes.schindelin@gmx.de>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Fri, 8 Jul 2016 09:50:26 +0200
Message-ID: <CANQwDwfB=NuZuzVJUOLncF-T8gLzJne01i1K2zrXJwgKBLidfg@mail.gmail.com>
Subject: Re: [PATCH v2] am: counteract gender bias
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello Johannes,

On 8 July 2016 at 09:17, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
> almost 11 years already, we used a male form to describe "the other
> tree".
>
> While most likely unintended, this gave the erroneous impression as if
> the Git developers thought of users as male, and were unaware of the
> important role in software development played by female actors such as
> Ada Lovelace, Grace Hopper and Margaret Hamilton. In fact, the first
> professional software developers were all female.
>
> Let's change those unfortunate references to the gender neutral "their
> tree".

In my opinion more important reason than being "gender neutral" is that
Git uses the "ours" / "theirs" terminology in all other places - this patch
makes Git consistent and code easier to understand (it also removes
weird plural "ours_tree" vs singular "his_tree" in code arguments).

But nevermind that...

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/gender-bias-v2
