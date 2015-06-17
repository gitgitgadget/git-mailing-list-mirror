From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] pull.c: fix some sparse warnings
Date: Wed, 17 Jun 2015 18:32:56 +0800
Message-ID: <CACRoPnRWkjvLLNSdMOia6-ncWxhoGU9qUf01pRa8fquSxM=2Bg@mail.gmail.com>
References: <5580AEE1.6090300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5AeV-0003JY-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 12:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbbFQKc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 06:32:59 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36144 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbFQKc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 06:32:57 -0400
Received: by lacny3 with SMTP id ny3so29724137lac.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Hbz92sqI8F6FV3g831dTU7JQyuyLOWj2/XPpnBfjz+w=;
        b=ZeWtjrYdQSg1AknfrJWPfG8ny+Cjc44dZKr9ek4RZT1dODC0kWuyjL7P0921tOYh05
         GcwxP6RZNlUty+oHaBNLLvwTnkMbwUUsgJJg2/iRNf0DyS9hSUDNUQBYAjP2l1N0WDKM
         LKBr6oFN+GE7NSsUcFgbwF56SWZmZLP9l3MIj6Gz+nstr+hmA+XDUQCRC0onL98Cah9C
         gKyguGRC2j4EKcNXx53MbFHibvmHCbhZB8vUwm3uAONROAkEEgcCBAn3xynkn3nxU8ky
         AfoHApqhVtwDhbdkcPzfAtQIstlyDMb3JT2nqLvjVs/drUXOiE300RgN9hy3IPtpb+ho
         6wQA==
X-Received: by 10.112.93.230 with SMTP id cx6mr7050873lbb.65.1434537176154;
 Wed, 17 Jun 2015 03:32:56 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 17 Jun 2015 03:32:56 -0700 (PDT)
In-Reply-To: <5580AEE1.6090300@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271827>

On Wed, Jun 17, 2015 at 7:18 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Hi Paul,
>
> If you need to re-roll your patches on the 'pt/pull-builtin' branch,
> could you please squash this into the patch which corresponds to
> commit 191241e5.

Thanks. I must have been half-asleep because the block of code just
above uses NULL instead of 0. ><

Regards,
Paul
