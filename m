From: =?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>
Subject: Clarification on the git+ssh and ssh+git schemes
Date: Fri, 5 Feb 2016 09:33:06 -0800
Message-ID: <62DF0D5B-83DF-465D-9786-A4E7DA97F2BA@dwim.me>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 18:33:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRkG0-0007wX-Id
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 18:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbcBERdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 12:33:12 -0500
Received: from hessy.dwim.me ([78.47.67.53]:35729 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbcBERdK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 12:33:10 -0500
Received: from [172.31.25.155] (GITHUB-INC.bar1.SanFrancisco1.Level3.net [4.53.133.38])
	by hessy.dwim.me (Postfix) with ESMTPSA id 83DB98153D
	for <git@vger.kernel.org>; Fri,  5 Feb 2016 18:33:08 +0100 (CET)
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285590>

Hello gits,

git supports using git+ssh:// and ssh+git:// instead of ssh:// or the r=
sync-style format. The first two are however not documented in the git-=
clone manage as acceptable protocols (which is what I think of as the c=
anonical source for what you can use). There are tests to make sure the=
se are supported, but even the commit that allows for this (c05186cc; S=
upport git+ssh:// and ssh+git:// URL) makes it pretty clear it=E2=80=99=
s not something that=E2=80=99s considered sensible.

But in either case, if we=E2=80=99re going to support it, it should be =
documented. If we don=E2=80=99t want to support it, then we should dele=
te the references to these formats along with the tests for this.

I=E2=80=99m happy to write a patch going in either direction, but I=E2=80=
=99d like some input from the community as to what we want to do.

Cheers,
   cmn
