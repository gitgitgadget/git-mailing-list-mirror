From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to
 and --bcc
Date: Tue, 18 Jun 2013 16:28:50 +0530
Message-ID: <CALkWK0nqQt9mP95NKnyucdAxXekj+OFsp5XsF8wXxoCRjLNbvg@mail.gmail.com>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
 <CALkWK0=vytkxM3yzVaed+i3Q+RpvH=tSLndf=vUmiYC=sn=nFg@mail.gmail.com> <0ad4bd4930efddcbaa5ed958c6758894@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, git@vger.kernel.org,
	gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UotdU-00080l-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab3FRK7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:59:31 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:49153 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3FRK7a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 06:59:30 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so9519281ieb.38
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tJ/m6/OK7iIY2g4f/4d0igxaC1HmL+4XmpuO4CVNwqg=;
        b=iwd63nmTzZdu7xh0eIunFLnMCwSrpua5uEsknth7FnLBHPKxemcxCIrW2dBj3dk/T1
         kqYgokXoAoMHKOAXfYaOjYgk2EKFIHjFZGLWDMvwMCIMccyCM+0CopgF/Yr2dFZbjXqc
         ZqjWoXSIahv4PkTxiySNXWCDFwCMMrjufVGo4+321mBzFCzmsaQRXaJyZjyJpiAwRbXg
         GB/mXwAxgQdcPa8OREM9GJV2N3XmYg0LrDNDrlwthkWp3W3npsLITPoMCR/JtLPtTGHs
         kvPttlOXDmDSDgpZQTDHAg5k9MocgFow2GSFy+PSCQvUIce/e0wARr3Htkj0AohrFzBR
         O+gg==
X-Received: by 10.50.3.37 with SMTP id 5mr7288111igz.0.1371553170291; Tue, 18
 Jun 2013 03:59:30 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 03:58:50 -0700 (PDT)
In-Reply-To: <0ad4bd4930efddcbaa5ed958c6758894@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228195>

Mathieu Li=C3=A9nard--Mayor wrote:
> Shouldn't
>
> $ git send-email --cc 'foo@example.com' --cc 'bar@example.com'
>
> and
>
> $ git send-email --cc 'foo@example.com, bar@example.com'
>
> have the exact same effect ?

Ah.  Perhaps it would be clearer to check the headers directly like in
the other tests?
