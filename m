From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Thu, 12 Aug 2010 20:08:41 +0000
Message-ID: <AANLkTinT9ev0MWNP_Z4vnFGoMN6jSSPPPK4KiZzyLQhS@mail.gmail.com>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
	<20100812023922.GB19174@burratino>
	<AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
	<AANLkTikTX5_qchqDuxiz=dGeTG0gB7_iRt=mpR9vJH5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:08:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oje52-0001tg-DB
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760517Ab0HLUIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:08:43 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48073 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760490Ab0HLUIm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:08:42 -0400
Received: by gwb20 with SMTP id 20so575238gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xE4JFxdXT7YWvgxB7csF0WsX6PoqhQrybdxHG7rN7x8=;
        b=u6+BwQA9kaiPgXM1bXBHKHmqs7f5kqp1k1vd6oKtacyXeUyimT2xF+8CzUo+mJg+g8
         4Qxv/UAgCym30kl+QCDAt6yqo2D9PhzIKR0+oXO1r7Fgez4xXMQYjGpZjBl2rKQXnQqp
         /mxNDfX0RkMo/QTPph7G5tdi5IQi3C/RtBcHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ng/LzfOsdfB6vToPz10y4S45a+IhwKZYOgklZ63a6M1QYgNgVIXm2SthRCu5h9GbR/
         nJDw7Dq1mniP/wvFf+uoW5E+KhfGhcYaeFQzoQ4ASuCY2K7rqxTgF6QFCZrNU8il/PpT
         Mbj6E1GPef8YNY8gRoZMKST4kZymvGGKb+Sgk=
Received: by 10.231.150.7 with SMTP id w7mr677980ibv.14.1281643721257; Thu, 12
 Aug 2010 13:08:41 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 13:08:41 -0700 (PDT)
In-Reply-To: <AANLkTikTX5_qchqDuxiz=dGeTG0gB7_iRt=mpR9vJH5J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153406>

On Thu, Aug 12, 2010 at 20:00, Michael Witten <mfwitten@gmail.com> wrot=
e:
> On Wed, Aug 11, 2010 at 22:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>>
>> That would totally screw with my secret mission to turn everything
>> into manpages, though :)
>
> Frankly, it sounds like you want something more expressive and
> interlinked, such as Texinfo documentation.

I'd like TexInfo, but I don't think Git is switching to that anytime
soon.

However ASCIIDOC is also fine for my purposes, which is just that
these docs will be compiled as part of the manpage compilation, so
they'll be there with man(1), info(1) and on the web with the HTML
export.
