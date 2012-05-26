From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH WIP 0/3] top-level gitignore considered less harmful
Date: Sat, 26 May 2012 20:25:54 +0700
Message-ID: <CACsJy8Bbn3hSDC_LmFtOXfJZhV9SqStwSSXFwcQLjDyUUAjOpQ@mail.gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 15:26:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYH0p-0003XA-4b
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 15:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab2EZN01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 09:26:27 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53394 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2EZN00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 09:26:26 -0400
Received: by wibhn6 with SMTP id hn6so388308wib.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L0liUxWssErnECD7DZbJ/Jy7FkSvAbkU4BysSeihbb4=;
        b=gwtbZgx22S27VjpfPPaVuCjY7TKK2HMXohNmqkPmTZhOMwHWNxgINYgG3JaGyRgPNr
         q5TTIoX5PaOvPU+MpSUR31fEZO4R8BS6hk2UZz8PsfFsdqL9fTgGzqumVPiNsSUUR8fK
         LPzQb9W425bu0KbD4teywaB64XywJa/czx7VoqiXn83RRvtUs0XgJ8w/TQKhND96FmBV
         pSqoWyJ/km0MUOLd0WL8EHRr4QBfZG46Ad2OXe3AT7l0358/CewLhIqHX3bpU8t+mjwf
         7ybf0lqMiadCkfBPT+YThyPShvugQn79tGEjt8eDFnxUdjc7rtKBrc04y2cDA/7GYB1U
         Rw9Q==
Received: by 10.180.97.3 with SMTP id dw3mr3562503wib.19.1338038785118; Sat,
 26 May 2012 06:26:25 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 26 May 2012 06:25:54 -0700 (PDT)
In-Reply-To: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198561>

On Sat, May 26, 2012 at 7:31 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The result is not so impressive (i'm on -O0 though). Old webkit.git,
> before:

(it's "git status" by the way)

>
> real =C2=A0 =C2=A00m6.418s
> user =C2=A0 =C2=A00m5.561s
> sys =C2=A0 =C2=A0 0m0.827s
>
> after:
>
> real =C2=A0 =C2=A00m5.262s
> user =C2=A0 =C2=A00m4.407s
> sys =C2=A0 =C2=A0 0m0.850s

and with your patch to redistribute .gitignore in webkit, so top-level
is small again:

real    0m4.185s
user    0m3.271s
sys     0m0.905s

so my numbers look "ok".
--=20
Duy
