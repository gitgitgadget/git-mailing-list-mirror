From: Brandon Turner <bt@brandonturner.net>
Subject: Re: [PATCH v4] completion: ignore chpwd_functions when cding on zsh
Date: Thu, 9 Oct 2014 17:04:10 -0500
Message-ID: <CAMUzdX=SmeEFmxd_LPPaB9qkwqXfkiC=CU7DnMf_gR=007xcbQ@mail.gmail.com>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
	<1412881298-64117-1-git-send-email-bt@brandonturner.net>
	<xmqqk34955we.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 00:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcLol-0006a4-TV
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 00:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbaJIWEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 18:04:12 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:50029 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaJIWEL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 18:04:11 -0400
Received: by mail-ig0-f177.google.com with SMTP id a13so402836igq.16
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TuEKteL28i76Oj/ORqb8FGNUAJSHwIfeYYrmh65gjsM=;
        b=YVbo07qGQFz2iExfFMUjGHglGmR3Cys69PbAmvasKBtKllNRxpcgwZM1doTuA8hRiL
         4lSY0+I1Tqi6FqxqBBnSvCNrjn0fXFw2StZczg+pmehHg1tPET9KpW4xvtw2GRfQacIT
         Fyr3eVS60n51TGhFAFv61B2XljY4TsbyRyqLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TuEKteL28i76Oj/ORqb8FGNUAJSHwIfeYYrmh65gjsM=;
        b=iWpB0gqPQkzJ0wNX/65SNbgxTtM85QK7ncWspuHD3AJygC5+PRl20rjkfUKmXAeqWK
         XdWzV7CZttvrFU/xq6vgcINqtHayLr+BiuIVcBhMsaM+00A3ueSI8MKeVPZa5V7/f74p
         tTBikrjjPpLiG/crCMzDrfGHT7rTrMx3d1e0oDMm3RVVuoGgzKbMvdIsyEZnV4X6xzs6
         FR++HByqeM1xzJ4aBW6MCqujskW1GMdft6cA3wAd4OPO3jd4u9yc/DHtylJznlWWFwGO
         Q6+urMeG+6xX3ZDbhtCAdi34lxeK3EocCbG9uAcYRbrtRWr8D8OCn3W2D4fLrOEFsRyp
         Sk/w==
X-Gm-Message-State: ALoCoQm5zP5xldqQVYicRDjlyRbguyus2yG7AyMSL2VIWtoSgb/ib9NXtdAsz0tFUFCmEJEXRt5p
X-Received: by 10.42.203.4 with SMTP id fg4mr11286987icb.74.1412892250153;
 Thu, 09 Oct 2014 15:04:10 -0700 (PDT)
Received: by 10.64.230.66 with HTTP; Thu, 9 Oct 2014 15:04:10 -0700 (PDT)
X-Originating-IP: [128.177.65.10]
In-Reply-To: <xmqqk34955we.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 9, 2014 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Bugs are mine; as I do not use zsh myself, some testing is very much
> appreciated.

I've tested this patch in zsh and it fixes the original problem.  I've
also tested various scenarios in bash and zsh (CDPATH set, different
places within repos, etc.) and see no problems.

Thanks for all of the help Junio and =C3=98ystein.
