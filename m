From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 12:24:44 +0200
Organization: At home
Message-ID: <ecc1ks$t3p$1@sea.gmane.org>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com> <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain> <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com> <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain> <9e4733910608180956n64e3362fm5c72d652e6b6243a@mail.gmail.com> <Pine.LNX.4.64.0608202257020.3682@localhost.localdomain> <20060821064659.GB24054@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Aug 21 12:24:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF6xa-0003um-CC
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 12:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWHUKYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 06:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWHUKYn
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 06:24:43 -0400
Received: from main.gmane.org ([80.91.229.2]:436 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751842AbWHUKYm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 06:24:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GF6xR-0003sb-Hl
	for git@vger.kernel.org; Mon, 21 Aug 2006 12:24:37 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 12:24:37 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 12:24:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25794>

Shawn Pearce wrote:

> =A0- the strategy of how I'm slamming a very large number of objects
> =A0 =A0into a pack may be useful in situations other than a foreign
> =A0 =A0SCM import process. =A0I can see someone wanting to create a
> =A0 =A0large commit with a lot of modified objects. =A0Doing this wit=
h
> =A0 =A0update-index and write-tree into loose objects would be far
> =A0 =A0slower than just generating a new pack if the number of object=
s
> =A0 =A0you are writing exceeds about 100 on Windows or ~1k on UNIX;

Like e.g. initial import of large project, or incorporating some subpro=
ject
into a projects (e.g. gitk and gitweb in git)?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
