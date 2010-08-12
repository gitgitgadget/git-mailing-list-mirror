From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Thu, 12 Aug 2010 20:37:45 +0000
Message-ID: <AANLkTi=CzL3C7pn9+qYU4B6sOjCLS5=Mo0SKbUkw4aP9@mail.gmail.com>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
	<20100812023922.GB19174@burratino>
	<AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
	<20100812203359.GE2029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:37:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeX9-0007oe-Mq
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606Ab0HLUhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:37:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63992 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab0HLUhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:37:46 -0400
Received: by gwb20 with SMTP id 20so586916gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QDpBIbNFW0G1q8UMZ0R82YmF60rNOVQm4NUJM+vm9as=;
        b=Q8Fbf2Ktc9X1Bg2oK9pKg8bANUcWSlw39jvGdjV/DjUqB2yAypomhmHaZsE3pTsf+Y
         apDYA8I5NE+TQY6OGkqSdd5ZDuGbxkhitWb4qvSIt3seSfKadjLNDYFOygcuhqxhwZtx
         Ah0BXkNkK6JK6tp1jQ4v8NkdMLEndig4kjG7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xJQdAuklObb21y5bFEi19/5KQkDczdgII8APaHbPxq7iV8z3tuIDedrYmw4kMyAe2Q
         pT7zm3yacxpUzIIfV4sM4NTVUK0sLyx1+kYN+qmHiBiWL1Jrtz6c65PenD7m1F2kQh8v
         7h8Sy7nuO7XeFbvSDaag0KDjWZSoEb5xW1wyw=
Received: by 10.231.157.205 with SMTP id c13mr658026ibx.71.1281645465821; Thu,
 12 Aug 2010 13:37:45 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 13:37:45 -0700 (PDT)
In-Reply-To: <20100812203359.GE2029@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153413>

On Thu, Aug 12, 2010 at 20:33, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>>> =C2=A0 =C2=A0* Core git concepts (that need to be translated), may=
be I could
>>>> =C2=A0 =C2=A0 =C2=A0adopt the gitglossary to this task, but it'd n=
eed to be a bit
>>>> =C2=A0 =C2=A0 =C2=A0more structured, i.e. describe core data conce=
pts first, then
>>>> =C2=A0 =C2=A0 =C2=A0some other terms.
> [...]
>> What I had in mind was something like this (incomplete, and mostly i=
n
>> Icelandic): http://gist.github.com/425917
>>
>> I.e. just a bulletpoint list of core terms that you need to translat=
e
>> for Git.
>
> You may like git-gui/po/glossary/, then.

Awesome, but needs some work, e.g. no "blob", "tree" etc.

> Too bad --- I was looking forward to the gitglossary improvements. :)

I think I'll still patch it / something else at some point,
git-gui/po/glossary/ will be very helpful then. Thanks.
