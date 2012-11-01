From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 03:54:19 +0100
Message-ID: <CAMP44s1pvr1twFdeb5UZkarBgFZo6WUR7iqz_cZp_1vZE1sfcw@mail.gmail.com>
References: <20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<c0f8d214-4d61-4b02-8bda-4f26c33ae30f@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 03:54:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTkvR-00075p-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 03:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243Ab2KACyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 22:54:20 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60891 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814Ab2KACyT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 22:54:19 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2151338obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 19:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jySsPSUuWfqjxMfHbWutC49cCC8N1whcn1OVUbywk6U=;
        b=uPYegA+b3RF1TC9L4cnn26i48p86y4l9s+jgRVGq1vZcP/U9d9aUUA0gp8G3nSOyWI
         WU1xS4ZfxdzcbLO010Xb2KJLHEay+xYdu7hYiQkL41/t7tciWxUDGGPj3v0ZIsjiZEMo
         5P+nrMlhtNxn1jAfzD4grQMO6wAHM1kv5/jsOAeu4ZzEn+15on2g2/GmWVPPX92SQ+pf
         qroeWdH9xzsadKUJq57hhRgXjH0G0Uzrrz2cML71ntAjLib7ekPsP+EcPh+2n7+Ec67i
         aA77L+ZXyJxJ/DODSYP2UL7QZx2llrPkcs2GxLRK1bjHTPE0zTL8BeAQoTsTX00WeZ3y
         vUlw==
Received: by 10.182.52.105 with SMTP id s9mr32235568obo.25.1351738459366; Wed,
 31 Oct 2012 19:54:19 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 19:54:19 -0700 (PDT)
In-Reply-To: <c0f8d214-4d61-4b02-8bda-4f26c33ae30f@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208862>

On Thu, Nov 1, 2012 at 2:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>>Junio wanted a more general solution, adding infrastructure to the
>>rev-list engine that I did not need -- and did not see the need for,
>>either -- and given the amount of time I had invested in a working
>>remote-hg and given that I needed it desperately for my day-job
>>project, ...
>
> This is relatively long ago (and I am away from my machine, so I cannot check) so I may misremembering things, but my impression is that since that discussion, we added a minimal "infrastructure" to the rev-list (I think we caled it rev-list-cmdline or something like that) and Sverre used it to update fast-export.
>
> It may well be that what we have is still not sufficient to do everything you need, but it may be close enough to get extended for your original use case.

I don't think there's missing, the following patch works fine:
http://article.gmane.org/gmane.comp.version-control.git/208730

There's a minute issue, but I think that would require changes in
fast-export itself and its marks, not rev-list. But nobody would care
anyway, it's not a problem.

Cheers.

-- 
Felipe Contreras
