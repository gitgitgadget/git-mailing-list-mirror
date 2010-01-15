From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Sat, 16 Jan 2010 03:54:49 +0900
Message-ID: <fc339e4a1001151054y47fb7da3kdd6bbda8a3060d5@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04> <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com> 
	<20100114070316.GC1528@rm.endoftheinternet.org> <7vr5ps5jx1.fsf@alter.siamese.dyndns.org> 
	<87y6k06wgz.fsf@catnip.gol.com> <7vska7z0yp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rudolf Polzer <divVerent@alientrap.org>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:55:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVrKP-0004rN-FH
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672Ab0AOSzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 13:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018Ab0AOSzM
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:55:12 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:36822 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672Ab0AOSzK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 13:55:10 -0500
Received: by iwn35 with SMTP id 35so740881iwn.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=LjpPZcSFfkEbNh8yXWKeHxqaUlBqNuq2O/M5Y+al1TE=;
        b=mpeI9GMVkQLCyw6GnPEdWqHYjIpj7riDuEDVg1mfrD0FKcGmWQMUUbIiS0krh8jB/o
         hM5W4bn7sPAPE9trFzWHJnqLzbT93+1buMw+JMxIEYq26K/dHM222qDlnmlQo6IQxWEK
         WD58iXSqIcHxuKkVoRF+n2dEFEMP7BoiPhcrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=GKB3nSAcMnd3+YuJ4emy8JqOQo8x6gLK+5O4ZXv2FPSgNiBU2dwDdgaM53QlGJnwOp
         1P1SW9a1cyjO12nLEnPZoM7DIczlx4/VodzSkrjuGCyETjtGHLZ0q1N7x/t3VT0RrTkO
         xnDU4I3ZbqEZGcKksmUhUPqB5lSdrnO7dvZl0=
Received: by 10.231.146.2 with SMTP id f2mr1377718ibv.23.1263581709305; Fri, 
	15 Jan 2010 10:55:09 -0800 (PST)
In-Reply-To: <7vska7z0yp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: a2d8efc06c65c464
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137097>

On Sat, Jan 16, 2010 at 3:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> And it doesn't add --track to the UI.
>>
>> That's not a positive...
>
> Oh, that is definitely a *HUGE* plus. =A0I wouldn't go so far as to s=
ay that
> the word --track was a mistake. =A0But the thing is, unfortunately it=
 has
> already been contaminated by people using it in two completely differ=
ent
> ways and ended up confusing new people. =A0Some use it to mean "this =
branch
> forked off of and builds on top of", and others use it to mean "this =
ref
> holds a copy for reference purposes".

Then the right thing to do is to rename existing uses of --track so
that they're not confusing.  Much-wanted functionality should not be
rejected simply because of an earlier mistake which is essentially
orthogonal to it, and which can be corrected easily enough.

So let's just say we're discussing the semantics, and it will use
another option name, which will be then retrofitted to other similar
uses for consistency (as should surely be done regardless of what
happens with this command):

   git push --GRUBBLENUT

-Miles

--=20
Do not taunt Happy Fun Ball.
