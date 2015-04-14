From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 16:20:07 +0200
Message-ID: <CAHGBnuODrwq-MSp53zacgfcevX7tdtfPEC+fyTrWrnTKaFKO1g@mail.gmail.com>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
	<CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
	<CAHGBnuOuMnAsP12dukPSP31ABRoUc=s7iZFnca9-K2hOcog9cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, git@drmicha.warpmail.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 16:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi1hG-0000kQ-2V
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 16:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbbDNOUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 10:20:09 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35510 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbDNOUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 10:20:08 -0400
Received: by igbyr2 with SMTP id yr2so39369302igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FEl5uObtidnhHoNCGHyGpN5d1wbZhlrKIXr4l4mqjKo=;
        b=qqLIb/9jeMrkMvcnaPSTo7vwn3nSTKBKDWtfPosbRzZI0HQsKhZsHyLXnL0ZoZajbO
         2ARA0QNpFnXOOceJCy9ojCeDXt88XoemyrqnTXOoSjguQZg7EgDs0XVKar6LV7ZgHuaL
         oSIo9xpVgWiuGKNcXTscm3Fx7VHt7M6vdFRS2TXiMICmhZ+uNd9NHJ5XPD7GnNy+fp0Z
         M57Q52/5FIEA2og/8KYq3lmQ7e4bBa1yJJxROikY6RP6egN15TMJeTLHaEUDV9oEhO0v
         rYfSx82xVhEqZ4f/o+yxyZLCs2/hWEOdNReFWpshzEdBNqcSiY2rnyE5IjVS6x3+NDAT
         zDKg==
X-Received: by 10.50.79.202 with SMTP id l10mr24612967igx.7.1429021207363;
 Tue, 14 Apr 2015 07:20:07 -0700 (PDT)
Received: by 10.107.159.82 with HTTP; Tue, 14 Apr 2015 07:20:07 -0700 (PDT)
In-Reply-To: <CAHGBnuOuMnAsP12dukPSP31ABRoUc=s7iZFnca9-K2hOcog9cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267140>

On Tue, Apr 14, 2015 at 10:52 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:

>> A dangling object is an unreachable object that cannot be
>> made reachable by any way other than pointing at it
>> directly with a ref.
>
> Thanks a lot for the prompt explanation!

Note to myself: I just realized that both "dangling" and "unreachable"
are also nicely defined in the Git glossary [1].

[1] http://git-scm.com/docs/gitglossary/

-- 
Sebastian Schuberth
