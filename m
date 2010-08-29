From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] git-notes: Run partial expensive test everywhere
Date: Sun, 29 Aug 2010 19:20:15 +0000
Message-ID: <AANLkTi=PdF4VodZDHimq3XpxaYJBuZ0aXb+VU6hUsx3+@mail.gmail.com>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
	<1281483468-24388-1-git-send-email-avarab@gmail.com>
	<AANLkTikfwbtKt2WrxzRyKHnP3ySGtBF33=z_rJwjPx5Y@mail.gmail.com>
	<20100824071453.GA3064@burratino>
	<7vd3t8x8kk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:25:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpnVF-0000Ul-IQ
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab0H2TZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 15:25:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47439 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0H2TZG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 15:25:06 -0400
Received: by iwn5 with SMTP id 5so4291892iwn.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nCB7zs7my9S932INKaDZR9OYNo5s7/R0XoKrN3Vqq9o=;
        b=GaEWddUKIbTsF/nk1ZVkED1gwzM6g8IIeCdmKIYdcoX3LZEeD/3HIDe5lWit8mHVf8
         X6m5Ig6EBeCCgAyv6yedcgkFE+aWZy3sCzNm69aAyVsG+VX292295Ret36/D7nlECZzx
         U3YtppLwYsDLbh9TNZn/VY/JssIQN67BIi2kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x/xITHdVEp9PYY5eEO2Q2Rq90P9dmm1RTjw7f12HDhuMy7MoajPCQ0BndKfmGlHv1H
         CJd6WLyThGsWDuE52URpVmkHql84jUqAyztboq4ULC+5fLKuxOmi8dpkNofSmPcfj0s5
         4+qvoPwFDHc/D0ai7IQ3RPoeS3JvTgkZLoH5Q=
Received: by 10.231.145.16 with SMTP id b16mr4238365ibv.198.1283109615918;
 Sun, 29 Aug 2010 12:20:15 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 12:20:15 -0700 (PDT)
In-Reply-To: <7vd3t8x8kk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154703>

On Tue, Aug 24, 2010 at 16:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Odd. =C2=A0Different how? =C2=A0As far as I can tell, all that test =
asks
>> of time is to execv() its arguments and pass on a 0 exit status.
>>
>> Ah, maybe this is it: perhaps /usr/bin/time sh runs /bin/sh. =C2=A0D=
oes the
>> following help?
>>
>> Patch is against next. =C2=A0Untested except on Linux where it would=
n't
>> make a difference.
>
> Makes sense, although I don't have access to Solaris boxes right now.=
=2E.

I tested it FWIW. It works, thanks both.
