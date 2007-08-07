From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] git-diff: Output a warning about stale files in the index
Date: Tue, 07 Aug 2007 11:04:33 +0200
Organization: At home
Message-ID: <f99cj0$41v$1@sea.gmane.org>
References: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net> <20070807071712.GA32751@midwinter.com> <7vbqdj7poi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 11:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIL0c-0007uk-Jd
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 11:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036AbXHGJFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 05:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758406AbXHGJFS
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 05:05:18 -0400
Received: from main.gmane.org ([80.91.229.2]:55857 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756233AbXHGJFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 05:05:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIKzt-0004Lo-A7
	for git@vger.kernel.org; Tue, 07 Aug 2007 11:05:01 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 11:05:01 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 11:05:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55236>

Junio C Hamano wrote:

> =A0 After starting to edit a working tree file but later when your
> =A0 edit ends up identical to the original (this can also happen
> =A0 when you ran a wholesale regexp replace with something like
> =A0 "perl -i" that does not touch many of the paths),

Does touch the file (makes file stat-dirty, changes file mtime),
but doesn't change it.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
