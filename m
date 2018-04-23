Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56BBF1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbeDWTvD (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:51:03 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:44633 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbeDWTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:51:01 -0400
Received: by mail-ot0-f181.google.com with SMTP id g7-v6so9370895otj.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VbAjdHy3BJ+S2gLjMZi4KaMMh5SbhzOviUbxy9tZyk0=;
        b=D1mjg3bqnvBMnqu2YwubucHYotXAqAQ4iouFEbQ28dr0xisRpHIMG1da0oFTDVbkPJ
         Z/rAlbdjQIiQ3aIy+UFtG9E/E/J0ilGWUJHIL6odjjOdFbzonrigMRc/CeXdgJ1cb+KA
         8kQD/reP+MVFVeKXSHOVCXt92IxxnGhUdWhOCjDmTCaoUbWkJ/1tVHL5h5LJvMhyCJ9g
         zfWXkJXNwyguCFr+O9GlqbXOXWIXwo0TiLrNT4j3aE7uy2uXBY1yinqXD5CFjv/OOUBn
         UkLY4tr6ms4VF3Oft9+utyI+WS82obWD/WVfdraTMDYc5Yw0C7eQ9rghsgQCooCceI/X
         Xd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VbAjdHy3BJ+S2gLjMZi4KaMMh5SbhzOviUbxy9tZyk0=;
        b=jibjHB0rUgVtoER+3BcHN3pNgaGOjBn4GZHP9QCXMHraLYiz1tlfmqH5wHcI8lgcUj
         CFi9oaexL8wyz8FhTgQcVNDXgbuhvOrH9XgsjJULJtuyVwp+wOMxXO6Pfa0pnh7XtRNM
         kx7huazJwT+/lg+fclSASFYCNT2kQaTUVQb/nH2+PdzAJP8SVPuucKCJ4douVV956K2i
         HAvOBDwXXra71JP0VJ60+bRCkxbigVC3MVNvyNTSXs5ef+zfSeBnuMvnUvPwQ6KOxn+C
         +BwJogC//is3UDBjobWJxy41OKCYuB1iy5w3wEDPrdtBKGtXruDsozC7xLo0IROO7Fyt
         CUaw==
X-Gm-Message-State: ALQs6tB4P/JJ4/PydNNMfZzC9R2wPSZ5qdap8lLF1wBXzGCRCiKvSb7R
        ILdpZtI2cMUQPoBl8oFQ7ycbGuiAxSCoBdWg34HwrA==
X-Google-Smtp-Source: AIpwx495jfgBcIxJWf4e8mZ7GAb2RWLxKOgaDA8ogaKfXs/wfj4TV2+2k1KEhPwFffiaG1sJ9IXIlpSnRwUuYY+Kddc=
X-Received: by 2002:a9d:5904:: with SMTP id t4-v6mr15967946oth.284.1524513060748;
 Mon, 23 Apr 2018 12:51:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.9.209 with HTTP; Mon, 23 Apr 2018 12:51:00 -0700 (PDT)
In-Reply-To: <87tvsb5db1.fsf@linux-m68k.org>
References: <CALH-0NbMxkQewnrr6S_xtyVH0BrC2J6gpB5r-hx8=PpekP1VKw@mail.gmail.com>
 <87tvsb5db1.fsf@linux-m68k.org>
From:   Marko Vasic <vasic@utexas.edu>
Date:   Mon, 23 Apr 2018 14:51:00 -0500
Message-ID: <CALH-0Nbh1-ckO1O7zayjXZ1gMRBKFv3RtSSkGS=4Tu23uqM-ZA@mail.gmail.com>
Subject: Re: Git Bash Completion Not Working In Emacs
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Andreas,

Is there a way to use git bash completion with "M-x shell"?

Marko

On Mon, Apr 16, 2018 at 11:25 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Apr 16 2018, Marko Vasic <vasic@utexas.edu> wrote:
>
>> Git bash completion script works perfectly under the terminal,
>> however, it does not work in Emacs (neither shell nor gui mode). Did
>> anyone encounter this issues and how can it be solved?
>
> Depend on how you run the command in Emacs.  If you use M-x shell then
> Emacs handles special keys like TAB itself (and the started shell
> usually disables its own command line editing).  If you use M-x term
> then Emacs emulates a terminal and lets the running process handle all
> special keys.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
