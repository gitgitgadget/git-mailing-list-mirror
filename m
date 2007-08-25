From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 02:02:57 +0900
Message-ID: <fapnd0$rpp$1@sea.gmane.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>	<20070824062106.GV27913@spearce.org>	<9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>	<alpine.LFD.0.999.0708241618070.16727@xanadu.home>	<9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>	<9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>	<fanmmk$f5q$1@sea.gmane.org>	<9e4733910708241646x7b285574t94c3d7eb32bb60c9@mail.gmail.com> <7v1wdscwd4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 19:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOz3S-0000iU-AS
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 19:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbXHYRDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbXHYRDo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 13:03:44 -0400
Received: from main.gmane.org ([80.91.229.2]:37854 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbXHYRDn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 13:03:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOz2z-00011Q-Rt
	for git@vger.kernel.org; Sat, 25 Aug 2007 19:03:41 +0200
Received: from 221x115x75x108.ap221.ftth.ucom.ne.jp ([221.115.75.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 19:03:41 +0200
Received: from salikh by 221x115x75x108.ap221.ftth.ucom.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 19:03:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 221x115x75x108.ap221.ftth.ucom.ne.jp
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
In-Reply-To: <7v1wdscwd4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56644>

Junio C Hamano wrote:
> But I do not think "majority is initial clone" is the norm.
> Even among the people who does an "initial clone" (from the
> end-user perspective), what they do may not be the initial full
> clone your special hack helps (and that was one of the reasons
> we dropped the pre-prepared pack support --- "been there, done
> that" to some extent).

FWIW, on my previous job release engineering team used git
in a special way involving lots of initial clones. 

The project itself was kept under SVN, and several machines
were doing continuous builds, starting from scratch.
Unfortunately, doing from scratch checkouts from SVN was not
an option because of high SVN checkout overhead, and machines
did a git-clone of imported repository instead.

Obviously using --reference would have saved even more on initial clone,
but the release team consisting of a pregnant woman and an
intern student had neither time nor inclination to learn
git any deeper than were strictly necessary to get the job done.
Apparently, pure git-clone performance was good enough.
