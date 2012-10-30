From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 23:22:44 +0100
Message-ID: <CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
	<CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
	<CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
	<20121030214531.GN15167@elie.Belkin>
	<CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
	<20121030220717.GO15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKD5-0008E0-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab2J3WWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:22:46 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33266 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab2J3WWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:22:45 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so810983oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sZszVZ+3eJukfpzjyVjwGSoWqM9gJ4BdOAfpuyi4bo0=;
        b=v+pZcM3DArUvHB4oKwweR6S6w2CiIbR/HuxoAYzfKkTbhg6uX4WIeoT/X6s2mGXaLv
         FeAXADc1fkkm6DXVmOwZLrSoG18jzZRg46NnVegPJgcZPdTP2yJg8JjRszewUPC+lYW9
         t11oqErMQ72adIMopBmG8B7Aszsuug9hEmOnnec4BEpHIo/GQrsYA1W7QwVsgLNKmh5q
         vzYZFx0WWGUY1qKlC0S3CpPEsRDxi/0ixuosjcpchWDTRVdeckJIrYpwS62hn7itnqHX
         44em5u2KfqtN3smbhwwVpCXUaqLGthW380dKq5BZNRWPxcvGLP4r8QnA0Zc0LxQbqlpi
         lXXQ==
Received: by 10.182.116.6 with SMTP id js6mr28607446obb.82.1351635764732; Tue,
 30 Oct 2012 15:22:44 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 15:22:44 -0700 (PDT)
In-Reply-To: <20121030220717.GO15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208761>

On Tue, Oct 30, 2012 at 11:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> Well, that's what we have now, and you want to preserve this "feature"
>> (aka bug), right?
>
> Nope.  I just don't want regressions, and found a patch description
> that did nothing to explain to the reader how it avoids regressions
> more than a little disturbing.

I see, so you don't have any specific case where this could cause
regressions, you are just saying it _might_ (like all patches).

> I also think the proposed behavior is wrong.

That's a different matter, lets see what others think.

-- 
Felipe Contreras
