From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 22:43:45 +0200
Organization: At home
Message-ID: <ee9qhf$71n$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com> <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com> <46a038f90609131331p25923440w45eb49b56933f24b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 13 22:44:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbaS-0002lF-DS
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWIMUn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Sep 2006 16:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWIMUn4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 16:43:56 -0400
Received: from main.gmane.org ([80.91.229.2]:34015 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751183AbWIMUnz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 16:43:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNba9-0002he-Jf
	for git@vger.kernel.org; Wed, 13 Sep 2006 22:43:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 22:43:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 22:43:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26940>

Martin Langhoff wrote:

> I guess what people are pointing at is that you can:
>=20
> =A0- run your import
> =A0- publish that as mozilla-historical.git
> =A0- copy that to mozilla.git
> =A0- rm all the old heads from mozilla.git
> =A0- rm all the 'new' heads from mozilla-historical.git
> =A0- run git-repack -a -d on both
> =A0- make the historical repo read-only

Instead of copying mozilla-historical.git to mozilla.git,
it would be better to clone using --shared option
(which sets up appropriate alternates file). Of course both
repositories should be on the same machine for this to work,
and no, one wouldn't need to copy/clone them both.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
