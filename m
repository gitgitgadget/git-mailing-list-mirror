From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: branch versioning
Date: Mon, 4 Oct 2010 20:50:54 +0700
Message-ID: <AANLkTinR31x9NrsHoDt3UQ8w=hioPGtkQDkQ-5bSNW69@mail.gmail.com>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
	<AANLkTi=73Siu9O1WT8MdjfAEO5j5y=CkOAiof0z83L=c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:51:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2lRi-0003Dg-R4
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab0JDNu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 09:50:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39751 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab0JDNuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 09:50:55 -0400
Received: by wyb28 with SMTP id 28so4907650wyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4xj4sbjiGFypTSkjenpDhBEHqAN4p/GTtyGVo+4Sv2c=;
        b=V2Cjs4mx4lRR8HbGYeNAVyRSgqOOMBbpRSwkqGKicOMGS2fx0ud7t1jspJa+mhb7Hu
         /ceCmT926mxrKCcR/xVX1IE9xxJreltf6fX2QEaYa1XmXOnlo5leZibLzagKsL4svpH2
         QpuCvEVGB+xZM8GlG8IA0X1V1jpj0tCPwOJU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wb7vE8o38qfFJxc8Q2I2U7KBFfPNy27mrL5AJjt0fyIAd+ORghluaW0DG+qkEMh1mn
         AHqgWWAxpwKkUgSm9RuzSeNZ4LbSIh08FLe811nslO+A8HXf8XseHwSmnT5kxDgKme14
         nLgiXnoSXNzh+q+hEFdXm1xq++P8ZNc0bF86w=
Received: by 10.216.10.5 with SMTP id 5mr7678738weu.81.1286200254407; Mon, 04
 Oct 2010 06:50:54 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Mon, 4 Oct 2010 06:50:54 -0700 (PDT)
In-Reply-To: <AANLkTi=73Siu9O1WT8MdjfAEO5j5y=CkOAiof0z83L=c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158049>

On 10/4/10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> w=
rote:
> On Mon, Oct 4, 2010 at 13:18, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
>  > How do you guys manage versions of a topic branch? I usually end u=
p
>  > saving format-patch series somewhere or forget all old versions.
>  > Although I really want to keep old versions around. reflog to me  =
 is
>  > polluted with every kind of branch updates. And it's local
>  > information. It can't be transferred to another repo (or can it?)
>
>
> I usually have foo, foo-v2, foo-v3 which eventually gets reset back t=
o
>  foo once I'm sure nobody cares about the initial one or foo-v2. It's
>  very chaotic.

You remind me of my ~100 patch rebase/refactor on busybox-w32. I had
up to master.7 :)

>  So my git.git on GitHub is up to 123 branches, and I don't even want
>  to know what my personal git.git is at. I also save my outgoing
>  format-patch E-Mails, but would probably do less of that if there wa=
s
>  support for attaching the comments after the diffstat in a git-note =
or
>  something.

OK. Thanks for the information. I'll try my best to stay away from
your repo :-D. Seriously, how can you select a branch out of those 123
branches? Does git-branch support regex matching or.. (looked up
git-branch.txt, no it does not)
--=20
Duy
