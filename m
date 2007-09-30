From: Wincent Colaiuta <win@wincent.com>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 14:45:34 +0200
Message-ID: <912CB4AE-83B9-42D7-A591-E721D1E22439@wincent.com>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <20070929090121.GA4216@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 14:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbyBG-0008L0-UM
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 14:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbXI3Mpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2007 08:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbXI3Mpq
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 08:45:46 -0400
Received: from wincent.com ([72.3.236.74]:37340 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535AbXI3Mpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2007 08:45:45 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8UCjfMs028961;
	Sun, 30 Sep 2007 07:45:42 -0500
In-Reply-To: <20070929090121.GA4216@artemis.corp>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59536>

El 29/9/2007, a las 11:01, Pierre Habouzit escribi=F3:

>   Many git commands output are still messy and indeed, having them =20
> in C
> should help in that regard. The usual culprit are I think:
>
>   * git fetch/clone/pull/.. ;
>   * git push ;
>   * git repack/gc/... ;
>   * git merge (even with the merge.verbosity set to the minimum it's
>     still not very readable and confusing).
>
>
>   I do believe that the quite verbose output git commands sometimes =20
> have
> is quite confusing, and let the user think it's messy. I believe that
> porcelains should be more silent, it's OK for the plumbing to spit
> progress messages and so on, because people using the plumbing are =20
> able
> to understand those, but porcelains should not.

I think that most people just want to know, "Did it work or not?" and =20
so when the commands chatter too much they go into filter mode, don't =20
really read the output, let alone try to understand it, and just skim =20
it. Ideally Git would be much less "chattery" in general when things =20
work, and only be more verbose when things go wrong; of course, =20
finding that balance point is where the art lies.

Wincent
