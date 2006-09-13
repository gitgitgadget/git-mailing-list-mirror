From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 23:02:46 +0200
Organization: At home
Message-ID: <ee9rl3$c4o$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz93a9v9.fsf@assigned-by-dhcp.cox.net> <ee9jv6$ga0$1@sea.gmane.org> <7vbqpja8wz.fsf@assigned-by-dhcp.cox.net> <ee9mff$qd1$1@sea.gmane.org> <7vhczb7ay9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 13 23:03:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbsy-0006NE-Lb
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWIMVDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Sep 2006 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWIMVDF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:03:05 -0400
Received: from main.gmane.org ([80.91.229.2]:46473 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751195AbWIMVDD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 17:03:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNbsY-0006IJ-Be
	for git@vger.kernel.org; Wed, 13 Sep 2006 23:02:44 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:02:42 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:02:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26943>

Junio C Hamano wrote:

>> ... wouldn't refs cache (similar to current index for files) be
>> better idea?
>=20
> The ideal is to make a fast and easy way for Porcelains to
> access what they want to know about the refs without knowing
> their implementation. =A0We already provide ways to do so except
> that they may not be fast nor easy. =A0And the "may not be fast"
> part is what triggers 'cache would be better' reaction, but the
> right thing to do is not to work it around with a clutch, but to
> design what an appropriate core side support is and implement
> it.

The 'cache would be better' is because it is obviously backward
compatibile (which helps the porcelains and history viewers),
avoids some trouble with deleting (and renaming) branches, can
be fast (when used), and we can use symlinks/symrefs with it I guess.=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
