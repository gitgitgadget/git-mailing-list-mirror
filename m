From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Wed, 2 Sep 2009 11:00:54 +0530
Message-ID: <2e24e5b90909012230s554b8776q515d21d88e6ed1d6@mail.gmail.com>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
	 <vpqskf8z0rj.fsf@bauges.imag.fr>
	 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
	 <20090831164146.GA23245@coredump.intra.peff.net>
	 <vpqocpvevzx.fsf@bauges.imag.fr>
	 <20090831191032.GB4876@sigill.intra.peff.net>
	 <20090831201911.GA24989@atjola.homenet>
	 <20090831224749.GA24190@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 07:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiiQv-00052l-8G
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 07:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbZIBFaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 01:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbZIBFaw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 01:30:52 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:37505 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730AbZIBFav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 01:30:51 -0400
Received: by iwn42 with SMTP id 42so263452iwn.33
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3hmR0WIjbqZ21s/ySzAwsp0su8Dc7PIQLHgMtFPIFGA=;
        b=KzU90XZFFCxm/1L2u6PlBTe8smj7ZmdTMV68pUlglMhgvxkUz0cUzAh9JJUur4nc+Y
         21c/RXX8h5H01+p3tonttyAYrLsDtvB3eKHYEjxxnrWiV7SBqblWvde7MvL/08ejAlCH
         s3Eg59wuAQ0iVXKvNJnVF9Id+HzNmqfIGTYP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dB5u2yRm9If2oRsXNrkFc9QdXwgdnKvDRr3o8a9ArmpvSVahyameUA7PsvIuChokKD
         lnBBKTOHOb0fENWOQF7Zo8z9erF0zme/16famafwaWjj0YvMGHqAIEk61aktrPy9L6X9
         ZXVBE/ycaCxRcnA1txtXSOu0h0UY/5gOgzclQ=
Received: by 10.231.126.21 with SMTP id a21mr8289024ibs.40.1251869454041; Tue, 
	01 Sep 2009 22:30:54 -0700 (PDT)
In-Reply-To: <20090831224749.GA24190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127582>

2009/9/1 Jeff King <peff@peff.net>:

> OK, it is definitely not about mixed versions, and it is definitely
> reproducible, even without ssh. The local clone optimization manages =
to
> avoid it, but you can see it with:
>
> =A0git clone file://$PWD/a b

ok I hadn't noticed that -- good spot!

Anyway this whole thread went way over my head very quickly so just
wanted to say I appreciate you guys looking at it and fixing it.

Don't know if enough people say that :)

Sitaram
