From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fix t5000-tar-tree.sh when $TAR isn't set
Date: Tue, 8 Nov 2005 16:08:18 +0100
Message-ID: <81b0412b0511080708g57f869ccl1ba2aeb80b26ce54@mail.gmail.com>
References: <81b0412b0511080245m12ed5fe0ha0ed98ca25e2f6e9@mail.gmail.com>
	 <Pine.LNX.4.63.0511081250020.2649@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 16:12:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZV5D-0005I6-37
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 16:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVKHPIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 10:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKHPIU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 10:08:20 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:65357 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965005AbVKHPIT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 10:08:19 -0500
Received: by nproxy.gmail.com with SMTP id q29so170054nfc
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 07:08:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQTCFWJ/FOCcR3sA5ykb73jx1Z43TreX0T4aM2vCaiF0foq+K/Eb3V+lRsNuIAOGAVZGDfvfatRzHyG1ZJrKnpgwpsrDy1F5PM05rQU/WnWcxXnTDQc8jnbHu5DrWKAFuku0UbAHvpJHpaqaRfMA4qWssH25GYym3kODRspIj7o=
Received: by 10.48.226.12 with SMTP id y12mr2001460nfg;
        Tue, 08 Nov 2005 07:08:18 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 8 Nov 2005 07:08:18 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511081250020.2649@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11332>

On 11/8/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > $TAR isn't set everywhere. Provide a default (tar)
>
> You run "sh t5000*" in t/, right? Usually, TAR is set in t/Makefile (that
> is why it Just Works in the normal case). Note that you can -- instead of
> your patch -- run "TAR=tar sh t5000*".

Oh, I see... I did "make -C t" to avoid recompilation tests (this is
unbearably slow on the system Not To Be Named). Maybe put such
variables in the separate makefile and include it?
