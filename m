From: =?UTF-8?B?SsO8cmdlbiBNYW5nbGVy?= <juergen.mangler@univie.ac.at>
Subject: Re: do without .netrc
Date: Fri, 08 Aug 2008 17:36:16 +0200
Message-ID: <489C67F0.6090609@univie.ac.at>
References: <4898DBA6.1060707@univie.ac.at> <20080806085025.GU32057@genesis.frugalware.org> <48998AC7.20204@univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 17:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRU1r-00039A-CM
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 17:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbYHHPgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 11:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYHHPgV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 11:36:21 -0400
Received: from grace.univie.ac.at ([131.130.3.115]:40217 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYHHPgU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 11:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=univie.ac.at; s=rev1; h=Message-ID:Date:From:MIME-Version:To:
	Subject:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=4cQtiLLklWOss+KU5rHM134MGlikK+0Fm5
	so/6KXHGQ=; b=tPGtUB6u1Twz0SqcEby+KbPRbmI/5cNKoQxt9j7E4S8/gFmMVs
	obs66wlxOtJ3m6P18Vt8ClbzWWN/FHc4wErjTBwWzPWoMWjEBcELaXAhtm6W9G2A
	D3Dy7hVWguNAGRW2LBRDCHB5+DEctMSbYR9ZAjKx8nzuRrZo6M2B8qldM=
Received: from justin.univie.ac.at ([131.130.3.111] helo=justin.univie.ac.at)
	by grace.univie.ac.at with esmtp (Exim 4.69)
	(envelope-from <juergen.mangler@univie.ac.at>)
	id 1KRU0n-0007XF-8j; Fri, 08 Aug 2008 17:36:17 +0200
Received: from [131.130.37.200] (helo=[172.17.19.72])
	by justin.univie.ac.at with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <juergen.mangler@univie.ac.at>)
	id 1KRU0n-00042h-7M; Fri, 08 Aug 2008 17:36:17 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
In-Reply-To: <48998AC7.20204@univie.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91683>

> The advantages for me would be:
>=20
> a) I have multiple different passwords on the same server for differe=
nt=20
> directories, it's not possible to put this to a netrc (AS FAR AS I=20
> KNOW). So i have to edit the netrc for every push, clone, ... -> very=
=20
> inconvenient
> b) secondly (maybe not a super valid argument for you): netrc is not=20
> considered to be the most secure thing, isn't it? Our network is inva=
ded=20
> every year "tested" by thousands of computer science students, so i=20
> always try to have as few plain-text passwords as possible lying arou=
nd=20
> (one never knows - yes netrc has 0600).
>=20
> i'd also prefer not to use the user:pass@server schema, but to be ask=
ed,=20
> to not show pass in the history and config file in .git although even=
=20
> user:pass@server would be an advantage because it solves a).

Valid solutions would therefore include:

* allow http://user@server urls, and ask user for password (A-rated)
* provide for http.basic.user and http.basic.pass in .git/config file=20
(B-rated, one has to take care about the security of his config file)
* allow http://user:pass@server urls (C-rated, the consequences have=20
been discussed on this list several times)

J=C3=BCrgen
