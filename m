From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 21:53:15 +0200
Message-ID: <CAHYJk3TFCtD=MH_crqj=eenyY+kLx3uu9OtDReQ-XJrwy8eoEA@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
	<CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
	<CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
	<CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
	<xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
	<CANy2qHf-HcJVyqo83y0+CtVnNp9TzHC479Lzu+NbpCF9k=8g1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:53:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW8fJ-0008DG-KG
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 21:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbbH3TxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 15:53:17 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36475 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbbH3TxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 15:53:16 -0400
Received: by qgp105 with SMTP id 105so508561qgp.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7qLM/biH4h4D9VjqXGqvPUYOPf7nWKmVQ/X3KvR10S4=;
        b=WqK4XMccSgcbi0iU4KK2TECLD424XBB5+GW5tdBqWhTNZSqAjZOFKPRC47L86X5FeZ
         68UWtJoUAXuJW8Mg+Z9agXNE0GVSVJm+NPhI+h7RQz2/nJTGwPgKFIWDl1g9Q7TV0Fe9
         b6vtKXAYgYJORKfaeK0c/UNTA0p+zn9TQOV7WWghXLzSQJETrZIreL+PjrFqGGGPKMlc
         7hj797z722sh3Zh77tDypJo20syMmNfTG6phEeFwn5FuXZIulnMzKnTBW0J9DFMgZOih
         Blx1bkeo2YJ7i6OCRvIx3yQaUISp7VqAY5Xh2Z6YJ5n9aSUy7Ug9hcci77WjflM4XhBx
         BP9w==
X-Received: by 10.140.130.196 with SMTP id 187mr34726455qhc.58.1440964395893;
 Sun, 30 Aug 2015 12:53:15 -0700 (PDT)
Received: by 10.55.20.139 with HTTP; Sun, 30 Aug 2015 12:53:15 -0700 (PDT)
In-Reply-To: <CANy2qHf-HcJVyqo83y0+CtVnNp9TzHC479Lzu+NbpCF9k=8g1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276835>

On Sun, Aug 30, 2015 at 6:58 PM, Gabor Bernat <bernat@primeranks.net> wrote:
> I would argue against the every n commit check, or at least making it
> configurable, as in my case the speed is something between 0.01 and
> 1.5 seconds per commit. Checking it every n commit would make it I
> feel quite slow to adapt. But it's debatable.



You must have missed the previous times someone said this, but please
don't top post on this list.



Here are some timings for running the command in question 1000 times
on my computer:
awk 'BEGIN{srand();print srand()}'
 0.32s user 1.20s system 65% cpu 2.332 total

perl -e 'print time'
 0.69s user 1.45s system 73% cpu 2.921 total

date +%s
 0.27s user 0.99s system 78% cpu 1.604 total

and for comparison,
/bin/true
 0.02s user 0.26s system 24% cpu 1.127 total

-- 
Mikael Magnusson
