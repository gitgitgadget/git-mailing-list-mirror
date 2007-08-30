From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 12:25:11 +0200
Message-ID: <864pihjp4o.fsf@lola.quinscape.zz>
References: <lkbtwek0.fsf@cante.net> <Pine.LNX.4.64.0708301107320.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 12:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQhDX-0004Zj-7X
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 12:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbXH3KZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 06:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbXH3KZf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 06:25:35 -0400
Received: from main.gmane.org ([80.91.229.2]:38565 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbXH3KZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 06:25:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQhDI-0003dQ-5l
	for git@vger.kernel.org; Thu, 30 Aug 2007 12:25:24 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 12:25:24 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 12:25:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:lWsOZq+fEvtA40XhsmGCiImmi0o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57020>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 30 Aug 2007, Jari Aalto wrote:
>
>> git-gc is a higher level utility to "do the right thing". However there 
>> are many other lower level utilities for the house keeping and it is not 
>> clear what git-gc actually does. Adding the actual lower level command 
>> and their parameters explain "what's going on".x
>
> Isn't the whole purpose of git-gc to make it _unnecessary_ to know which 
> lowlevel commands are run?

Unnecessary and undocumented are two different things.  I think it
very reasonable to document what exactly git-gc does and what it is
equivalent to.  So in principle,

Acked-by: David Kastrup <dak@gnu.org>

However, since this is detail information, it may be appropriate to
put this into a footnote and/or compress the copious number of empty
lines in it: that would better maintain the relation with the rest of
the entry.

-- 
David Kastrup
