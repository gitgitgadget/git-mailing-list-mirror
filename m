From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #13; Mon, 30)
Date: Mon, 30 May 2011 15:55:38 +0200
Message-ID: <BANLkTinLAB3XrDtgzzZGLQXRTzzMRukV2g@mail.gmail.com>
References: <7v62osob67.fsf@alter.siamese.dyndns.org>
	<BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
	<4DE38B61.6030400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 30 15:55:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR2wa-0001Q3-OD
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 15:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab1E3Nzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 09:55:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49958 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab1E3Nzj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 09:55:39 -0400
Received: by fxm17 with SMTP id 17so2468452fxm.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nJ5YHcDc35a3/T1MSZjTDTIswwoU+OPv0FAv5LXqyq4=;
        b=TJzdRMrXtifvuhBg4LP6gS6JXwgXImVs1TQr2NXcsZt3fecSnRpdRK36ObmrqGGryG
         Tx9I/QKfwZgMETXWqbXEmZRY7aPWYGpE2SCR9+c2MzpMa3VRBwCHQxMRdWtyM7+HSe6W
         ReOKYwkyV9Ld6pJGS7tNwlGYD/zsjnA2I69Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dRb9KoRptZhqkM5ZEVSEUr+OxSu16xxNv5OTKB+Q4HDre15DXjOJiuYizIfSbgYm7E
         WIusFx4GPNwtoV1Dw68gHPZLUEk+B3K00mJCqZVzIFwU5cKyeqzeyLhKLA/KBoyZK0hQ
         KJcmBzCIiGEY3IuFwbN935lzuVx1PRszY7e9c=
Received: by 10.223.145.78 with SMTP id c14mr5575404fav.75.1306763738048; Mon,
 30 May 2011 06:55:38 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 30 May 2011 06:55:38 -0700 (PDT)
In-Reply-To: <4DE38B61.6030400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174745>

On Mon, May 30, 2011 at 14:19, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 5/30/2011 14:08, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Mon, May 30, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>>> * ab/i18n-scripts (2011-05-21) 48 commits
>>> =C2=A0(merged to 'next' on 2011-05-23 at 69164a3)
>>> [...]
>>> Rerolled.
>>> Will cook a bit longer.
>>
>> This being ready for master is waiting on Johannes Sixt's patches to
>> supply a fallback getenv() on Win32.
>>
>> Johannes, what's the status of that, and is there anything I can do =
to
>> help with that?
>
> I've started with something I thought would be trivial, but I early
> tripped over a pitfall where getenv is asked to look for "PATH", and =
it is
> expected to find "Path" when we only have the latter in the environme=
nt.
> Sigh. I think that's solvable.

Great.

> Another worry is that the home-grown getenv is not thread-safe. I thi=
nk it
> does not matter today, but who knows...

Doesn't matter for git-sh-i18n--envsubst at least, but if we want to
use it everywhere it might.

We could just start with git-sh-i18n--envsubst and maybe use it for
other stuff later.

> Anyway, I've at most an hour of quality git time during the week, so =
it
> will take some time...

No problem.
