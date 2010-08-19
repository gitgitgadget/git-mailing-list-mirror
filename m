From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an
 ignored directory
Date: Thu, 19 Aug 2010 00:24:54 +0000
Message-ID: <AANLkTikLUQCnrDAp8c0QBWoGE1XUgXmd8g_19v3HnxJ4@mail.gmail.com>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
	<AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
	<vpqk4noc9ro.fsf@bauges.imag.fr>
	<20100819000052.GA11081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Greg Brockman <gdb@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 02:25:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlswI-0000pY-KR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 02:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab0HSAY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 20:24:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0HSAY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 20:24:56 -0400
Received: by fxm13 with SMTP id 13so692269fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zuu/G1UYTL8Njhl9FEdWIbpOr/jJLYJmdDOvHL/FByA=;
        b=mxswae4Ny8mlJJEIHMEazZe6C9793261ndaOAaKXetfQRR5oIrMlwaw4+D3mBDp0+U
         Ug2yiy+IHK926sPxe7jR7SAXQfzUitME7oivZwVN4LyGLjTIGy1BdmQcHW+EFtvqoZbD
         0A3OCV+FqGA8de8nrHQXTFLNTT3M6uo4guvxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GqcUFctl7H6S+c0RSVnp6syyTX4ZlH4ZDbHUCbUtpZF/KxLyqwJxdJmfx/7/vpGIyK
         ylfrSQAKsBZMfaHjmWpG4CHM58RdSLMFTaET2uy9QSATH13kS6cVjm766AqGT3yqggxo
         M/PHWKJfdymeZarzhoVvIrIdfcneGSY5NXuUk=
Received: by 10.223.125.196 with SMTP id z4mr8526488far.80.1282177494967; Wed,
 18 Aug 2010 17:24:54 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 18 Aug 2010 17:24:54 -0700 (PDT)
In-Reply-To: <20100819000052.GA11081@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153900>

On Thu, Aug 19, 2010 at 00:00, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Matthieu Moy wrote:
>
>> Not sure what is the gain by doing so, and the vast majority of test=
s
>> already there use the style of Greg's patch ...
>
> Right. =C2=A0The usual rule when contributing to an existing project =
is
> "imitate the surruounding code", but there is often a tension between
> global style guidelines and the local conventions.
>
> In this case I have to agree with Matthieu: the test script is
> easier to read if it follows a single, consistent style. =C2=A0The cl=
eanup
> can happen another day.

Sure, I don't feel in any way strongly about it. I just try to
(hopefully mostly helpfully) to point out common things that
contradict the docs we have, especially with the tests, since I'm
getting pretty familiar with them :)
