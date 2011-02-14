From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 20:46:52 +0100
Message-ID: <AANLkTik-6KYYNnTr9cmTuE=QQ7gZwP6qw0=bboGWfcf8@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <m3mxm28v3i.fsf@localhost.localdomain> <201102140036.42197.johan@herland.net>
 <201102141040.35819.jnareb@gmail.com> <7vbp2etqne.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102141347460.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4OY-0005vv-SV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab1BNTrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 14:47:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57977 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1BNTrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 14:47:33 -0500
Received: by gxk9 with SMTP id 9so2227031gxk.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hdLghc3prx+bcQ/RFSdmza9ObngqjwlFYbCaC6QzC0k=;
        b=noBLmnR+68Ykd8UtmQy2NT+7n1CmBNUcgGVtTGGKr0KVlbZjTbLwe0aM7pspdB0Gmg
         eYxmT8FnQoppB7SJjwBz/8tJ2UfuMBcWUIBC56kxu0EVzJQIKxGFAzs3SDbsYpMJ/WDX
         e/kueFgLxRY9JB9fYVMjHAST5dg9qYTXJPqiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Pqu6u78djpxdQyRTZFGjWd/uQwPDXqbyFhbO3EUINt5zfpaJFEZR67QWF6qYTmYkaJ
         cx4mJOUvbMqfNRJVwtHBXhn1jHf6/dRJw14Y97oH7TMeTOA431SUMA1EmhLhwj4KmnKk
         P1hrGapb9nu71sAmt1TAbM9hSs8qgGygqBb1c=
Received: by 10.151.44.19 with SMTP id w19mr4959503ybj.165.1297712852755; Mon,
 14 Feb 2011 11:47:32 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Mon, 14 Feb 2011 11:46:52 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1102141347460.14920@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166756>

Heya,

On Mon, Feb 14, 2011 at 20:06, Nicolas Pitre <nico@fluxnic.net> wrote:
> Let's take the OpenOffice vs LibreOffice as an example. =C2=A0What if=
 I want
> both in my repository so I can easily perform diffs between those
> independent branches? =C2=A0They may certainly end up producing relea=
ses with
> the same version numbers (same tag name) but different content
> (different tag references).

I think this concrete example of a very valid use case shows that we
should (in some way or form) implement this :).

--=20
Cheers,

Sverre Rabbelier
