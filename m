From: Ivan Kanis <ivan.kanis@googlemail.com>
Subject: Re: security flaw with smart http
Date: Thu, 28 Jun 2012 09:35:23 +0200
Message-ID: <87obo3j3d0.fsf@visionobjects.com>
References: <87fw9ns0cp.fsf@kanis.fr>
	<CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com>
	<7vmx3vp2co.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 09:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk9GI-0001U9-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 09:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab2F1Hfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jun 2012 03:35:30 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62337 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483Ab2F1Hf3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2012 03:35:29 -0400
Received: by wibhr14 with SMTP id hr14so1910978wib.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2012 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:references:face:x-hashcash:x-hashcash:x-hashcash
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=pqFQdsStFkGhQ8iOkSsR4DBRMUw2CQZBr0JX8F3MfBk=;
        b=Cr/+9bUU8JMgRHoidfAN1AlmrsDX6+caghxXRJ33TdvvvoE1q8MwEp+rHfn60oyTNi
         tzRX5d6LV8pYW4LY25VfN/a0Mr4MbOG6rV8cGxAT5RNbgal/bNWee9XZXW/uUmv3Q08U
         Ki47GxWxkG6SqoJW51f1d30VMuFkPL4tyienxOjSO+eeFai4xH+FZZpoiV29q/mWnZlP
         BocB/rycjStf2HopOk6gVP64uJXRNrHHWP1ptZQU4XMiTStue3AkZt7toYROJ5X9NJrq
         J98E7B5K3Umzlm32hpcKElC+BOVJRTCctj6qjAQqhRjmDvvj2S14S5sGg+rzRhhV0z+0
         VOAQ==
Received: by 10.180.82.164 with SMTP id j4mr2136153wiy.18.1340868928260;
        Thu, 28 Jun 2012 00:35:28 -0700 (PDT)
Received: from yan (nantes.visionobjects.com. [92.103.229.106])
        by mx.google.com with ESMTPS id fu8sm15181536wib.5.2012.06.28.00.35.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jun 2012 00:35:26 -0700 (PDT)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
X-Hashcash: 1:20:120628:gitster@pobox.com::jFC6pO6suhZ130lJ:000000000000000000000000000000000000000000004ymC
X-Hashcash: 1:20:120628:spearce@spearce.org::CqyNAFheGE1AesNj:0000000000000000000000000000000000000000005rWi
X-Hashcash: 1:20:120628:git@vger.kernel.org::AfE/zsz7siOWnhAp:000000000000000000000000000000000000000000AhET
In-Reply-To: <7vmx3vp2co.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Jun 2012 12:34:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200780>

Junio C Hamano <gitster@pobox.com> a =C3=A9crit

> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Fri, Jun 22, 2012 at 3:12 AM, Ivan Kanis <ivan.kanis@googlemail.c=
om> wrote:
>>> I think we found a security flaw with git http smart backend. We ar=
e
>>> running git version 1.0.7.4 on our server. Adding random words afte=
r the
>>> password and the authentication still succeeds.
>>
>> git http-backend does not handle authentication or authorization. Th=
is
>> is handled in your web server. You should consult your web server's
>> documentation, and maybe its configuration files.
>
> Very good advice.

In case someone is reading this thread I confirm the problem comes from
Apache.
--=20
Ivan Kanis, Release Manager, Vision Objects,

Le mal est un mulet : il est opini=C3=A2tre et st=C3=A9rile.
    -- Victor Hugo
