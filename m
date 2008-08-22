From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 22:36:06 +0200
Message-ID: <20080822203606.GB1598@atjola.homenet>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <4d8e3fd30808221311w7c507abboecd0893def85a073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdNl-0003Ap-Mz
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbYHVUgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 16:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbYHVUgL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:36:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:35718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754632AbYHVUgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:36:10 -0400
Received: (qmail invoked by alias); 22 Aug 2008 20:36:08 -0000
Received: from i577B8611.versanet.de (EHLO atjola.local) [87.123.134.17]
  by mail.gmx.net (mp020) with SMTP; 22 Aug 2008 22:36:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18NR9FJdy4N21DtF6upEMXVZIJI6i8VtVWW+Be8CT
	RSogigdSaeHqS3
Content-Disposition: inline
In-Reply-To: <4d8e3fd30808221311w7c507abboecd0893def85a073@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93359>

On 2008.08.22 22:11:42 +0200, Paolo Ciarrocchi wrote:
> since tip/master is often rebased (as pu or linux-next) what I do is
> the following:
> git branch -D tip-latest
> git checkout -b tip-latest tip/master
>=20
> but I guess lot of people would expect to "throw away" and "checkout
> again" with a single git command.

git reset --hard tip/master

or just don't create a local branch at all and do testing on a detached
HEAD, ie. just:
git checkout tip/master

That works after each fetch.

Bj=F6rn
