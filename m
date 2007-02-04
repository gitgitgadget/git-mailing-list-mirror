From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/8] bash: Remove short option completions for branch/checkout/diff.
Date: Sun, 04 Feb 2007 11:27:50 +0100
Organization: At home
Message-ID: <eq4ccg$9ae$1@sea.gmane.org>
References: <20070204073817.GA17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 11:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDea6-0004Ln-B6
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbXBDK0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 05:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbXBDK0o
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:26:44 -0500
Received: from main.gmane.org ([80.91.229.2]:44304 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbXBDK0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:26:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDeZv-0007Y9-0O
	for git@vger.kernel.org; Sun, 04 Feb 2007 11:26:35 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 11:26:35 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 11:26:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38680>

[Cc: git@vger.kernel.org]

Shawn O. Pearce wrote:

> The short options (-l, -f, -d) for git-branch are rather silly to
> include in the completion generation as these options must be fully
> typed out by the user and most users already know what the options
> are anyway, so including them in the suggested completions does
> not offer huge value. =A0(The same goes for git-checkout and git-diff=
=2E)

Not true. It is nice to have on "git branch -" TAB TAB list of all=20
(well, all included in completion) short options to git-branch.

So I'd vote NAK.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
