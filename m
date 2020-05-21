Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B5EC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047772078B
	for <git@archiver.kernel.org>; Thu, 21 May 2020 13:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgEUNBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 09:01:00 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54591 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgEUNA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 09:00:59 -0400
Received: from localhost (unknown [42.109.204.137])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8374B200004;
        Thu, 21 May 2020 13:00:54 +0000 (UTC)
Date:   Thu, 21 May 2020 18:30:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] git-gui: Handle Ctrl + BS/Del in the commit msg
Message-ID: <20200521130046.g4qwvyobllaj6xxx@yadavpratyush.com>
References: <20200512102806.GA20813@abuya.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512102806.GA20813@abuya.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/20 12:28PM, Ismael Luceno wrote:
> From: Ismael Luceno <ismael.luceno@tttech-auto.com>
> 
> - Control+BackSpace: Delete word to the left of the cursor.
> - Control+Delete   : Delete word to the right of the cursor.
> 
> Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
> they were adopted by most CUA-Compliant UIs, including those of: OS/2,
> Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.
> 
> In both cases Tk already implements the functionality bound to other key
> combination, so we use that.
> 
> Graphical examples:
> 
> Deleting to the left:
>         v------ pointer
> X_WORD____X
>   ^-----^------ selection
> 
> Deleting to the right:
>   v--------- pointer
> X_WORD_X
>   ^--^------ selection
> 
> Signed-off-by: Ismael Luceno <ismael.luceno@tttech-auto.com>

Merged to git-gui/master.
 

-- 
Regards,
Pratyush Yadav
