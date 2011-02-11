From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3] fast-import: add 'ls' command
Date: Sat, 12 Feb 2011 00:51:07 +0100
Message-ID: <AANLkTikfAmFJoEXK1OYE7mKpY6xw=Xw830xS4jzk5mnQ@mail.gmail.com>
References: <20110211224339.GA9973@elie> <AANLkTimReMYu7QYZEuunmH6WqUz=C0nOnAZHzB6cddXt@mail.gmail.com>
 <20110211225904.GA22391@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 00:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po2mJ-0006jj-2A
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 00:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054Ab1BKXvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 18:51:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62105 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887Ab1BKXvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 18:51:48 -0500
Received: by iyj8 with SMTP id 8so2944423iyj.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 15:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=aZGph2vg9c1fJBEnOEh1grEsalbtldgVa8lIYBtJiPc=;
        b=XcpgvnA19tHF0Gpc+OLe+qunsmFfc1VjLYL1SPZ1hr7ttcnhddUHnMhSuOfa3UMVsJ
         1DT0xN+8Xq4IkQE/PKpbOvcCLLn9nzt2cHmrpXmbfdk/og2HjHaAgQ1SV4pbciqJqaXV
         PMm+WbHBDxRCAowoB/UyHu/nOM7GciAlDP/Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=S3loJHcpJKcdCaRK4AD2a+LVXsV+jOgtInpWf/w6MwvM+uQBMjN0itQPE3fflZztR9
         kTrjE7e41hTnTc9/5sY9rwYiw9i5yFELQRi39vnMkRO1jjvXht9+Y6v5e7fLGldoJxz3
         yaAJmA2E+RhmbtPvA/0MfD9bRM2m6eRLitHh8=
Received: by 10.42.170.137 with SMTP id f9mr1454691icz.43.1297468307515; Fri,
 11 Feb 2011 15:51:47 -0800 (PST)
Received: by 10.231.11.132 with HTTP; Fri, 11 Feb 2011 15:51:07 -0800 (PST)
In-Reply-To: <20110211225904.GA22391@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166579>

Heya,

On Fri, Feb 11, 2011 at 23:59, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hmm, the documentation was not at all clear, then. =C2=A0Good catch.
>
> The answer is that it always prints a single dirent, whether the path
> supplied names a file or a directory.

Ok, makes sense :).

--=20
Cheers,

Sverre Rabbelier
