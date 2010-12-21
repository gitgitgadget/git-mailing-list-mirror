From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Mon, 20 Dec 2010 22:28:41 -0200
Message-ID: <AANLkTin2QuMF93RqrRcScxvkzhU4OFJ9Nt42tV+FOjxS@mail.gmail.com>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	<AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
	<1292846433.19322.1.camel@drew-northup.unet.maine.edu>
	<AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
	<1292863989.19322.27.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Dec 21 01:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUq6H-0003zi-Ft
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 01:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933382Ab0LUA3C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Dec 2010 19:29:02 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:38384 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757569Ab0LUA3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 19:29:01 -0500
Received: by bwz16 with SMTP id 16so3964824bwz.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 16:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2Rdj9X818NDhy6fH5bJai3VdaEWkcoFqi6KfMtodjmA=;
        b=FGvtqIr+08HDr6pJkzCGYemAxybzmjqctrKd0TQWILS8yqkd1VZM7SordeiKhFZO8d
         mIAkTOVQ92A2t3sPVWpD+qXdJ1SfeYplXNfVx7CRLf8qjRwiod/OPlGtozO8WRk8PQnn
         eUG1SKKd8wm8lRCPN1m6D2rh8SPYvgCig0Hr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qAZLqkFiEBH2Kxp8dlro2CPfxZLogaUrWH+euBxZheQ932CngWaUh0HPAIgszlwcVb
         HQukCu0Lqde4E5/bBaGptdlUbxrUOI2ioi4rUp8xVo9XIx/EEDERfl5gfk36YjJYnQOg
         2wSW0HvBbtvmCPkkzswoxzKqtTeMMiTumCu7Q=
Received: by 10.204.64.139 with SMTP id e11mr4164645bki.97.1292891321957; Mon,
 20 Dec 2010 16:28:41 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Mon, 20 Dec 2010 16:28:41 -0800 (PST)
In-Reply-To: <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164019>

On Mon, Dec 20, 2010 at 2:53 PM, Drew Northup <drew.northup@maine.edu> =
wrote:
>
> On Mon, 2010-12-20 at 13:17 -0200, Thiago Farina wrote:
>> On Mon, Dec 20, 2010 at 10:00 AM, Drew Northup <drew.northup@maine.e=
du> wrote:
>> >
>> > On Thu, 2010-12-16 at 21:43 -0200, Thiago Farina wrote:
>> >> On Thu, Dec 16, 2010 at 8:38 PM, Vasyl' <vvavrychuk@gmail.com> wr=
ote:
>> >> > Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
>> >> > ---
>> >> > =C2=A0trace.c | =C2=A0 =C2=A02 +-
>> >> > =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> >> >
>> >> > diff --git a/trace.c b/trace.c
>> >> > index 1e560cb..62586fa 100644
>> >> > --- a/trace.c
>> >> > +++ b/trace.c
>> >> > @@ -25,7 +25,7 @@
>> >> > =C2=A0#include "cache.h"
>> >> > =C2=A0#include "quote.h"
>> >> >
>> >> > -void do_nothing(size_t unused)
>> >> > +static void do_nothing(size_t unused)
>> >> > =C2=A0{
>> >> > =C2=A0}
>> >> >
>> >> If it means something, this looks sane to me.
>> >>
>> >> Acked-by: Thiago Farina <tfransosi@gmail.com>
>> >
>> > It may be sane, but why should we trust that it is without a commi=
t
>> > message?
>>
>> Why such trivial thing needs further explanation?
>
> Because even trivial fixes may break non-trivial things.
> In addition, without justification we'd just as soon have somebody co=
me
> back with another patch six months down the road that changes it back=
 to
> the original code. Now that wouldn't make a whole lot of sense, now
> would it?

I don't think so, it's making the function private, because the
function is used only in that file and as such if you see a function
marked as static you know that and doesn't need further explanation in
my pov (but it seems you don't think like that).

> Alas the best way to avoid such a situation is to explain why a chang=
e
> was made to begin with.
>

So, you are welcome to contribute and suggest such description for
this trivial (that may break non-trivial things) patch. So we can
please you and others in the future.


Thanks.
