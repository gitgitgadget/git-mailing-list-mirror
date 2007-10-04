From: David Kastrup <dak@gnu.org>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 04 Oct 2007 16:47:10 +0200
Message-ID: <86hcl70wep.fsf@lola.quinscape.zz>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com> <20071004125641.GE15339@genesis.frugalware.org> <7vy7ej9g38.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710041534000.4174@racer.site> <7vhcl79c4l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 17:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSIQ-0001QB-LA
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbXJDPHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 11:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbXJDPHR
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:07:17 -0400
Received: from main.gmane.org ([80.91.229.2]:34917 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684AbXJDPHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:07:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IdS2v-00055T-Gn
	for git@vger.kernel.org; Thu, 04 Oct 2007 14:51:25 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:51:25 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:51:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:ZP6pYPS47aFeTfazdF+WqkehJ/0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59961>

Junio C Hamano <gitster@pobox.com> writes:

>  * --index means work work tree through the index.  Once you get
>    git, this is natural as you would not interact with files in
>    the work tree that is not known to the index.
>
>  * --cached means work only on the cached information in index.

That is a rather shaky relation.

> Giving them synonyms without deprecation is a viable option, if
> necessary.  I do not however see the need yet.  A few people who
> haven't learned the lingo of the land yet can worry about possible
> confusion, but I do not think that "worry" itself does not count as
> real need.

The "lingo of the land" as documented in the manuals no longer uses
the term "cache" or "cached" as something with an official meaning.

So the current state of affairs does not really look overly convincing
with regard to consistency.

-- 
David Kastrup
