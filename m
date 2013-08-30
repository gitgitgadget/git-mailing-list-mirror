From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 13:37:46 -0500
Message-ID: <CAMP44s180h8OTXx0v7dp3WKO2=ZBF3h7nXp_CcomQFmFn1SHSw@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 20:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTZv-0004jy-QY
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab3H3Shs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:37:48 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:54829 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab3H3Shr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:37:47 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so1774612lab.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rymw6ZuykdyJkXRgYnhXPSyMGSxjVw9pq/R3fnyZp4s=;
        b=FfBebxp5VZJtWI/PWXiGOMZQYlSloEgp2tyno+xuuL8m2fxrqe2foaJV0WmXAWnttl
         droN6DdMSjj3TM3eBuyuceFop66HPQqxx9LVkV+yjbaWw8RlC59trke7lOZb4Fof8YTj
         aMlvwDm7iw00fOvMf3IJW56aTXAwa/9F1qg0PdC/BeEzhKRZFbq1kpRacUpp2qhyIvCz
         V80Jndw6bUTiYVTeviAWVnVT+ZHxj4D64cr0unvZjaydZvDOoOPYIIhpOLHCsykKwX28
         KArjwZclnk6z5GYJqrgSG8KaZnYEnlaRhgZOuH4X4rFE+EczsYmpI+J+1+pg2xg1zIGV
         MDOw==
X-Received: by 10.152.88.20 with SMTP id bc20mr2792675lab.37.1377887866312;
 Fri, 30 Aug 2013 11:37:46 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 11:37:46 -0700 (PDT)
In-Reply-To: <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233461>

On Fri, Aug 30, 2013 at 11:48 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Which means that the approach taken by the patch to only allow
> exclusion of negative ones makes the idea only 50% useful compared
> to its potential.  And I suspect that "we can start from 50% which
> is better than 0% and later fill the other 50%" would not work in
> this case, without ripping out the "SKIP on object" approach and
> redoing the "--except" support from scratch, because "SKIP on
> object" fundamentally cannot undo the effects of the negative ones,
> because it records the information at a wrong level.

I think it is not 50%, it is 98%. I think one or two persons might use
this secondary feature if ever, and I think waiting for that
implementation will delay the feature that 98% of people would use,
and maybe block it entirely.

-- 
Felipe Contreras
