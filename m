From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: Re: [PATCH] Allow "clone --dissociate" to dissociate from alternates
Date: Wed, 21 Oct 2015 10:13:22 +0200
Message-ID: <56274922.80007@cetitec.com>
References: <561F8DE9.4040703@cetitec.com> <alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info> <561FBA48.3050609@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 10:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZooWi-0006Fy-TH
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 10:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbbJUINg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 04:13:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49407 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbJUINd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 04:13:33 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue003) with ESMTPSA (Nemesis) id
 0LwmRY-1adWUn3axs-016Oar; Wed, 21 Oct 2015 10:13:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id D6E94B00F1A;
	Wed, 21 Oct 2015 10:13:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9e6+-uYsr-hr; Wed, 21 Oct 2015 10:13:23 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id 046C1B00935;
	Wed, 21 Oct 2015 10:13:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <561FBA48.3050609@cetitec.com>
X-Provags-ID: V03:K0:+6DGZSe3doWfLPJ43VYdEjqWw+vhd0ysrGwLfJPbQpVnd4XZ97H
 spK7NOW531v8bFY4VniZPuE0u2/TNqiT2KvxYgad76H5xshpvY4x2isttdcOwDvfi+h5+Gg
 iYF/xpRxRO4cFYllTuH6t1ocn2Y3Awu07v9hay8n+e0cGYkqDUA5c7N798a23cqi3c89zRT
 nF9WUw+jKjHklglLdAh/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fPQdna+aSSI=:MaDwfOiKr1e2Sbzr4iCZsu
 GhJcFxLFe2u/lfoUUd+j5ea3NOAHjlNJ9PKKbdxMxSAaY54L+wh732l6tYw3DteH4OqR92Wqr
 Hk79REGKc4xeGaw3tSttirvArnQjUW/JqMCYxjuscqqifx32y65H2XclWlMS7GqjHCyYPHi7v
 yY3CjAfaMa3RFMBAHkk8NA3/Hb88q86l2BRl6G8s4+1lM8QJql/AhNCVW7YuQfPShsMWxlR/u
 2oIJJee2yRrAynFrGlmDcLJWHC9YaLy4nRCk6HBNQUPx49OBsJtgfvhQ20o6ztjFuQ9IPHNiY
 4lE+qV4VA9tDy5A5VaU0ryCJIu6EaBD5pr+BstATrzNbRro3s3W1EWPPDsrx5Lc9EGUqADMcz
 inz4lZYXM7Zudt+26Q5h/roGVKhE/EE3WU2PKC756btd14EF5V8L15qWDFK0SsyHBd6/D2/Mq
 5+0Bqu5dLmCxiyccrHCh10dDZgHWFGco3sLZrDYERZZ6tbBEsQ93rVR+YrrJMR59wgx+4Dib4
 4n6I7WmmQ7r1rKOnHwnEn88kUyRYkNuGEXuITx6uxnsrfh1a2VDVGdFd1T7uVNehdNH6b/3CV
 lJ72fp8VzolHLpRBN3qf9gwUcG+xIJaGtSRtcVwfmyub7Ni8M2SU/2lqLF2uPsoGUz5O2YvdN
 nK2exMxX2BR1Qx/8nwdqzZDir8GGXDNVUUBQzoqosmc53nQ0dw2mM0dg7/dVz4N/gAF8c/lcI
 84+k9c1U7GkBJOA3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279975>

Reminder. Is this (or rather the one I'm replying to) patch a better option?

Regards,
Alex

On 10/15/2015 04:38 PM, Alexander Riesen wrote:
> The option requiring the explicit reference repositories is a bit of overkill:
> the alternates in the original repository *are* reference repositories and
> would be dissociated from should one pass any reference repository (even an
> unrelated one).
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> On 10/15/2015 04:11 PM, Johannes Schindelin wrote:
>> On Thu, 15 Oct 2015, Alexander  Riesen wrote:
> >
> >> The "--dissociate" option required reference repositories, which sometimes
> >> demanded a look into the objects/info/alternates by the user. As this
> >> is something which can be figured out automatically, do it in the
> >> clone unless there is no other reference repositories.
> >
> > Would it not make sense to reuse the copy_alternates() function to simply
> > copy the alternates and let `--dissociate` run its course with the copied
> > .objects/info/alternate file? That would make for less new code...
>
> IIUC, I should validate the alternates in the source repository...
> But, the only thing the user looses if it is not validated, is the nice
> warning regarding no reference repositories to dissociate from, right?
>
> So maybe we can just remove the reset of option_dissociate and be done with
> it? I would actually suggest removing the warning as well: the alternates are
> something to dissociate from. And I see no harm otherwise.
>
> How about this instead?
>
