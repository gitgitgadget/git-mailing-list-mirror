From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] config.txt: Clarify allowTipSHA1InWant with camelCase
Date: Tue, 12 May 2015 14:35:51 -0700
Message-ID: <xmqqr3qleax4.fsf@gitster.dls.corp.google.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
	<1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:37:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHrU-00046H-Pr
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbbELVfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:35:55 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36034 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbbELVfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:35:53 -0400
Received: by igbpi8 with SMTP id pi8so121620658igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=L2lqrULA6+kqjiuYdRi2etAuf+eZD3SGRP7JntVWu7c=;
        b=FN8noei1fagaJ9UsgPVINCCpEGpDPM7EJ2/ggWXPY4LSC+P5bWddH6+cAxvliSRiTV
         aPja1JmQSsgXsNPKzZwR0IxibIBM0VFECj2vD1u83l/jGuMVXQiwxp9tcTBgBV3IVcad
         byLXgmTaOMKksfPYl8Knt8/gchyVYslSXNi6hCs48ODy3T7yW8qoDmgX+4RvrXTIdnNV
         fW/9dMTXZcx9xdWo0pw2rlmjd/mF5nF4oHPb8pxexn/6OMyl26QBkIJ4YnLTZtn4t4Z/
         kPgw3AZcCeAs2IVgfFkRibMvCYojc6EH1EE/XcDPRwbACkTsfTnL9iI6phCUi3+zU/h1
         a1nQ==
X-Received: by 10.43.59.80 with SMTP id wn16mr5439360icb.40.1431466552711;
        Tue, 12 May 2015 14:35:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id cy11sm2061225igc.14.2015.05.12.14.35.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:35:52 -0700 (PDT)
In-Reply-To: <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Tue, 12 May 2015 23:14:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268891>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> Subject: Re: [PATCH 1/3] config.txt: Clarify allowTipSHA1InWant with camelCase

s/: Clarify/: clarify/;

> Most of the options in config.txt are camelCase. Improve the readability
> for allowtipsha1inwant by changing to allowTipSHA1InWant.

Sign-off?

> ---
>  Documentation/config.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..2b86fe6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2530,9 +2530,9 @@ uploadpack.hideRefs::
>  	are under the hierarchies listed on the value of this
>  	variable is excluded, and is hidden from `git ls-remote`,
>  	`git fetch`, etc.  An attempt to fetch a hidden ref by `git
> -	fetch` will fail.  See also `uploadpack.allowtipsha1inwant`.
> +	fetch` will fail.  See also `uploadpack.allowTipSHA1InWant`.
>  
> -uploadpack.allowtipsha1inwant::
> +uploadpack.allowTipSHA1InWant::
>  	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
>  	to accept a fetch request that asks for an object at the tip
>  	of a hidden ref (by default, such a request is rejected).
