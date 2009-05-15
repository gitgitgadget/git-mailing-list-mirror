From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] improved validation of entry type in mktree
Date: Fri, 15 May 2009 08:23:46 +0200
Organization: At home
Message-ID: <guj1pi$tbk$1@ger.gmane.org>
References: <loom.20090514T050424-673@post.gmane.org> <loom.20090514T051052-920@post.gmane.org> <7vd4acxkug.fsf@alter.siamese.dyndns.org> <a644352c0905141546w4193d45aq4940e72bbb4bda1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 08:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4qpy-0003Oj-9x
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 08:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbZEOGX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 02:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbZEOGX4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 02:23:56 -0400
Received: from main.gmane.org ([80.91.229.2]:53426 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbZEOGX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 02:23:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M4qpp-0004j1-CO
	for git@vger.kernel.org; Fri, 15 May 2009 06:23:57 +0000
Received: from abwb23.neoplus.adsl.tpnet.pl ([83.8.225.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2009 06:23:57 +0000
Received: from jnareb by abwb23.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2009 06:23:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwb23.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119247>

Josh Micich wrote:

> Furthermore even with '--missing', a tree entry like this should be r=
ejected:
> 160000 commit e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 =A0foo

But with submodules you might not _have_ e69de29b in object database
to check its type!
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
