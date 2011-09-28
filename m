From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need before updating our ref) breaks fetch
Date: Wed, 28 Sep 2011 12:12:28 -0700 (PDT)
Message-ID: <m3y5x8o527.fsf@localhost.localdomain>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-15?q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:12:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zYa-00063t-Hs
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 21:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab1I1TMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 15:12:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39605 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1I1TMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 15:12:31 -0400
Received: by eya28 with SMTP id 28so5950786eya.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=+d9iIWEf4jASRGT7j1Qzo5BmZV+Ke8s4xNgt2D3PolM=;
        b=xUB1q+zL/9FQCmSiz4FaBPd8HTGaAh5RuDN5AZu/7kG+vHmcMamZEzhKItShMT/Ucm
         Sw/7iuIvJUZYM8/5T+i0VGxF7ed1XztPIhQ/D8AqcU3CsW/5v7y8YV9TbD2S+V+ISnlm
         g3fnyvb/1MtOlSL24NgEjMEHbS64jYkUjv5ng=
Received: by 10.223.35.202 with SMTP id q10mr2171006fad.138.1317237150229;
        Wed, 28 Sep 2011 12:12:30 -0700 (PDT)
Received: from localhost.localdomain (abvu115.neoplus.adsl.tpnet.pl. [83.8.218.115])
        by mx.google.com with ESMTPS id f10sm28369477fac.14.2011.09.28.12.12.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 12:12:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8SJBr8r008107;
	Wed, 28 Sep 2011 21:12:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8SJBT9U008090;
	Wed, 28 Sep 2011 21:11:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182360>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> Hello,
>=20
> Whilst trying to do some work related to fetch, I came across a
> regression in the 'next' branch. Bisecting gave me this commit as
> breaking point (and I tried with the parent and there it worked). Whe=
n
> doing 'git fetch', rev-list will complain about usage, and fetch will
> say that we didn't receive enough, even though earlier versions of gi=
t
> have no problems. This fails both on github and on git.or.cz and for =
git
> and http transports:
>=20
> $ ./git-fetch git://repo.or.cz/git

Have you tried

  $ ./git fetch git://repo.or.cz/git

?

--=20
Jakub Nar=EAbski
