From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 12:02:46 +0100
Organization: At home
Message-ID: <fgcbjr$3pc$1@ger.gmane.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 12:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InXmu-0001vk-0x
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 12:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbXKALAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2007 07:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbXKALAU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 07:00:20 -0400
Received: from main.gmane.org ([80.91.229.2]:36822 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbXKALAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 07:00:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1InXma-0007DE-RY
	for git@vger.kernel.org; Thu, 01 Nov 2007 11:00:16 +0000
Received: from abvb125.neoplus.adsl.tpnet.pl ([83.8.199.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 11:00:16 +0000
Received: from jnareb by abvb125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 11:00:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvb125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62935>

Junio C Hamano wrote:

> * jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
> =A0+ rebase: allow starting from a dirty tree.
> =A0+ stash: implement "stash create"
>=20
> Will revert at least the latter one, but perhaps both, from
> 'next'. =A0The traditional behaviour of refusing to work in a
> dirty tree is much safer, as the tool cannot decide where to
> unstash for you.

One of frequently requested features is ability to rebase and merge
in a dirty tree (CVS-like). Perhaps we should advocate git-stash better=
,
e.g. in error message for git-rebase / git-merge / git-pull when in dir=
ty
state.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
