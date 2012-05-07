From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Mon, 7 May 2012 22:05:27 +0200
Message-ID: <CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr> <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com> <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 22:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRUBv-00083s-HS
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 22:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab2EGUFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 16:05:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46347 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605Ab2EGUFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 16:05:49 -0400
Received: by eaaq12 with SMTP id q12so1522957eaa.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Lloauho9/xcxTlq6KTnhO4DTaQ+siRab5rd6+4P9tjI=;
        b=FxmjpBm/IqT65RgUhn/2A1QRi1TTZozYIVjXx38M9+dn2BynvByawsfRu4lrnHbrnq
         QXGxiIubTUMl4uYPCKdZX0rY+8duj5/Oza2ZJbvSUhrJrUGsC2DOAEeZmCLHvCPDqa1Z
         YfGkM8ThJQbE0s/T1FoivIaDLidmws4a8Np8odhD+aI1sgRS0//NLNPmdAS71S1czzIE
         BwhXvMJBc52F6t+2BZUAjoDRpHLXSminu8nV8LxvkJ6XpvucMDq3pqr8qcMFDx9tWmEb
         WlJbfIphmGXEm3g+atRAKgjJ402L8ahef6BuXDs8zx7EmN7KN2pd8zh09YovFff/erdF
         XRkA==
Received: by 10.213.14.70 with SMTP id f6mr820979eba.44.1336421148171; Mon, 07
 May 2012 13:05:48 -0700 (PDT)
Received: by 10.213.14.65 with HTTP; Mon, 7 May 2012 13:05:27 -0700 (PDT)
In-Reply-To: <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197303>

On Mon, May 7, 2012 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, May 6, 2012 at 11:16 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> I don't know, precommit is not an English word, and it was discusse=
d
>>> before, but not many people vouched for it.
>>
>> FWIW in the Icelandic translation I translated "index/stage" to the
>> equivalent of "the commit area".
>
> Care to explain why you did not use a translation of the verb/noun
> "stage"? =C2=A0I actually was having a hard time to come up with Japa=
nese
> translation (not that I have plan to contribute to ja_JP.po), as the
> shipping/logistics term "to stage" does not cleanly translate to the
> language without unnecessary connotation that imply what is described=
 is
> something the our "index" actually is _not_.

Because there's no equivalent of "stage" in Icelandic that would make
sense as both a verb and a noun. There's a word that means "step" (as
in a step on a ladder"), but it doesn't make much sense to say that
you'd "step something".

I also think it makes more sense to pick a translation that associates
the stage with commits. I.e. a commit is "f=C3=A6rsla", the stage is
"f=C3=A6rslusv=C3=A6=C3=B0i=C3=B0".

I might still go for another one, but that's the one I like best so
far.
