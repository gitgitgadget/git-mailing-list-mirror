From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Some ideas for StGIT
Date: Sun, 05 Aug 2007 02:17:50 +0200
Organization: At home
Message-ID: <f934ve$3oi$1@sea.gmane.org>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 02:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHTrQ-0006nh-6v
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 02:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765220AbXHEAUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765202AbXHEAUl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 20:20:41 -0400
Received: from main.gmane.org ([80.91.229.2]:58131 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757686AbXHEAUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 20:20:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IHTpG-0005My-3Q
	for git@vger.kernel.org; Sun, 05 Aug 2007 02:18:30 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 02:18:30 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 02:18:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54922>

Shawn O. Pearce wrote:

> (Regarding the performance, cherry-picking 55 patches is
> slow, especially when many of them would apply trivially with
> git-diff|git-apply --index. =A0Be nice to improve that in 1.5.4.)

Perhaps in the future you would be able to use -i/--interactive mode
in merge driven git-rebase (git rebase --merge -i <base>), which I thin=
k
should be faster.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
