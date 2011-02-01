From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Tue, 1 Feb 2011 01:58:57 +0100
Message-ID: <201102010159.02694.jnareb@gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <AANLkTi=uOhgnKxRpA0Vm2uSe+uznPwjRB-=2e81VTf-f@mail.gmail.com> <alpine.LFD.2.00.1101311930280.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Budovski <abudovski@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk4ag-0000yH-Vi
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab1BAA70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 19:59:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59402 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab1BAA7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 19:59:25 -0500
Received: by wwa36 with SMTP id 36so6485434wwa.1
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 16:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=phF4hgmuFQIw9xi9MZxspLU6IACcCXPGFk2HyP2dF2k=;
        b=KM/f+KembdQuMvjr95dD29eTHHQ/YVVbyip8tWLab8If8OL9KQEkwgu8eBowuc1jMC
         RWXPjKDKpfCqctIaA0/93M0eEZm6F20QgUclbjkIF3wkje6yQUqvpfUHbC+Iysq8RFdu
         d4VxflOXQQhOEhrbVzP3u4ZNYDA5rj/vn4zcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vMrPovTfJy+AmTRiGOVpuxlXFeDLXUIBWhApQnqPR2GkwA7MopH6UZK9a394SvcMIb
         BXeBafpR0jFUkY7L02f/HzF0g7hWwI24/ncvOBe0UKlE1XzNIsfJhW6O1+qLkb08oTBt
         oVrlIAQwKmWSEb9mU8cLiHrL/tDX2oWnprCYo=
Received: by 10.216.166.68 with SMTP id f46mr27280wel.26.1296521964293;
        Mon, 31 Jan 2011 16:59:24 -0800 (PST)
Received: from [192.168.1.13] (abvg238.neoplus.adsl.tpnet.pl [83.8.204.238])
        by mx.google.com with ESMTPS id h39sm7113278wes.29.2011.01.31.16.59.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Jan 2011 16:59:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.1101311930280.8580@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165783>

On Tue, 1 Feb 2011, Nicolas Pitre wrote:
> On Tue, 1 Feb 2011, Alex Budovski wrote:
>=20
> > >> Nope. =A0't/' is the standard name for directory with "normal" t=
ests, at
> > >> least in Perl / CPAN land, where TAP comes from ('xt/' is for ex=
tra
> > >> tests)
> > >
> > > So what? =A0It is not because Perl has set this horrible preceden=
t that we
> > > have to perpetuate it. =A0I personally never saw t used as a dire=
ctory
> > > name for tests before Git, and I'm not that young anymore unfortu=
nately.

CPAN is around 21000 distributions and 88000 modules.  Most of those us=
e
't/' for tests (default CPAN client to download and install modules run=
s
those tests before installing module).

> > The MySQL project (and its clones) also uses the t/ convention.
>=20
> OK, that makes for another one.
>=20
> Now what about those hundred counter-example projects _not_ using "t"=
=20
> but something more descriptive?

You mean those counter-example projects that use and include comprehens=
ive
tests, isn't it?

Well, GCC uses 'testsuite/'.  Mozilla uses 'testing/'.
--=20
Jakub Narebski
Poland
