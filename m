From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Thu, 3 Dec 2015 17:35:08 +0100
Message-ID: <CAP8UFD1cbogcojkY1ywTO=+cRb3mFB-d0W5MG4D_1K2vAx2=aw@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
	<1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
	<565E99F9.2020906@web.de>
	<CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
	<5660697D.5090308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 03 17:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Wql-0005mu-89
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 17:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbbLCQfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 11:35:11 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34927 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbbLCQfK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 11:35:10 -0500
Received: by lbcdv4 with SMTP id dv4so4986281lbc.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2004y0AEIeh9jvAhmAfo/sja5zqiqazG15lpcJwFLRg=;
        b=WgPq2cvMdwBZvf7PpddmPm2uy+r4EkNsSIK7eMYcyV4024TLnxqdgedI6NRkKRS3A2
         JnPGkjCSaOoNadO7O69AybcOOOHZynhqFEZpU+iCwAyKW+cCzhx/c3gsBAMFAOQclxAq
         8qCeRcNa5L2eQgJEQZPTIcaXhdrJvh1VEtFcUVSmYgB+g+N6h49XlaBijl5xMGJjS5YK
         lo3kSirqXRCGb+Xy3KPgZ6T2ZJ7Xi22HzkrP4r/dZ+ZNXhZcV5JDb5p9LZURl+LEopG7
         CMtOzqvjAg875/9fBR8jaeP/2/z/JSChzTpTNNjozStDNBKnpzmvhE3aX0jZc3OzW9w1
         aj4w==
X-Received: by 10.112.184.45 with SMTP id er13mr5782475lbc.133.1449160508392;
 Thu, 03 Dec 2015 08:35:08 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 3 Dec 2015 08:35:08 -0800 (PST)
In-Reply-To: <5660697D.5090308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281957>

On Thu, Dec 3, 2015 at 5:10 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> [snip all good stuff]
>
> First of all:
> Thanks for explaining it so well
>
> I now can see the point in having this patch.
> (Do the commit messages reflect all this ? I need to re-read)

Maybe not. I will have a look at improving them, but your re-reading is=
 welcome.

> The other question is: Do you have patch on a public repo ?

Yes, here: https://github.com/chriscool/git/commits/uc-notifs8

> And, of course, can we add 1 or 2 test cases ?

Yes I had planned to add tests for this.
But it would be nice if I could know first if the last two patches are
considered ok even though they are breaking compatibility a bit.
In this case I could squash them with previous patches and only write
tests for the resulting patches.

> Thanks for pushing this forward.

Thanks for your reviews,
Christian.
