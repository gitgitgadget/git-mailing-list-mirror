From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comment on weak refs
Date: Sun, 10 Jun 2007 17:26:57 +0200
Organization: At home
Message-ID: <f4h581$htu$1@sea.gmane.org>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net> <7vk5ucd6of.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 17:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxPM4-0001oM-IT
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 17:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXFJP3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 11:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbXFJP3W
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 11:29:22 -0400
Received: from main.gmane.org ([80.91.229.2]:35209 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbXFJP3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 11:29:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HxPLC-0004QN-A1
	for git@vger.kernel.org; Sun, 10 Jun 2007 17:28:30 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 17:28:30 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 17:28:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49746>

Junio C Hamano wrote:

> Semantics
> ---------
>=20
> Not all "softref" relationship is equal. =A0"This object is
> referred to by these tags" is one obvious application, and only
> because we already try to follow tags when git-fetch happens
> anyway, it looks natural to make everybody follow such a softref
> relationship.

Or "this onject is referred to by these _notes_", where notes differ
from tags on what is more important: name or comment (message). For
tags most important is the name, for notes most important is the
comment (which might be bug message, but might be correction to
commit message, or additional acked-by).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
