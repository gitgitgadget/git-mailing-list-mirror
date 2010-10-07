From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: format-patch on permission change gives empty patch
Date: Thu, 07 Oct 2010 03:05:07 -0700 (PDT)
Message-ID: <m3eic2fher.fsf@localhost.localdomain>
References: <20101006.173714.245380201.davem@davemloft.net>
	<20101006.174008.70175671.davem@davemloft.net>
	<7vtykyy70w.fsf@alter.siamese.dyndns.org>
	<7vocb6y5sq.fsf@alter.siamese.dyndns.org>
	<AANLkTimA4jrDXmfJp2em34fj6b1sj9kdEyZ_xPTzqcEN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 12:05:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3nLj-000464-9I
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 12:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760214Ab0JGKFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 06:05:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47041 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab0JGKFK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 06:05:10 -0400
Received: by wwj40 with SMTP id 40so695760wwj.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=uV77w1hOhsC7tj4P+y3nutNmagaBwsnEe9l9GKpAKTA=;
        b=HJexwh+puSLKEaEYey0M0dPPP8udSdB0+6fATM/LLwqdsaj8wmcWP10McoRqHjuM8b
         IVrliIFWwIQ1eHQG9prR8Q/MeOwFYEEozdtf9Z6EwVAtjv8Y8ZcXi/zGr930Ry1QpmEN
         sD8sbJ/WUF/vu4FtIeufOvTHvtNT0jLBIkAhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=mMNjkOSnmJsBxgOgVipH6FBH6n4CFhd40H53QXC2Yah5ePv1I4njXf0aTIBwnXq6r0
         qHC951M12IBoHfo92DVld5iXNPz7pLayiWWiQDv7YFRRo+VZHGDOge38+J8FtVbV8CoB
         450QW3tRqdNqg8gUvoHDnuPBibF8S8NuB7Mkw=
Received: by 10.227.153.15 with SMTP id i15mr506890wbw.211.1286445908970;
        Thu, 07 Oct 2010 03:05:08 -0700 (PDT)
Received: from localhost.localdomain (abvx243.neoplus.adsl.tpnet.pl [83.8.221.243])
        by mx.google.com with ESMTPS id h29sm1726017wbc.3.2010.10.07.03.05.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 03:05:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o97A4T8Z020950;
	Thu, 7 Oct 2010 12:04:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o97A4DwV020946;
	Thu, 7 Oct 2010 12:04:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimA4jrDXmfJp2em34fj6b1sj9kdEyZ_xPTzqcEN@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158392>

Sverre Rabbelier <srabbelier@gmail.com> writes:
> On Thu, Oct 7, 2010 at 06:40, Junio C Hamano <gitster@pobox.com> wrot=
e:

> > =A0(2) Treat "rebase" as a way to reproduce history faithfully, eve=
n an
> > =A0 =A0 unreasonable one. =A0We could teach "--allow-empty" to "am"=
, and
> > =A0 =A0 rewrite the pipeline as "format-patch --always | am --allow=
-empty" to
> > =A0 =A0 implement it.
>=20
> Wouldn't we then have to keep adding options for other corner cases?
> Perhaps a '--plumbing' flag that makes format-patch behave sanely
> (e.g., also do stuff like, turn off color and whatnot) and that makes
> 'git am' accept everything it knows how to understand?

Hmmm... doesn't rebase pipeline use "format-patch --rebasing" (where
'--rebasing' is internal option deliberately left undocumented)?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
