From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 23:21:12 +0100
Message-ID: <AANLkTinwdFvR4AV9nR=9sVuMYYZHMn4C7RQ0wneX6Ys+@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
	<AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 09 23:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwZ5-0007e1-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab0KIWVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 17:21:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53358 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab0KIWVO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 17:21:14 -0500
Received: by fxm16 with SMTP id 16so5427681fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8NTeUntnblGXtyRncnuzSyXk2+zPI1oZECjAKn1/HEs=;
        b=YQvVla/BJhuxBHpzBCuaX4sDA9GAKM/7U2HgNZf6c/nrQFeyM4DTXVC7aTaHWAV1JM
         9qUWLVl2YtamOn1FoLh5cN8SS6mD6LYdfkJHpYmOOregHovzUX9Az/WJY9JU+Pzc0A7v
         X+ATYGHxqStkI+rmqOcQOhI9ta9xj3UUmVT8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ItW6rLLWW6GkYlRkFHcIx7X89uPZotNWF0FUTG6NgisIzp87DlakE61D2osev+Xhwj
         k4hGcFB7GkCyRlqLjjjMb2FDXiKlkWHVLdHtDQuCLFOnaHzI5UyPemtZ8xE6843RLLhb
         VwYlOtPFKq1ownAixaKsdcOaRqay95WauT/xI=
Received: by 10.223.86.197 with SMTP id t5mr5822247fal.38.1289341272044; Tue,
 09 Nov 2010 14:21:12 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 14:21:11 -0800 (PST)
In-Reply-To: <AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161103>

On Tue, Nov 9, 2010 at 23:17, Erik Faye-Lund <kusmabite@gmail.com> wrot=
e:
> On Tue, Nov 9, 2010 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> * ab/i18n (2010-10-07) 161 commits
>> =C2=A0- po/de.po: complete German translation
>> =C2=A0- po/sv.po: add Swedish translation
>> =C2=A0- gettextize: git-bisect bisect_next_check "You need to" messa=
ge
> <...>
>> =C2=A0- tests: use test_cmp instead of piping to diff(1)
>> =C2=A0- t7004-tag.sh: re-arrange git tag comment for clarity
>>
>> Will merge to 'next' to see what happens; it is getting ridiculously
>> painful to keep re-resolving the conflicts with other topics in flig=
ht,
>> even with the help with rerere.
>
> Hmmm, this is a bit more annoying IMO - this currently breaks in
> msysgit, due to lack of gettext and NO_GETTEXT not working properly.
> =C3=86var is aware of this
> (AANLkTiny+NmXew6UxjNMO+o75=3DCxxWm9iVRMRxs0LyTJ@mail.gmail.com), but
> haven't fixed it yet. I do have the patches needed to get a gettext i=
n
> msysgit, so it's not a very big deal to me. But are you sure that thi=
s
> makes this series ready for 'next'?

I hear ya. I'm hoping to get around to fixing all this stuff before it
lands in "next".

Also going to look at your gettext patches to see if there's anything
there that needs
to be made part of the series.
