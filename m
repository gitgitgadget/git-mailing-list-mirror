From: Yuriy Kaminskiy <yumkam@mail.ru>
Subject: Re: 'Deepen' after "git clone --depth=1"?
Date: Mon, 01 Mar 2010 14:13:18 +0300
Message-ID: <hmg7gf$gq9$1@dough.gmane.org>
References: <81f018ac1002281955g1461abb3q815f9a45c13fb515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 12:20:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm3fY-0001UX-JN
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 12:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab0CALUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 06:20:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:49427 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab0CALUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 06:20:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nm3fP-0001Pa-4L
	for git@vger.kernel.org; Mon, 01 Mar 2010 12:20:03 +0100
Received: from ppp79-139-243-63.pppoe.spdop.ru ([79.139.243.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 12:20:03 +0100
Received: from yumkam by ppp79-139-243-63.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 12:20:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: ppp79-139-243-63.pppoe.spdop.ru
User-Agent: Icedove 1.5.0.14eol (X11/20090105)
In-Reply-To: <81f018ac1002281955g1461abb3q815f9a45c13fb515@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141317>

On 01.03.2010 06:55, Phil Miller wrote:
> Suppose I want to make a shallow clone of a repository for some
> size-sensitive application. I may later want to fill out the complete
> history of that repository, so that I can work with it as if I had
> done a full-depth clone to begin with. Is there an existing porcelain
> command/option to produce that effect? If not, is there a fundamental
> reason why this couldn't be implemented? It looks like this is
> something fetch-pack should be able to do, but its documentation
> doesn't seem to describe how. Also, the man page for fetch appears to
> lie, in that --depth=n (where n is greater than the clone depth)
> doesn't have any noticeable effect.

Last time I've tried (1.6.x),
   git fetch --depth=n
indeed, did nothing, but
   git fetch --depth=n origin master
worked (deepened history; but it seems it redownloaded (some) objects).

> If the answer is simply "no one's written the code to do it yet", I'll
> be happy to provide the necessary round tuits.
