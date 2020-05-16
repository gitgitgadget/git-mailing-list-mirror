Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26C5C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0782065C
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="W/65uNrr";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="W/65uNrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEPRa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 13:30:56 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:34314 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgEPRaz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 13:30:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 920DC40591;
        Sat, 16 May 2020 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589650253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDRqAdnVMONvUK6j2EwH/xgCD0j3FHbKrJUXrTy4PSk=;
        b=W/65uNrr1sdKwInWKu+6lbz5wXx4EjcFrsq2NZwvY6L2WcF6s3JELiek5MAgEawIEH5qOa
        SRcehEdGpyzIR4pjUckOR62LwLp7hFjswuC/JP/hIWEgYbX/ddBp3bxQ6c5k7SADIFwGFu
        Jbbb7pxHssnO3FTOoANssAngqggy3Z0=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 287063FDD6;
        Sat, 16 May 2020 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589650253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDRqAdnVMONvUK6j2EwH/xgCD0j3FHbKrJUXrTy4PSk=;
        b=W/65uNrr1sdKwInWKu+6lbz5wXx4EjcFrsq2NZwvY6L2WcF6s3JELiek5MAgEawIEH5qOa
        SRcehEdGpyzIR4pjUckOR62LwLp7hFjswuC/JP/hIWEgYbX/ddBp3bxQ6c5k7SADIFwGFu
        Jbbb7pxHssnO3FTOoANssAngqggy3Z0=
Date:   Sat, 16 May 2020 19:30:52 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: add config option relative
Message-ID: <20200516173052.GA29974@spk-laptop>
References: <20200515155706.GA1165062@spk-laptop>
 <baa06609-11fe-28e7-2b8b-8590b9e37104@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa06609-11fe-28e7-2b8b-8590b9e37104@iee.email>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, May 15, 2020 at 11:22:53PM +0100, Philip Oakley wrote:
> On 15/05/2020 16:57, Laurent Arnoud wrote:
> > +diff.relative::
> > +	If set to "true", 'git diff' does not show changes outside of the directory
> > +	and show pathnames relative.
> 
> This last part sounded stilted. Maybe "and shows pathnames relative to
> the current directory", assuming I've understood what it was meant to
> say (and possible the same change in the commit message)

Yes that what it was meant by this, I will submit a patch with your suggestion

Cheers

-- 
Laurent
