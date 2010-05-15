From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6 v2] Make test-lib.sh emit valid TAP format
Date: Sat, 15 May 2010 19:37:04 +0000
Message-ID: <AANLkTin4HbCtv9OZi_emCKad3C4LQztwQIK4CNkfbN5Q@mail.gmail.com>
References: <AANLkTinitdHqD2-viSB2jnS6jONWQQZznp1V0JW934CN@mail.gmail.com>
	 <1273265950-9981-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 21:37:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODNAn-0008UC-E2
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 21:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab0EOThI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 15:37:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56301 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0EOThH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 15:37:07 -0400
Received: by fxm6 with SMTP id 6so2530593fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bj/1ipCfC8nt89FKqGjrvmss6mJA7jNjE2Dq8SikrvY=;
        b=Oj9A4nTfy4nLzqTOA4C0uoMPKAAAbj9VUwU8DzOMNfsJslVU6DW360E6p9qchu68TY
         0WliBiTE1xia2iovOVB45OOPaFBCJw9unFXxiJ4keZQkCmNUyseReXzX1GTIpjrPZMbh
         Q0zqtHF6EI2XToEUteU2DPsIRa6CunoRMvtDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K0IZA248tYBRZRP1dyv45dygy9unhgjcAs35QduXJ2co0TMDJygaywL+pU+Li1SpOc
         QrmEOly+9q/qdN9NsYt3cZN6n130kinjaJjZjEDX1+efzLjp7nBogWS3djCngbxCZkKv
         ucq33YW6FM2fuTDX1uHdyTK6XhG7iVkZtjxvE=
Received: by 10.223.63.76 with SMTP id a12mr3708643fai.10.1273952224771; Sat, 
	15 May 2010 12:37:04 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Sat, 15 May 2010 12:37:04 -0700 (PDT)
In-Reply-To: <1273265950-9981-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147159>

On Fri, May 7, 2010 at 20:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Here's that patch. It now also has examples of the test output
> before/after and a demonstration of prove(1) running on a test.

Is there something I can do to make this more acceptable for
inclusion, or is it OK as-is?
