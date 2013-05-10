From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 23:38:18 +0530
Message-ID: <CALkWK0kh_wKqCJff7225JyS==5okGPdPPVW2v6Dd65oe0pyVpA@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com> <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org> <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org> <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 20:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uarkf-0000AV-5l
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab3EJSJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:09:00 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:57294 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab3EJSI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:08:59 -0400
Received: by mail-ia0-f182.google.com with SMTP id j5so2729067iaf.41
        for <git@vger.kernel.org>; Fri, 10 May 2013 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1hpiTtgyi7/9Fr1+5Y1ucxH+cBaDo9AYawlBiTlxit0=;
        b=CHqkuge+voxMG7Kxd4DdyP1KCnL7G3ngRP25ziDhM1z5XsJa3dKUr9er27dJ+pSwxX
         k5N8Ya6LyiLscn6JWfdtxdVP3v4wgdmI8V8tFvoVGLCV+Ml+GRy9sTyvIXDlYcFTR1O6
         lI3+sf+mqLJB8e3XCl1b9wt99j7f0w0CSjDZfWYOJMAYSOO1x7UZYjSptX3xpCcKZKrF
         MkUKmTUgXmNUaVrWLDFG7AOFMW5xmbgupJr5m7VpBgNB++gj2xVQH1//FcsYGUSzYLFz
         /qVEGmKPY21jvIyKYmDuuoa9UsilGcebr9Ce+zge9arkibV/YwDXgxbPxUf0LaOPUbIA
         5/Vw==
X-Received: by 10.50.66.140 with SMTP id f12mr2794208igt.63.1368209338768;
 Fri, 10 May 2013 11:08:58 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 11:08:18 -0700 (PDT)
In-Reply-To: <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223888>

Ramkumar Ramachandra wrote:
> I just comment out the test_expect_success and close-quote, and put a
> test_done after it.  I would never advocate this GIT_TRACE thing
> anywhere, because I want to put GIT_TRACE=1 (and possibly other
> modifications) where I want it.  Locally.

On that note, I'd really like a switch that runs until the first
failing test and re-runs just that failing test with -v.
