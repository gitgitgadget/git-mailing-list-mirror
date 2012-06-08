From: Simon Perrat <simon.perrat@ensimag.imag.fr>
Subject: Re: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Fri, 8 Jun 2012 11:04:00 +0200
Message-ID: <CA+hdvHhPf-p0N36fXH6Spd-svQ2i1sU7Wc9g7T17Gh8dnA2T6Q@mail.gmail.com>
References: <4FCE07A5.9020001@ensimag.imag.fr> <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr>
 <vpqobow8a9l.fsf@bauges.imag.fr> <4FD1B209.702@ensimag.imag.fr> <vpqboku18qk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon.Cathebras@ensimag.imag.fr, git@vger.kernel.org,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, peff@peff.net, gitster@pobox.com,
	Charles Roussel <charles.roussel@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:04:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scv7K-0001D6-5c
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933973Ab2FHJEW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 05:04:22 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62461 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075Ab2FHJEV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 05:04:21 -0400
Received: by ghrr11 with SMTP id r11so1066382ghr.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=66Z28X2ZA0xqqpj3eQwb7LkQ280oIGEkY/6AR2NvpME=;
        b=r2UZyIZR6bFqQ9vE3fFtXZjyobazP9o8EYsgmXQP72Dvlukcw84hTymazXkG4P/9vi
         OYJsAA6Ag7fRVe+ucBTS3UAo9uFQrJnyu4/HokplNvJVoozVmWEuKoYhPVzE3d/+O0tu
         ujC+jculCmtD95WiBvjK1mPv0VQAN6eiqVZmZQjm1QlZAoDfqzys5zQJk/ES9YUPQJwL
         rWsY/dct3bsEDanaM7YIrT2G0s+P85mipUdCDqE3Voi2mhzC9TrO73BGTA3kNTizNgCh
         TXyzRNagDbZ5/h4tnOwyUH6WPgks2V5WnRggY4qSccz7ji4HWP+QCOKzg1HiPZAMIjsM
         1TEQ==
Received: by 10.60.29.169 with SMTP id l9mr5388712oeh.14.1339146260377; Fri,
 08 Jun 2012 02:04:20 -0700 (PDT)
Received: by 10.60.169.107 with HTTP; Fri, 8 Jun 2012 02:04:00 -0700 (PDT)
In-Reply-To: <vpqboku18qk.fsf@bauges.imag.fr>
X-Google-Sender-Auth: MXAjLFzWbfcUPkN9NlTTaw_Od7o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199474>

2012/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>
> "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:
> > Do you mean that we should split the third patch into two patches ?
> > For instance::
> > =A0 =A0 Patch 3/4: tests for git pull
> > =A0 =A0 Patch 4/4: tests for git push
>
> Yes, except the title should mention git-remote-mediawiki, of course.
>

Should we split our test file in two then ? Currently they're all in t9=
361.
