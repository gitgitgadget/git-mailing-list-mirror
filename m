From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Tue, 29 May 2007 09:04:09 +0200
Organization: At home
Message-ID: <f3givk$1sn$1@sea.gmane.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705281840.50814.johan@herland.net> <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org> <200705281948.27329.johan@herland.net> <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net> <20070528213511.GB7044@spearce.org> <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org> <20070529032221.GE7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 09:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from [209.132.176.167] (helo=vger.kernel.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsvh9-00025h-Lk
	for gcvg-git@gmane.org; Tue, 29 May 2007 09:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbXE2HAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 May 2007 03:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbXE2HAX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 03:00:23 -0400
Received: from main.gmane.org ([80.91.229.2]:39760 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbXE2HAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 03:00:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsvgD-00077p-0Q
	for git@vger.kernel.org; Tue, 29 May 2007 08:59:41 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 08:59:41 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 08:59:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48668>

Shawn O. Pearce wrote:

> Which is why we:
>=20
> =A0 a) allow these things to migrate into packed-refs, because
> =A0 getting into there is a hellva lot cheaper than getting into
> =A0 a packfile;
>=20
> =A0 b) move them into a packfile when we repack loose objects,
> =A0 because then we have really good access.
>=20
> =A0 c) take them out of packed-refs once they are into a packfile,
> =A0 and get them out of the loose refs/notes directory as early as
> =A0 possible.

Three-tier layout? Loose note refs -> packed refs -> packfile?=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
