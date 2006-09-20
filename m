From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: pseudo initial empty commit and tag for git-log and
	git-describe?
Date: Wed, 20 Sep 2006 16:10:00 +0200
Message-ID: <1158761400.6516.25.camel@localhost.localdomain>
References: <fcaeb9bf0609200658p3f04df7oe91ddb971787bd70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 16:10:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ2mI-0001O2-Ec
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 16:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWITOKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Sep 2006 10:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWITOKM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 10:10:12 -0400
Received: from elephant.oekohosting.ch ([80.74.144.79]:2688 "EHLO
	elephant.oekohosting.ch") by vger.kernel.org with ESMTP
	id S1751535AbWITOKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 10:10:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 8751B62C186;
	Wed, 20 Sep 2006 16:10:09 +0200 (CEST)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32453-01; Wed, 20 Sep 2006 16:10:09 +0200 (CEST)
Received: from [192.168.1.7] (18.51.203.62.cust.bluewin.ch [62.203.51.18])
	by elephant.oekohosting.ch (Postfix) with ESMTP id E180D62C183;
	Wed, 20 Sep 2006 16:10:00 +0200 (CEST)
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0609200658p3f04df7oe91ddb971787bd70@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27346>

hello

On Wed, 2006-09-20 at 20:58 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> I'm still uncomfortable with git-log -p unable to show the first
> commit (git-whatchanged too). Also git-describe refuses to work
> without any tag. I'm thinking about adding a pseudo empty commit
> together with a tag so that these commands work. The commit and tag
> will be created at runtime. They do not actually exist in the object
> database. I haven't thought about how to implement it yet.
> Any other ideas?

you can use git log -p --root  to also display the root commit.

	Matthias
