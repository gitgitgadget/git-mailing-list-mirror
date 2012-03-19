From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 08:29:03 +0100
Message-ID: <CAAGHeXEsfVPDY+t+ynz0d7HQjsi2ZTMJaNjbT4+t5sS-RL6Jag@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
 <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
 <CACBZZX6_m6b3Abf=NhWvL_g5aHEG9xZEBFfc3K35aSRrUBeWOQ@mail.gmail.com> <7v3995cu0s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 08:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9X2T-0005lk-7k
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 08:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab2CSH3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 03:29:46 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36488 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab2CSH3p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 03:29:45 -0400
Received: by bkcik5 with SMTP id ik5so4021891bkc.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WsW9gYcM9HjVSrr3U7ZzB3ehKcka7I9tAa9vvDgwUGU=;
        b=r3bcQtjplr8iV9rYepPmNPl1DtxpAISbKIJRkPwaLDkkGQHsSdn4uhU0+I1nvCPSkz
         YI3z+ACO/WzN3kylftHwy63EZ+etIrLV8eltCPR1dNXdl53tB/nPpF4GxcoScSSq7g+r
         88TLrChOzPRGxndC8zLfQDCu47IOfiwwgFCgH8yGKhKezR1N0UHOl9aQ843xgP34NLo2
         WZf7KguS9Ajr3wO8i1ZxL5wPXZVN2YrIhIgO38sHcyfKUBx6gQNas1DL9dE/JmrYf+tU
         kEGY0UbmDjuWdM8erCfqg9KA7iNUtoJ3blBQ7dIQ+Jo947t33s4Nj+8L7HcgfTijl7Mp
         wdxw==
Received: by 10.204.156.217 with SMTP id y25mr4233249bkw.36.1332142183854;
 Mon, 19 Mar 2012 00:29:43 -0700 (PDT)
Received: by 10.204.224.204 with HTTP; Mon, 19 Mar 2012 00:29:03 -0700 (PDT)
In-Reply-To: <7v3995cu0s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193416>

On Mon, Mar 19, 2012 at 01:29, Junio C Hamano <gitster@pobox.com> wrote=
:

Hi Junio

> But does that mean we won't have to help our own users who do not dep=
end
> on distros with a gentler approach? =C2=A0I don't think so.

It's here a very particular change: most users don't use / don't like
the default behaviour. Most of them will be happy with this change.


--=20
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche / G+: +sdouche
