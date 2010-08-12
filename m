From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 16:50:32 +0000
Message-ID: <AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 12 18:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjazJ-0005g3-V6
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 18:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760384Ab0HLQue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 12:50:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60599 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760299Ab0HLQud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 12:50:33 -0400
Received: by fxm13 with SMTP id 13so856828fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BlgGr9XbLZolru1vRSpvB51lF0F1+dBhg1fyEOfHwZw=;
        b=kjwxuVrezAUwHhtmDiw8EwSCapolTxmKxOU9SW68qTlqYLo4aYlrqvVGzgsddh5Q4z
         WZC8BMx73uluB9INiqgpQ8wAIRKXSlFZcOPUxN21jjRpcp2wqN08Sp+EiOehfXODNm9B
         2eIL57YkkNZe36yQ0M8rPwq2VjhyAM0jR/UdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DrAqyCU1nhd9T6WPSrbuIbYyRkOPSnmYuXxKdP78+hn3jX2nOju4+acCBAu2/2KtPq
         X8KdqaKKOeXjOlC3zU3usIlOsidnDkmpv6GzdKo9yg3WXTNJpvpwasK9dvf4Mn07m2t+
         eeupHfE2+4qafLEDJatB/MWcUhuSORDd2v0cE=
Received: by 10.223.104.134 with SMTP id p6mr588195fao.10.1281631832545; Thu,
 12 Aug 2010 09:50:32 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 12 Aug 2010 09:50:32 -0700 (PDT)
In-Reply-To: <AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153387>

On Thu, Aug 12, 2010 at 11:35, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Thu, Aug 12, 2010 at 12:20 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:
>> On Thu, Aug 12, 2010 at 09:23, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
>>> [Sorry for the Cc spam; I lack the time to conduct individual messa=
ges.]
>>>
>>> I compiled many topics in pu and ran the test suite on Windows,
>>
>> A Windows smoker would be useful :)
>>
>
> I guess I could look into setting one up. Where would I look for the
> most up-to-date instructions on doing this?

The smoke testing section in t/README in pu.

Here's a small script I use to automate my smoke reports:
http://github.com/avar/linode-etc/blob/master/bin/cron/build-and-instal=
l-git

But it's crappy and incomplete, we/I still need to write something
easy to set up that does automatic bisecting etc. on errors, tests
multiple branches and all that good stuff.

In the meantime smoking pu daily in cron should do.
