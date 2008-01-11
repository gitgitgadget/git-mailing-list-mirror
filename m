From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 09:27:56 -0800 (PST)
Message-ID: <m3k5mgmfwq.fsf@roke.D-201>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
	<alpine.LSU.1.00.0801111348230.31053@racer.site>
	<30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
	<alpine.LSU.1.00.0801111501510.31053@racer.site>
	<30e4a070801110839j6b27e224j9a83fc9975f2e4c6@mail.gmail.com>
	<20080111170127.GA23893@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: =?iso-8859-15?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDNgE-0003Ze-Lp
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 18:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124AbYAKR2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 12:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760037AbYAKR2B
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 12:28:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:9691 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759124AbYAKR2A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 12:28:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so499617ugc.16
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=WfPgTvU/bgfal5XUvGiCH+FaOpLRsPJShJT1z0PeDiY=;
        b=Rle9tULDHtJR1sqeXFj+eAIVdktB6T5BlYF/G5DJcd3uBCWGZuVKhHUsduvkOVzIqtcixX//rK7mn/fW/OTUM6Vqzfz2lp4/1v2A3M2BPX1j3g9kWHtkKpQvQuo8cUrrgFOwh860px6LPxwu0ITNaxX+/ZAs3lCno8mPUJwDNgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=LYCGON7YJy5x0fTNf9NQN08KRTzHNdozyrz5bq5fFOftXN4L4aqqBuG0BWsASo45l5B+SlQEph3maxN8kW8ZKF/otPpfdhLIHfgMPbWi1xI+TgUqU+2UVmi66UDXAwCq8Mj4SQ1SAB2PYX4NFiK/gwAkRh48BJ5SHJnHQpXu9H4=
Received: by 10.66.220.12 with SMTP id s12mr236577ugg.15.1200072478316;
        Fri, 11 Jan 2008 09:27:58 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.244])
        by mx.google.com with ESMTPS id i30sm4147382ugd.38.2008.01.11.09.27.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 09:27:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0BHRkkv013535;
	Fri, 11 Jan 2008 18:27:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0BHRIYn013530;
	Fri, 11 Jan 2008 18:27:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080111170127.GA23893@atjola.homenet>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70179>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> A different approach, which feels more in-line with the current state=
 of
> things, might be to allow remote aliases. "origin" would be an alias =
of
> "myremote", and "git remote show origin" might say "origin is an alia=
s
> for myremote" followed by the details of "myremote". So that would gi=
ve
> you the same benefit, but "origin" would keep its meaning, and you wo=
uld
> not get different behaviour depending on some configuration setting (=
so
> the poor folks on #git can just assume that "origin" is the default f=
or
> everyone).
>=20
> Admittedly, I don't see any use-case for aliases except for that orig=
in
> thing, but maybe someone else does?

Aliases for remotes can address current deficiency in git, namely that
you cannot have push and pull under the same remote if they use differe=
nt
URLs. One could use such alias to have the same name for pull and for p=
ush.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
