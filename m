From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Tue, 26 Jul 2011 18:26:18 +1000
Message-ID: <CAH3Anrq=u1Ayw8UuzycdQOJZDaOot6RN-FUJMP4465R8itpMLg@mail.gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
	<4E2DBA84.3090405@kdbg.org>
	<CAH3AnrrOdduUG_rS97fR_PRZAWb6y3uPa_oKDZenEX2gG-AvAQ@mail.gmail.com>
	<m3ei1dsd1x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 10:26:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlcy9-0000V1-CW
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 10:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab1GZI0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 04:26:20 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39690 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab1GZI0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 04:26:18 -0400
Received: by vws1 with SMTP id 1so125247vws.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Rmtp57ishHuoQwytHF9QQP4Eb32L5dTBbjVq+RqgkqU=;
        b=Fd/TJyVv4Zt3p0OTd7MtNJSjQBdBc0ECUY3efSMZ5mmfTzlDtQzkOzbxAtPW+GCoYK
         QRMN+KYFes39km6Q34JqfohlvqeGICl/4JTir5fvI8Xk7lg6vsZQcZ65vs6jDZ3TuKhu
         EyqA4kDXPDZMsmFVYK7IXhRT6dGPUpaVjAMsc=
Received: by 10.52.24.77 with SMTP id s13mr5306987vdf.508.1311668778145; Tue,
 26 Jul 2011 01:26:18 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Tue, 26 Jul 2011 01:26:18 -0700 (PDT)
In-Reply-To: <m3ei1dsd1x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177847>

2011/7/26 Jakub Narebski <jnareb@gmail.com>:
> No, it is not true. =C2=A0Think of bisection as in original applicati=
on, as
> numerical methods used to find root of one dimensional function. =C2=A0=
It
> works if there is single root between starting endpoints, or rather i=
f
> endpoints have different signs.
>

Ah, yes, I see you are correct.

Sorry!

jon.
