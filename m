From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 19:50:29 +0200
Message-ID: <p2ofabb9a1e1004111050x660c37fdke4d5316baaa0cfbe@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> 
	<k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com> 
	<cb4ed5763e71bd84b4e80109923494ca@212.159.54.234> <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com> 
	<d0869259b375a26df46ef92a2b973615@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11J9-0007w3-K7
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab0DKRuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 13:50:50 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:53283 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab0DKRuu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:50:50 -0400
Received: by yxe1 with SMTP id 1so2169957yxe.33
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MqFVHODFGOzTmuSjN6sOFDx7wqpq5EOFZmsSL0YOz8Q=;
        b=JgBr3VCGrk42a/Cn4dJqgA435JJHfd7wpCEk4P4RR5CW609f/6dqB+PDtbaQFeGJ6t
         MM92jEERRkUl68yZblTd4Rx8Q6srGB17bfgtNZv7NDaExCGw6/nf1cL+4gSss1Y9L0cm
         0h1Xkne47biOLQI2mtzIPXSnwGc/cGpDyHPBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O0JQn/p68EsHjfefTq83FGNr3F32eFOzw0nZR6KgDraWguq0nSLBY5i0sXI0XSirqr
         YOJ3dOx+DkuXiq2CJrsKXltsBvd/FOpYh+otxsWavOKMvCd/7KxCP1P32ZxLgDHStZ5N
         rI6oFrpkpt/EvgKcGRuGNPn0QHYqQQSnPdyRE=
Received: by 10.100.206.13 with HTTP; Sun, 11 Apr 2010 10:50:29 -0700 (PDT)
In-Reply-To: <d0869259b375a26df46ef92a2b973615@212.159.54.234>
Received: by 10.101.152.13 with SMTP id e13mr4939518ano.0.1271008249430; Sun, 
	11 Apr 2010 10:50:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144668>

Heya,

On Sun, Apr 11, 2010 at 19:45, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> I think that there probably are commands where it will be more work t=
o
> integrate the output - but I think that is probably more to do with t=
he
> structure of the current code than the API of the new. =C2=A0Does it =
make a
> difference what the API of the new output code is if there isn't curr=
ently
> a sensible hook-in point?

No you are right, the existance of such hard-to-change commands does
not really affect the API design in this case, although I think it
might be a good idea to try out at least one such command before
committing to using this API. For example, it might turn out that
there's an elegant way to hook in, or that adding all those if
(output_style !=3D OUTPUT_NORMAL)  statements gets cluttery and there
should be a different way to do things instead.

> If code has been written without the expectation that the output form=
at
> could be changed then the effort to add a new output format could be
> considerably more than for status or ls-tree. =C2=A0However, with the
> frontend/backend design hopefully we only have to endure the effort o=
nce to
> get multiple output formats.

I'm curious to see where this will lead us :).

--=20
Cheers,

Sverre Rabbelier
