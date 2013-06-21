From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: git rebase fail with CRLF conversion
Date: Fri, 21 Jun 2013 16:29:54 +0200
Organization: OPTEYA
Message-ID: <05ece7ca52df8ac8cd082cab4926487a@meuh.org>
References: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 16:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq2Lh-0006aR-4V
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 16:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161520Ab3FUO35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jun 2013 10:29:57 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:60390 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161512Ab3FUO34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 10:29:56 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Uq2La-000L0N-7u
	for <git@vger.kernel.org>; Fri, 21 Jun 2013 16:29:54 +0200
In-Reply-To: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228618>

Le 21.06.2013 15:41, Yann Droneaud a =C3=A9crit=C2=A0:

>
> In thoses two latter cases, running "git add" does not fail with a
> fatal error: it does nothing.
> I need to run "touch test" to make "git add" fail with error "fatal:
> CRLF would be replaced by LF in test.
>

While searching on the Internet, I've found other people complaining of=
=20
a similar error

http://stackoverflow.com/questions/5074136/git-rebase-fails-your-local-=
changes-to-the-following-files-would-be-overwritte

The workaround, "git config --global core.trustctime false", might=20
suggest there's a race somewhere while rebasing.

BTW, I forgot to describe my environnment:

- GNU/Linux
- Fedora 18 x86_64
- git version 1.8.1.4
- git version 1.8.3.1.448.gfb7dfaa

>
> I believe "git rebase" should not fail here, but more, it must not
> fail in a different fashion randomly.
>

Regards.

--=20
Yann Droneaud
OPTEYA
