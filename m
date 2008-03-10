From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Write diff output to a file in struct diff_options
Date: Mon, 10 Mar 2008 12:52:44 +0100
Organization: At home
Message-ID: <fr37ec$9k4$1@ger.gmane.org>
References: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 12:53:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYgZh-0007XX-5H
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbYCJLw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 07:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYCJLw4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:52:56 -0400
Received: from main.gmane.org ([80.91.229.2]:48027 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbYCJLwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:52:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JYgYk-0006pZ-6l
	for git@vger.kernel.org; Mon, 10 Mar 2008 11:52:50 +0000
Received: from abwl132.neoplus.adsl.tpnet.pl ([83.8.235.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 11:52:50 +0000
Received: from jnareb by abwl132.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 11:52:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwl132.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76721>

Daniel Barkalow wrote:

> I remember there being some expectation that this would be difficult,=
 but=20
> it was a pretty straightforward conversion, so I'm wondering if I've=20
> missed something. In any case, this is missing tests and documentatio=
n for=20
> --output=3D, but I really want it to use directly for rebase-interact=
ive,=20
> and I only did the command line option so I could do informal testing=
=2E
>=20
> =A0diff.c | =A0306 +++++++++++++++++++++++++++++++++++---------------=
--------------
> =A0diff.h | =A0 =A03 +
> =A02 files changed, 169 insertions(+), 140 deletions(-)

Errr... where is the documentation?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
