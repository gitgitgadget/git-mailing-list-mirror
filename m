From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Thu, 5 Aug 2010 20:24:41 +0200
Message-ID: <AANLkTinF51h8s8Q8dpyY7aZioenWLpOY4qVLGusN2fOX@mail.gmail.com>
References: <1281013217-29577-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTinWvJvNOj6Ga7LgTMmEF37GbZN=hQBFJz4EBry5@mail.gmail.com>
	<vpqfwytnh0m.fsf@bauges.imag.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 05 20:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh57Z-0002FM-6M
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872Ab0HESYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 14:24:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab0HESYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 14:24:42 -0400
Received: by ewy23 with SMTP id 23so2527667ewy.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=7jx+vdFj8nAhWzISNW91Iqvz5KguqnN+ox3Ew/Xda4c=;
        b=GRXjVN1i9ppm4cjwJ/hcdfVE+yrc4/zh5VebUCQoRcDyjsMMJ98r4Y+DTsA2y4RUPj
         a8ICpe7alwrxq7gayZzTrwVGdOrYFIapI/J8el93X8FyAW2bVsdqmTJOXZXl7J4hn9oP
         G+iEXqlwyK/LY4++dyPX0hBlMKKZlc8e+pEbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Z701bf33GTh7hwAAMPnLEza05TjJz7ynWtzWPA5GRb5NmW8WxyGnRXkeXsOT4+w/GG
         kAo1iYC+eDpD8wnNKQNj2dY57XGeoi1wOaMphk+hINCfIQhd2R92hvok78at0SAfh+6w
         dRI7aNuGpekfhU0D6wqzNCeYEMzv54FxWi1ig=
Received: by 10.216.162.78 with SMTP id x56mr9627432wek.80.1281032681220; Thu, 
	05 Aug 2010 11:24:41 -0700 (PDT)
Received: by 10.216.70.67 with HTTP; Thu, 5 Aug 2010 11:24:41 -0700 (PDT)
In-Reply-To: <vpqfwytnh0m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152699>

On Thu, Aug 5, 2010 at 6:47 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>>> +in `$SHELL`, or the default shell if `$SHELL` is not set), so you =
can
>>> +use usual shell commands like "cd". The command is run from the
>>
>> I think that needs a definite article: ".. use the usual ..".
>
> I don't think so, especially with a plural "commands" after.
> Googlefight agrees with me ("use the usual commands" =3D> 350 results=
,
> "use usual commands" =3D> 4900), but that's not a proof.

Being grammatically correct doesn't automatically make a sentence
good. "Use ususal" is a bit of a tongue-twister, so I'd rewrite that
to "use normal" for that purpose alone.

But I'm not a native English speaker, and the natives might disagree wi=
th me.
