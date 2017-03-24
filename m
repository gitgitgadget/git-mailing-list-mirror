Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65FCC2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 00:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756901AbdCXAtF (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 20:49:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34178 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756828AbdCXAtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 20:49:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so26291pfb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 17:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzVHhYvVNvbTezzSo1cdcZ0ImGOgoW0xVDMDC6zTaOg=;
        b=UUlIBPijA114BVAN5YgRJEP/+V8+2LvvjFYS+4GhKG9xYSNwF0IUe0gJ12O3y30+XE
         +BW5Z+aRCRmJ/vC51+h8ZaZbWUcvcvnJn07BzSiQRYNTI+FtvSTpxxU5L/mV1ql8d2Hc
         3Sx82HGHcLTmRJeHTgU2GePRqJcCoxTv+/f21QlPpOFSEjBafZXJmhy90R/DQA671L4f
         NKHIAI/RYnkSBg4sI2EV4Jk/Fvlw+6UK7ljCGk8tHPYCKl0SeV/LxlkoWh8kvfF9gLcX
         OZ8NSaeLr4NiHOmmvqDxgdcht+rW7ZpWPsxI80YcRUF+qw6l34fIfTnmAci7/Sche6Cc
         fj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzVHhYvVNvbTezzSo1cdcZ0ImGOgoW0xVDMDC6zTaOg=;
        b=Nb9o5P0IhDqMCat4JrbgOkkkDzCzTS3VECrVnlee+8AJNEQRRJsNEXlyT/Bu2+0qVR
         P3rZ+jDXlY8ijjeXQHkKY6M+ZFQpunxRISkdb7YcXYmSXoCL4nkJrdO1zbYLt5DHw/Cw
         v4HmlCDEGe7+xGVYu5ILN2Wh9FXgvq6s1Q+/rIXWVHPDu0uyz/ggSNbhk2NZZmbdh3Kx
         W00WW9auNBh5u1RiIxCnPiS/jkLOwn34awoCK2xd6VrgEoH2M0YGYc/6F+PRiWu6gjKr
         bJl1FNWNezrvcY6igalktPOglnSI/fzNAPjtRIaF0oCqBM26NTvNYn27gTDH8bgosJAs
         89DA==
X-Gm-Message-State: AFeK/H0mK92RLV0Ql7dthqTCE7PPm/gDXRUnn5DcbjZ3iBQL9B4+j92a2LEbUsaTHTousA==
X-Received: by 10.98.93.150 with SMTP id n22mr6118031pfj.103.1490316540572;
        Thu, 23 Mar 2017 17:49:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id z62sm542482pff.88.2017.03.23.17.48.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 17:48:59 -0700 (PDT)
Date:   Thu, 23 Mar 2017 17:48:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] branch doc: Change `git branch <pattern>` to use
 `<branchname>`
Message-ID: <20170324004858.GE20794@aiede.mtv.corp.google.com>
References: <20170323120326.19051-1-avarab@gmail.com>
 <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
 <xmqq37e3brxz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq37e3brxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> I can go without "Do not forget ..." and everything that follows,
> though, and if we are going to do so, then
>
> 	--list::
> 		List branches.  With optional <pattern>...,
> 		e.g. `git branch --list 'maint-*`, list only the
> 		branches that match the pattern(s).
>
> would be fine.  I am not opposed to having an visually distinctive
> example--I just do not want to have one that is wrong without
> clearly marking it as such.

I like this one.  I haven't witnessed "git branch maint-*" being a
common mistake.

For comparison, "git branch -l maint-*" does seem to be a common
mistake.  It's a shame that the short-and-sweet "-l" was taken for
that purpose.  Perhaps it's worth calling that out here?

	--list::
	--list <pattern>::
		List branches.  If <pattern> is specified (e.g.,
		"git branch --list 'maint-*'), list only the
		branches that match the pattern.
	+
	This should not be confused with `git branch -l <branchname>`,
	which creates a branch named `<branchname>` with a reflog.
	See `--create-reflog` above for details.

Thanks,
Jonathan
