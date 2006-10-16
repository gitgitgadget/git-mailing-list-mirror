From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 18:54:08 +0200
Organization: At home
Message-ID: <eh0del$g4t$1@sea.gmane.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org> <Pine.LNX.4.64.0610160920250.7697@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Oct 16 18:54:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVix-0001QH-8n
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWJPQxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Oct 2006 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbWJPQxz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:53:55 -0400
Received: from main.gmane.org ([80.91.229.2]:41346 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964770AbWJPQxy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 12:53:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZVim-0001Ng-G7
	for git@vger.kernel.org; Mon, 16 Oct 2006 18:53:48 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 18:53:48 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 18:53:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28971>

<opublikowany i wys=B3any>

Davide Libenzi wrote:

> The test is fine as is. Only really bad hash collisions can show O(M*=
N).=20
> Can I have the two sample files to test?

Jim Meyering wrote:

> =A0 http://meyering.net/code/git-perf/configure.gz
> =A0 http://meyering.net/code/git-perf/configure-curr.gz

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
