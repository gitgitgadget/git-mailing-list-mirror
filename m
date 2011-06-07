From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Tue, 7 Jun 2011 21:38:49 +0200
Message-ID: <201106072138.50785.jnareb@gmail.com>
References: <m339jps1wt.fsf@localhost.localdomain> <20110607114526.GA9846@elie> <4DEE7D46.3080700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:39:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU27G-0005P9-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab1FGTjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 15:39:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49058 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab1FGTjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:39:00 -0400
Received: by fxm17 with SMTP id 17so40495fxm.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=kezMgKkzoFD+p8yf2hjk0yVizkdm1lwulwYjlzxAvK8=;
        b=kMpsqeiOYYAajTFrDPqXwK72pw2hWFF7c8jPDFzNgvmVKNVUf+WXWTOJdiTYgqeERX
         iEAO0/fMQyCDVHFL4jTPZYji0IUQ9wvFQmxjiJW7ei7et1jngrDlRO3w5kWTMQuPhuln
         gMsP4UmxqqrTJAlN0+nc9P2uuElJD7e8M7M0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bi2SsjMEDN/0Jwiz0JbptYWSfVnBeATgibGJJCbJq8uXvChBLKF4s8RwWgtCbaCDSz
         xhw30sKb4LmDYVHU1DU6jAWY7DCF6m+KsbWoGIScZqcSE5J+LY2ImjiLOuhTC4skGKNU
         tJ7u29Mh22DU0Diy+7nIgAOH2ufX0wH6LHTp4=
Received: by 10.223.143.6 with SMTP id s6mr1329125fau.74.1307475538704;
        Tue, 07 Jun 2011 12:38:58 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id n7sm1898413fam.43.2011.06.07.12.38.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 12:38:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DEE7D46.3080700@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175260>

Ren=E9 Scharfe wrote:

> Would it help if a header was shown in this case, describing the
> following diff, e.g. something like this:
>=20
> 	$ cd /tmp && mkdir repo && cd repo && git init
> 	Initialized empty Git repository in /tmp/repo/.git/
> 	$ echo a >a && git add a && git commit -m.
> 	[master (root-commit) faeefb5] .
> 	 1 files changed, 1 insertions(+), 0 deletions(-)
> 	 create mode 100644 a
> 	$ echo b >a
> 	$ git diff
> 	Let's get rrready to diiiiff!!
> 	In corner a: the INDEX!  And in corner b: the WORKTREE!
>=20
> 	diff --git a/a b/a
> 	index 7898192..6178079 100644
> 	--- a/a
> 	+++ b/a
> 	@@ -1 +1 @@
> 	-a
> 	+b
>=20
> Such a prefix would be ignored by patch etc..  You would still get it
> wrong at the first try but now you'd get immediate feedback on what y=
ou
> actually compared, without having to read the manpage.

We have `diff.mnemonicprefix`, though it is not header... and is not se=
t
by default ;-)

--=20
Jakub Narebski
Poland
