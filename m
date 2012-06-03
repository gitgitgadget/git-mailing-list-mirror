From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix many comment typos
Date: Sun, 03 Jun 2012 13:44:10 +0200
Message-ID: <4FCB4E0A.5080107@lsrfire.ath.cx>
References: <8762baf8do.fsf@rho.meyering.net> <7vmx4lz5bm.fsf@alter.siamese.dyndns.org> <87396ceuoy.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 13:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb9EO-00086Y-P2
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 13:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab2FCLoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 07:44:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:41881 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2FCLoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 07:44:19 -0400
Received: from [192.168.2.105] (p4FFD8869.dip.t-dialin.net [79.253.136.105])
	by india601.server4you.de (Postfix) with ESMTPSA id 39BEC2F8030;
	Sun,  3 Jun 2012 13:44:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <87396ceuoy.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199082>

Am 03.06.2012 09:11, schrieb Jim Meyering:
> Perhaps a more palatable change, here and in the other two places:
> s/seeked/cg-seek'd/, i.e.,
>
> - * "git bisect" showed mysterious "won't bisect on seeked tree" erro=
r message.
> + * "git bisect" showed mysterious "won't bisect on cg-seek'd tree" e=
rror message.
>
> Then, if someone does this again, it will be more obvious that
> it is not a typo.

This change is only valid if the command "git bisect" at some point=20
printed "won't bisect on cg-seek'd tree" instead of "won't bisect on=20
seeked tree".  And even then, it doesn't make now sense to change=20
already published release notes (Documentation/RelNotes/1.5.4.4.txt),=20
after the fact.

Ren=E9
