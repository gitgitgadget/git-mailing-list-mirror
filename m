From: Andreas Ericsson <ae@op5.se>
Subject: Re: how to create v2 patch
Date: Thu, 06 Dec 2007 23:03:11 +0100
Message-ID: <4758719F.1080408@op5.se>
References: <47515693.9070405@imap.cc> <47515EF3.8010507@obry.net> <20071201134321.GA10997@glandium.org> <475855D6.201@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, Pascal Obry <pascal@obry.net>,
	git@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
X-From: git-owner@vger.kernel.org Thu Dec 06 23:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Ool-0002mE-2P
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 23:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbXLFWDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2007 17:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbXLFWDQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 17:03:16 -0500
Received: from mail.op5.se ([193.201.96.20]:51648 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbXLFWDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 17:03:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C302B1F08003;
	Thu,  6 Dec 2007 23:03:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHCleaPQVrYQ; Thu,  6 Dec 2007 23:03:13 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 91C981F08002;
	Thu,  6 Dec 2007 23:03:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <475855D6.201@imap.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67343>

Tilman Schmidt wrote:
> Am 01.12.2007 14:43 schrieb Mike Hommey:
>> On Sat, Dec 01, 2007 at 02:17:39PM +0100, Pascal Obry wrote:
>>> Tilman Schmidt a =E9crit :
>>>> I have produced a patch, submitted it to LKML, received a few
>>>> comments, committed appropriate changes to my local git tree,
>>>> and now want to submit a revised patch. How do I do that?
>>>> If I just run git-format-patch again, it produces my original
>>>> patch plus a second one containing my updates, but what I need
>>>> is a single new patch replacing the first one.
>>> Can't you merge both of your changes in your local repository? I wo=
uld
>>> do that with an interactive rebase.
>> Or just git commit --amend when committing.
>=20
> Hmm. But wouldn't each of these approaches lead to my original
> commit being removed from my git repository? And isn't removing
> commits that have already been published strongly discouraged?
>=20

The term "published" means different things for different projects.
=46or the Linux kernel, "published" is when your commit ends up in a
repository that Linus pulls from.

So long as you're getting suggestions to fix up your patch, it's
safe to assume it hasn't been accepted into one of those repos, and
you can safely --amend the offending commit(s).

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
