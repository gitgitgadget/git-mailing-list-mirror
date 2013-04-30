From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 01:11:32 -0500
Message-ID: <CAMP44s3zWLnXeBH2CsjDU=jXLAXMcMDSJgW9Qin=jKJrfO_2gQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8Af5Z6DzsAchu2MpMeanTEJiF-DwhdPMGE9n6QKf2K6Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3mt-0005RU-2P
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab3D3GLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 02:11:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62433 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3D3GLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 02:11:34 -0400
Received: by mail-lb0-f174.google.com with SMTP id t11so206357lbd.33
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UKVZZjgBhDbGB52B85K+4B5CSOUm7869OkbnoOb2j3I=;
        b=o32Bd8sWY2LuLLJIfFPo2U4xeVgkHi0suy8CivnmGSpy31r/kqAKKJCduDeFoKS4pC
         4LKJX6U9S160IpuwNvSGuEcEiuOJdMfSWi9XD1I8l9u5NbLrbxY/On/APzxQKKFkqRle
         p7RphUZsqcJpO8Jxe/81meH7GjqEm+oB2EQIfu4R7ueboyHIe1rffmWX8FcveiHsaG8/
         RwA1sQ1qlmJQm32PX9C9ZLiOkQ1F4pxX06l5+NW09B7c/FPZmq40PSSvGXKB3JHADfXC
         SzMuNZgGUZTmbtbb+wesIFtToV5Ytzny4QHTZlbMZq4i9hkr/YiEjVIOb05jfT2v5FvU
         nFkw==
X-Received: by 10.112.163.6 with SMTP id ye6mr27857451lbb.59.1367302292715;
 Mon, 29 Apr 2013 23:11:32 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 23:11:32 -0700 (PDT)
In-Reply-To: <CACsJy8Af5Z6DzsAchu2MpMeanTEJiF-DwhdPMGE9n6QKf2K6Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222911>

On Tue, Apr 30, 2013 at 1:07 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?
>>
>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>> 'master@'.
>>
>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>> use 'git show @~1', and all that goody goodness.
>
> This patch also allows funny things like @{-1}@ (wanted to try the
> cute syntax @{u}@ but too lazy to setup upstream)

Yeah, I thought about that, and I thought it was harmless. Specially
considering that doing anything else would be less elegant code-wise.

Cheers.

-- 
Felipe Contreras
