From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 14:51:51 +0200
Message-ID: <38b2ab8a0808290551i3e2c608ax88e09368582bfd99@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
	 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
	 <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
	 <fcaeb9bf0808290534w5025b436s1087bb6a0ffcb16f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 15:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ3b4-0007JS-8f
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 15:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbYH2M75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 08:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYH2M74
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 08:59:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37749 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYH2M74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 08:59:56 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1312310ugf.37
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7A/t5UdUKANxsPlxSmxuxC9lGeuKp0Z0Ah8VWM0YaEc=;
        b=bsTuvCwBTaXKXlodZqcacboGmfupYdfEoGjrQ24xLdSqMUfras0RPDyCyf83n+se9o
         oPftA8LUt2kSgTozaFIcuXy1dnE+YrUlTj0h9jLGsd5/Vk5oXWRW3znep6fZz2nW3w7/
         r/CVpCgAYxcX0xucRudP7WLvCTpGTmJBlBKgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mQkYNDvl23WM110woGrqjS6ZV2PfpqEogRS6rf6zW1LXcjp4Rg6s/6Ai+yBzelPcqj
         g3ayh8KrIKGv+PVxNHFyaMGf6z/HYmdzqS/68ZB8UZ07d39F6RCUgnLFk0bjdH3BARJn
         aFraecBnTr6HMFYDnifWNDm3/0JJJURRaOnsg=
Received: by 10.67.91.13 with SMTP id t13mr4566278ugl.11.1220014311371;
        Fri, 29 Aug 2008 05:51:51 -0700 (PDT)
Received: by 10.67.22.17 with HTTP; Fri, 29 Aug 2008 05:51:51 -0700 (PDT)
In-Reply-To: <fcaeb9bf0808290534w5025b436s1087bb6a0ffcb16f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 29, 2008 at 2:34 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> There is an old thread that uses "git symbolic-ref" or something
> instead of "echo...", it would look less hacky.

OK.

> Or you could create a new repository, make a new branch there,
> then pull that branch to your repository.

yes it's the only soultion I could come up with but I would have assumed
git-branch to be able to do that.

Thanks
-- 
Francis
