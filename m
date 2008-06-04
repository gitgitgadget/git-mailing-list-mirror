From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 04 Jun 2008 04:12:41 -0700 (PDT)
Message-ID: <m3ej7dzc7y.fsf@localhost.localdomain>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
	<alpine.DEB.1.00.0806032115340.13507@racer.site.net>
	<Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
	<20080604102906.GA2126@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jaroslav Kysela <perex@perex.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 13:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3qvy-0005lQ-JK
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 13:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbYFDLMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 07:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYFDLMo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 07:12:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:36759 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbYFDLMo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 07:12:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so16751nfc.21
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=iiJWq9o9CJKJVpAoXltZZCS0NPIdWqno0tH6VIGckN4=;
        b=BUCoByvc69ct5j8KzEmtFuQ3nrCG+KPIJjq1Im/HOTTpVUxZJ2m4Mcuzg428Y/CRN7
         n4buInPX5zYytaJssNKPV5Khftm7daSk9QnMhViwNzjaPT+W5DVbugTOnZA+TnXucRFJ
         +QeZgVgWv37si9KOpabTOp01z8oDIATzfdlzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=DcPb/W1xtXP5rSI8RYGYZmFtaRYa2PPkSAfot/BTMJKtOMvYKw9l9Cs1FUyCDuZy3T
         2GeFcQxC70nESYSKrN2758ehkworIMwAS3c1bYUuh0we/yjuNy77LqMji1uCsGilY1Qi
         SIk5bmrWeqwkDiTxAU4NFpdI3fbuR9CxramTg=
Received: by 10.210.41.14 with SMTP id o14mr770481ebo.137.1212577962480;
        Wed, 04 Jun 2008 04:12:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.131])
        by mx.google.com with ESMTPS id i8sm1768277nfh.20.2008.06.04.04.12.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 04:12:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m54BBuUB003298;
	Wed, 4 Jun 2008 13:12:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m54BBTTo003290;
	Wed, 4 Jun 2008 13:11:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080604102906.GA2126@diana.vm.bytemark.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83774>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2008-06-04 11:16:46 +0200, Jaroslav Kysela wrote:
>=20
> > On Tue, 3 Jun 2008, Johannes Schindelin wrote:
> >
> > > That feels really funny, given that the guy running git-am _is_
> > > the committer, not whoever provided some extra headers to the
> > > mailbox.
> >
> > Yes, the implementatation does not make sense for public patch
> > handling, but if you do various things locally with git-rebase or
> > git-am (pack picking from another repo), you may consider it useful=
=2E
>=20
> But still, you're creating new commits, so they should have your name
> on them.

Yes, if you are _creating_ *commits*, then you are *committer*, isn't i=
t?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
