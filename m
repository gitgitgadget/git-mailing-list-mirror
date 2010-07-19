From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Mon, 19 Jul 2010 23:10:55 +0200
Message-ID: <201007192310.56399.jnareb@gmail.com>
References: <4C4484A4.5010009@gmail.com> <m3aapnmbid.fsf@localhost.localdomain> <AANLkTikP3eNVs34ZcB9gHqV60-aqexfCPgcyBWSGn_Y7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>,
	git-dev <git@vger.kernel.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 23:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxcE-0006w6-LF
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936520Ab0GSVLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 17:11:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936504Ab0GSVLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 17:11:04 -0400
Received: by fxm14 with SMTP id 14so2423259fxm.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ydd92KDKcodXEYIEiP0boysKm+jFawGS3K/7ukPbPPw=;
        b=Ttxd/WIJ+YMc8HKYBpNFM5zOhGa0+hLD0KDMnfhmETDnwQGxQrwGMbihMMA1PyEwkq
         s02cBADpWOjKEBs4/e2nXoP4hqOvMFpMYoIylhVPZQBIl1ykaWjY9ezi3gg5qkfs8qdm
         9+0LasgYV9ynw0cKbjy6JZ+sz5ZjZUb6k7gpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jKd1jiAEAjry6DvUOdxwL+rZp59o5+bNjuD6jCM7kOoY8aesDiQ+mdCfRPJNLGmwLP
         JsXp35rGI4soMjtc4I3lTvvpjZojc++RZiBiLrU8wF60FqbC1mIjKS40DEU43Mk70PWt
         XNGzkxetVBclUYnIQK/yDzPXAbgHNbTNS+jlM=
Received: by 10.223.119.10 with SMTP id x10mr2953355faq.1.1279573861109;
        Mon, 19 Jul 2010 14:11:01 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id r2sm2162602faq.28.2010.07.19.14.10.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 14:11:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikP3eNVs34ZcB9gHqV60-aqexfCPgcyBWSGn_Y7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151283>

Dnia poniedzia=C5=82ek 19. lipca 2010 23:05, Jacob Helwig napisa=C5=82:
> On Mon, Jul 19, 2010 at 14:02, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> Ketan Padegaonkar <ketanpadegaonkar@gmail.com> writes:
>>
>>> We use http to serve our git repos, in order for git to not ask me =
a
>>> username/password everytime,
>>
>> Errr... WTF? =C2=A0Can't you configure SSH (use ssh-add, perhaps tog=
ether with
>> tool such as keychain) to use public key based authentication?
>>
>=20
> I don't think SSH/ssh-agent/pubkey would actually help, given that
> it's a https URL.  Unless I'm missing something here?

I was referring to 'we use http [...] _in order_ for git to not ask me
a username/password everywhere'.  I just noted that you can make git
not ask a username/password everywhere when using ssh:// URLs.

--=20
Jakub Narebski
Poland
