From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 7/7] t/README: Add a note about the dangers of coverage 
	chasing
Date: Sun, 25 Jul 2010 19:27:19 +0000
Message-ID: <AANLkTilcivnC1ZIZ1vDKmMZwCc7Hdc9gSTNYzQEYM08z@mail.gmail.com>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
	<1280068861-17701-8-git-send-email-avarab@gmail.com>
	<20100725160545.GA25169@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 21:27:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od6r7-000086-OE
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab0GYT1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:27:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33692 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0GYT1U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 15:27:20 -0400
Received: by iwn7 with SMTP id 7so2120701iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CbYNg0qR9EGC/HhRmcRROXkjakJ2MBDt892YJetuJP4=;
        b=VhA6Q19nxBEgWeYVdBeOCPVgBNSF4BRDzcX0KENmrLf894qJy6TCxxWUWSQxqq4MbT
         kwshC0GInYKGvXmjyrzJf+tgEwgFwzWXcWSaZpyQPsiDbVrdrO0tp+x3Aeeysc7gNHh4
         j+CYglztd4mVJxGoc/6p3YsO0t+4X86yfLGw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qDY2WcOtEnitcklGveI3mOXKtSeKZpjqGLqZhkinbw9JzJEKPXlaCT+LGUXlyzb5MP
         TKmxUKY/OguQ3y2bxF0SCb/a6RGzJHZzz0nlI5g7cUSc5qaNz3PscgwXu6VBQqKFBx6y
         vUvuOIIgIIxGe7QuGjtRuSqYu2JLY74tNM6j8=
Received: by 10.231.33.205 with SMTP id i13mr7469325ibd.179.1280086039781; 
	Sun, 25 Jul 2010 12:27:19 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 12:27:19 -0700 (PDT)
In-Reply-To: <20100725160545.GA25169@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151780>

On Sun, Jul 25, 2010 at 16:05, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> + =C2=A0 Don't blindly follow test coverage metrics
>
> Hmph, that is just common sense,

You'd be surprised at how uncommon it is when people have 98% coverage
and try to painfully squeeze out that last 2% :)

> while =E2=80=9Cyou should really not be paying any attention to your =
code
> while writing tests=E2=80=9D is not. =C2=A0I even prefer the text wit=
hout this
> patch applied. =C2=A0So forget I said anything; I can find a way to h=
int
> at that in t/README later. :)

I don't know whether it should be applied. I just wrote a short
summary in response to the previous commentary.
