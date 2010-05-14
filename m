From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] rev-parse: deprecate use as an option sifter
Date: Fri, 14 May 2010 21:01:15 +0200
Message-ID: <201005142101.16317.jnareb@gmail.com>
References: <20100505033536.GB8779@coredump.intra.peff.net> <m3y6fmcx0n.fsf@localhost.localdomain> <4BED9C09.8010801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 14 21:02:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD08w-0005kD-Oz
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759274Ab0ENTB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 15:01:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34833 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616Ab0ENTBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 15:01:24 -0400
Received: by fxm6 with SMTP id 6so1832293fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mg6/7UUEWaw0i8XOfklA8AXGzbT1nNfFlcziBYahg/c=;
        b=Hntg2bvyUv22L2j3X/zkpeHLwYEGKYjDL7zolC/rEd8ToXJkSHSQZ1N5yDU22B3VFI
         J1JekaY/QTnfJqbpN5wFUV1XY97uqAoEPCMEoJnqZXneog+Rm+og/CAN8LDfjPvTmYXM
         BxBG3VKInF6x/8gni182KFtUqiWRP6Qq+xd90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gOsZtFxuaU0C6uiHKq1y+CNBCiLWZ47YwBKL3knMtCQl3WZNmLp2vj6z9PwUeiaSlt
         oBtk8fL7JeyW8tIEkNkdQbz1qtpNYBbRtwjmaggNDhFVBEhS1g5kVrsk0dpFCUkT3tN8
         QKcPHDeOXzP66x7LivEUdrR2JWPMm6JJR1W94=
Received: by 10.102.16.24 with SMTP id 24mr1154789mup.121.1273863682915;
        Fri, 14 May 2010 12:01:22 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id 14sm11625343muo.46.2010.05.14.12.01.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 12:01:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BED9C09.8010801@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147113>

Dnia pi=B1tek 14. maja 2010 20:52, Michael J Gruber napisa=B3:
> Jakub Narebski venit, vidit, dixit 14.05.2010 17:41:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> >=20
> >>  NAME
> >>  ----
> >> -git-rev-parse - Pick out and massage parameters
> >> +git-rev-parse - Parse symbolic names into object names
> >=20
> > What about "git rev-parse --parseopt"?  Isn't it massaging paramete=
rs?
> >=20
>=20
> Sure it is. But if you read the part of the patch that you cut out (i=
=2Ee.
> the comment and relevant diff) you see that the massaging part is the
> deprecated part of it. That's why I suggest not mentioning it at the
> most prominent place. (I don't suggest removing that functionality.)

"git rev-parse --parseopt" is not deprecated.  What is deprecated is
--revs-only, --flags, etc.

--=20
Jakub Narebski
Poland
