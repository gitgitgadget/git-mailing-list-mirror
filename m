From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 16:58:59 +0200
Organization: At home
Message-ID: <ed1kn3$c3r$1@sea.gmane.org>
References: <20060829134233.GA21335@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 29 17:00:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI54a-0004po-NZ
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 17:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWH2O77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 Aug 2006 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWH2O77
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 10:59:59 -0400
Received: from main.gmane.org ([80.91.229.2]:1416 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965020AbWH2O76 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 10:59:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GI53r-0004bw-GK
	for git@vger.kernel.org; Tue, 29 Aug 2006 16:59:32 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 16:59:31 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 16:59:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26207>

Shawn Pearce wrote:

> From a data locality perspective putting the base object before
> or after the delta shouldn't matter, as either way the delta
> is useless without the base. =A0So placing the base immediately
> before the delta should perform just as well as placing it after.
> Either way the OS should have the base in cache by the time the
> delta is being accessed.

_Should_ perform? Have you got any measurements of speed of creating "b=
ase
before delta" pack, and reading objects from this kind of pack?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
