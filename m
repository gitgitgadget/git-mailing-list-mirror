From: John Szakmeister <john@szakmeister.net>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Tue, 3 May 2011 04:38:52 -0400
Message-ID: <BANLkTimZTV5bf2fNdeu4nEJkkJAdUSwupg@mail.gmail.com>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 10:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHB8P-0002q2-4h
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 10:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab1ECIiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 04:38:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46687 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab1ECIix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 04:38:53 -0400
Received: by wya21 with SMTP id 21so4764194wya.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W6JEF53wa7Mwu3qfJHxWR2uii47dbqqpA8IjYbK60a8=;
        b=TCH+2e9+d3CWv4J+Jk309Rc6iHaDnw3nhrNX/XACQc1QB2wklV/qlepcGVUFdWbA1O
         ugp3iTZxOj+ld5S2xr87HucWuES2YO1pmpeNjaBYKErf0/QgFm5wMTCTgNuwxQ6GBHOp
         CmMj07M35/MO7Kvd2xO1n1INYOTKaG91bfD4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jwo+1T03FMGM+FJeUgXuG6H+8jdUEf6L6OAQ2EVXSGrn5x9od50CDq0pPj/Nbf2m8z
         0qjGcxW0ReffF+SosDuPKkTM5OQFeowmAnNPpbMEEMJOUPlqsBMpa8pGfOS+yQuZTg/y
         2zWNwXcZ1TRK45z9O12rc6xlv6RQQZzF4YTkg=
Received: by 10.216.255.206 with SMTP id j56mr2746233wes.39.1304411932475;
 Tue, 03 May 2011 01:38:52 -0700 (PDT)
Received: by 10.216.86.204 with HTTP; Tue, 3 May 2011 01:38:52 -0700 (PDT)
In-Reply-To: <7vr58glxro.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 26xBkf7JAZB3TgThLSGkIXvmSd8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172652>

On Mon, May 2, 2011 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Either end of revision range operator can be omitted to default to
> HEAD, as in "origin.." (what did I do since I forked) or "..origin" (=
what
> did they do since I forked). =C2=A0But this resulted in ".." to be in=
terpreted
> as an empty range "HEAD..HEAD", and worse yet, because ".." does exis=
t on
> the filesystem, we get this annoying output:
>
> =C2=A0$ cd Documentation/howto
> =C2=A0$ git log .. ;# give me recent commits that touch Documentation=
/ area.
> =C2=A0fatal: ambiguous argument '..': both revision and filename
> =C2=A0Use '--' to separate filenames from revisions

Perhaps it's because I still don't use git quite enough yet... but I
don't find the above annoying.  *shrug*

-John
