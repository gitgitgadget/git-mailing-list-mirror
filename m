From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 22:40:12 +0100
Message-ID: <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
	<CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:40:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJXw-0005F7-FL
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934736Ab2J3VkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:40:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43508 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934731Ab2J3VkM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:40:12 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so773632obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5RvRbB1blrG2xY1ea+omhIxUqhw/A5bhzlZ2lU+8CQw=;
        b=pfTaXipheeReL/4wgSQpgcRxVzoi1TyQfzyl2vjfp3Hx4zMK6L+QlwzFce1VVa8k8N
         FiM0MktaYHu3Q41U0Bd4hTMuYA1APAkbBtPxfXItcyhHaaR/5XlLsRPtB01RSfhKBcCO
         M3FA+IEIclp3lwnqolSYhNyo69cjehejP9xbGe8R9Zu+JJ7og1SBthtCNuFYYA308I+i
         bNM6+knMddIIeKx6fauVnTk6ee3E8Be6ILL10UnDGVVwiFEWGdxPzdYCLwrieuJv0may
         flmHNIoWQrTXsMJASScyLhAGINspNnDRUvZbBm2IlM87OWOT+ol5INcV5IQR4q4AYfI8
         2dsw==
Received: by 10.60.31.241 with SMTP id d17mr29824130oei.107.1351633212240;
 Tue, 30 Oct 2012 14:40:12 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 14:40:12 -0700 (PDT)
In-Reply-To: <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208747>

On Tue, Oct 30, 2012 at 8:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Tue, Oct 30, 2012 at 7:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> and in the examples listed in the patch
>>> description the changed behavior does not look like an improvement.
>>
>> I disagree.
>>
>> % git log master ^master
>>
>> What do you expect? Nothing.
>
> Yep.
>
>> % git fast-export master ^master
>>
>> What do you expect? Nothing.

So you think what we have now is the correct behavior:

% git fast-export master ^master
reset refs/heads/master
from :0

That of course would crash fast-import. But hey, it's your opinion.

Would be interesting to see if other people think the above is correct.

Cheers.

-- 
Felipe Contreras
