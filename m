Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006D320248
	for <e@80x24.org>; Wed,  6 Mar 2019 01:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCFBlq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 20:41:46 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:46261 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfCFBlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 20:41:46 -0500
Received: by mail-pf1-f170.google.com with SMTP id g6so7137447pfh.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8yaiZoj2BrG1oyOteau8FgOdMrcLKTmcHxiDnO+nzU=;
        b=JzVqoPs1xQ4oitTroVchaTVpxjsh9cI0jhUgRerhcclqcgzax17UX4hUtivWz2PYTu
         lZhmNVdsRyiQ08FA5zq8EalHpxv0/JgzTNqNTIPjuqayoHQpZNCAIuOXKs/LAxUP4/2a
         1I19W8lFPtnDCXmx7HGuNWSSWAumonSjFVrUQ2cAe5CYhUIakysCr22txLrnS6ciQWHb
         vSxxQ6YCrJn0s/dSKqvdpYvAITh1NT1xceHIn6k4DQMTgOvgU7vvbZmnymyfkxxW2JKm
         fZ1LY92j8XyUvfcmTUzgLn+dEcL7YiS4gCc55VOhL07e1XhZ7hsfcAH+JxZF/JOudNsE
         W3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8yaiZoj2BrG1oyOteau8FgOdMrcLKTmcHxiDnO+nzU=;
        b=puALwuJ0KB3UdqxMF2055eFkojgU0pugGmYOAdlMZQKGMOqjPcEFR96oIeCCHI4PED
         atINP/MIOyRiZJ4eIvdZmETSrkiRPK71XucwKK1t8VOVV0h2dZ5g976D2jO1sppuWk/f
         lktLJm7IrdR0VxlEQFqamtxBFbW7zEei476pNCvHIW6tyIoXgMCf/nnTvH8twK00y7oH
         WUiEs4G8gGoEDdRbA7JBm8zULtNNORaTeTcRfecX2QzCcv68i86r+KyfyXEgayaEaUjC
         3IuAIAg8mPz0ktJum4RREeggT2XmvkqKq5YcA7rJc1ZTCIl+vhQz5NmNk4xz0ibXgdPw
         YM6Q==
X-Gm-Message-State: APjAAAW6YEf0jhnXlvSJN38CH4iVStrn3iZiERgyYXWKnRCbHc2VKTfz
        Gkw6jJ3dUOHHCdjN5+1wVhs=
X-Google-Smtp-Source: APXvYqwar6v+mE6zHw5JHAYZdPNi6LUfc7OYyQjHiY4tMF62F3q7Ax4LEihtJ2KHd88eXPTTv63RmQ==
X-Received: by 2002:a62:5e41:: with SMTP id s62mr4690842pfb.232.1551836505333;
        Tue, 05 Mar 2019 17:41:45 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id m17sm357061pff.170.2019.03.05.17.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 17:41:44 -0800 (PST)
Date:   Tue, 5 Mar 2019 17:41:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
Message-ID: <20190306014143.GA2580@dev-l>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 10:34:18AM +0900, Junio C Hamano wrote:
> * dl/merge-cleanup-scissors-fix (2019-01-27) 4 commits
>   (merged to 'next' on 2019-02-06 at f4fe5d759a)
>  + merge: add scissors line on merge conflict
>  + merge: cleanup messages like commit
>  + t7600: clean up 'merge --squash c3 with c7' test
>  + commit: extract cleanup_mode functions to sequencer
> 
>  The list of conflicted paths shown in the editor while concluding a
>  conflicted merge was shown above the scissors line when the
>  clean-up mode is set to "scissors", even though it was commented
>  out just like the list of updated paths and other information to
>  help the user explain the merge better.
> 
>  Will merge to 'master'.

I just noticed I missed some stuff with this change today. If a conflict
happens when we're doing git revert, then the cut line ends up below the
list of conflicts.

It's safe to merge to master but it'd probably be better if we keep
cooking in next until I can get the fixup patches out.
