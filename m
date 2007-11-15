From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 11:14:56 +0100
Message-ID: <86hcjn4xy7.fsf@lola.quinscape.zz>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	<7voddv6fxz.fsf@gitster.siamese.dyndns.org>
	<buozlxfeu0z.fsf@dhapc248.dev.necel.com>
	<995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com>
	<buotznnesw9.fsf@dhapc248.dev.necel.com> <473C1A29.2010703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 11:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsblL-00013K-JT
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 11:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbXKOKPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 05:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbXKOKPR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 05:15:17 -0500
Received: from main.gmane.org ([80.91.229.2]:52509 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757613AbXKOKPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 05:15:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Isbka-0000I3-Dk
	for git@vger.kernel.org; Thu, 15 Nov 2007 10:15:08 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 10:15:08 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 10:15:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <473C1A29.2010703@op5.se> (Andreas Ericsson's message of "Thu\, 15 Nov 2007 11\:06\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:abgLTklFKnoWarRJK2vIq0+ePWQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65104>

Andreas Ericsson <ae@op5.se> writes:

>> Wincent Colaiuta <win@wincent.com> writes:
>>> +		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"
>
> It says "remove refs/heads/ from the beginning of the string pointed
> to by $head".
>
> It's not a bashism. Some extensions to that syntax are though (I
> think).

General replace anywhere.

> If you want to be sure of portability, use sed instead.

Guffaw.

> git uses this syntax often enough that it's worth using everywhere,
> but usually only in porcelain commands which one can relatively
> safely assume are run on at least decently up-to-date developer
> workstations.

Huh?  It is used throughout.  That's why "make install" will install
xxx.sh scripts as xxx after possibly replacing the initial #!/bin/sh
line with a shell known to be reasonably conformant on a particular
system.

-- 
David Kastrup
