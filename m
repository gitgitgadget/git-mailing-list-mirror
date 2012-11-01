From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 03:50:19 +0100
Message-ID: <CAMP44s3AOT4+Zz+CgZD7VXTGhKVQac+w0XQ8_VKzsi-ZGmo+fg@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<16b87432-2862-4be9-afea-5b672101af62@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 03:50:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTkrZ-0001eL-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 03:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab2KACuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 22:50:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34604 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab2KACuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 22:50:20 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2149474obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 19:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dRxTKfuj0xra7Q1zS6DlroRZHyn+CkDJTg9z2N+71Bs=;
        b=06zALnEBPu+p4bfrjNlKUuTpSKtIRtU+CYvTXwhb39dwsJ9ccK/AMI0Von5VG5P8eh
         LEjo2dubHoqNkIROVvs2OyZUgSnW2IzhAHXegTFMdNden9pxp4/CH9hZMUrq73EhrVLk
         R43lvkp3R2Yf90SrSGKsQLUEAvjdLNR1tliy4VLWpx4u6pCm8BQmPhiQYpoCBxaui4Oz
         eKqfMICyGnyLfb35gYhhkj11n5XQL0KjRo1QzBQ6V9ji5qPKbH5ZmCraZacRpVPWzj6e
         h78tDCaquW0d3fy96ttWnKIK9PmP5x1tOr0mLQ1Bycz7JK9JNLiZ6HwF3mYpOOmxqZI8
         CSfQ==
Received: by 10.182.245.20 with SMTP id xk20mr32263151obc.89.1351738219601;
 Wed, 31 Oct 2012 19:50:19 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 19:50:19 -0700 (PDT)
In-Reply-To: <16b87432-2862-4be9-afea-5b672101af62@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208861>

On Thu, Nov 1, 2012 at 2:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
>>And finally, what do more do you expect me to do? About the code, and
>>only the code.
>
> The analysis that does in the log messages is an important part of "code" in this project, so that may be a good place to start. Both Jonathan and J6t asked specific updates to your log message, no?

Regarding git-remote-hg? No. They haven't said anything about any of
those patches.

-- 
Felipe Contreras
