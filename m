From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Mon, 20 Dec 2010 13:17:49 -0200
Message-ID: <AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	<AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
	<1292846433.19322.1.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Dec 20 16:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUhUq-0005DP-5C
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 16:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612Ab0LTPRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Dec 2010 10:17:51 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:37633 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314Ab0LTPRu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 10:17:50 -0500
Received: by bwz16 with SMTP id 16so3391462bwz.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=txBcRFj9s621jv2mtVBbT4IBkfoj5W3IhkQjRjpppmk=;
        b=jGIcSHhewNATeHo8BYpaB8ixgqrVNV35FxfQy1XZt1+PcfDrZEEBjbltjMdxpIjwxV
         qnqbkEp2Z0iM+5N9ORhOXaUdnpwzNegviayTamMKK03QPB+ifwPmG1mSZvj8FfwU0pa9
         O003VzhXrCywQ0XxL7WW8Fi+JRk1RXgBbW2tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wz9KmoB3omNg4jXThXTBY62jEeFHqJWDohQ0ST4nEBwiBefJXTS4EBvyMZtoq80nDS
         VB9ILnG175WX2YqgQjsvSop3SKCCSiln7SHv5C9glSDstlS/tOgEuQ9iYtFMIGuxxXCn
         gEqZfzKMQMyU9upY3Lzqqthmbn7ceq+CxehBM=
Received: by 10.204.59.76 with SMTP id k12mr3636557bkh.70.1292858269258; Mon,
 20 Dec 2010 07:17:49 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Mon, 20 Dec 2010 07:17:49 -0800 (PST)
In-Reply-To: <1292846433.19322.1.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163997>

On Mon, Dec 20, 2010 at 10:00 AM, Drew Northup <drew.northup@maine.edu>=
 wrote:
>
> On Thu, 2010-12-16 at 21:43 -0200, Thiago Farina wrote:
>> On Thu, Dec 16, 2010 at 8:38 PM, Vasyl' <vvavrychuk@gmail.com> wrote=
:
>> > Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
>> > ---
>> > =C2=A0trace.c | =C2=A0 =C2=A02 +-
>> > =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/trace.c b/trace.c
>> > index 1e560cb..62586fa 100644
>> > --- a/trace.c
>> > +++ b/trace.c
>> > @@ -25,7 +25,7 @@
>> > =C2=A0#include "cache.h"
>> > =C2=A0#include "quote.h"
>> >
>> > -void do_nothing(size_t unused)
>> > +static void do_nothing(size_t unused)
>> > =C2=A0{
>> > =C2=A0}
>> >
>> If it means something, this looks sane to me.
>>
>> Acked-by: Thiago Farina <tfransosi@gmail.com>
>
> It may be sane, but why should we trust that it is without a commit
> message?

Why such trivial thing needs further explanation?
