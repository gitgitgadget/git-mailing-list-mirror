From: Paul Ebermann <Paul-Ebermann@gmx.de>
Subject: Re: Getting git to help my memory
Date: Wed, 06 Jul 2011 00:08:37 +0200
Message-ID: <4E138B65.5000500@gmx.de>
References: <loom.20110705T232905-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Evan Driscoll <driscoll@cs.wisc.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 00:08:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeDnS-0000ZH-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 00:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1GEWIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jul 2011 18:08:41 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:51209 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751444Ab1GEWIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 18:08:40 -0400
Received: (qmail invoked by alias); 05 Jul 2011 22:08:37 -0000
Received: from stilgar.mathematik.hu-berlin.de (EHLO [141.20.50.149]) [141.20.50.149]
  by mail.gmx.net (mp063) with SMTP; 06 Jul 2011 00:08:37 +0200
X-Authenticated: #2289940
X-Provags-ID: V01U2FsdGVkX1+ElZ5+SOKExXi8qy3UK9aOkT/HAvthBeoZx5yiR4
	gs834jJNVY/CEu
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.19) Gecko/20110420 SUSE/2.0.14-0.2.1 SeaMonkey/2.0.14
In-Reply-To: <loom.20110705T232905-603@post.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176629>

Evan Driscoll schrieb:
> I have a somewhat unusual question. I often forget to push after comm=
itting,
> and a few times this has come back to bite me. (One time I didn't eve=
n really
> realize for a couple months because I was working on other stuff, so
> unraveling the conflicts was "fun".)
>=20
> Is there a way I can get git to print a "don't forget to push!" remin=
der
> after it commits?
>=20
> The best way I can think of is to put a post-commit hook in there. I =
haven't
> tried it but I'd assume it would work, but would have to be on a
> per-repository basis instead of global.

Yes, I just tried this. Here is the output (from adding a file in the t=
est branch):

---
$ git commit=20
Don't forget to push!
[test ceabc34] adding test.txt.
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
---

The output is a bit hidden here. Maybe coloring would help here a bit.


Is it really intentional that post-commit is called
*before* the informational output here?

I have no idea on how to automatically add the hooks to all
the repositories - AFAIK git clone will not copy these.


Pa=C5=ADlo
