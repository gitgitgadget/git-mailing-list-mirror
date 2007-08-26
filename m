From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Improve error message: not a valid branch name
Date: Mon, 27 Aug 2007 01:09:20 +0300
Organization: Private
Message-ID: <ejhqeynj.fsf@cante.net>
References: <y7fyfh7x.fsf@cante.net>
	<7vd4xang1n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 00:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPQEZ-0005pD-TK
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbXHZWFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 18:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbXHZWFW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 18:05:22 -0400
Received: from main.gmane.org ([80.91.229.2]:46088 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbXHZWFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 18:05:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPQEN-00038F-7Y
	for git@vger.kernel.org; Mon, 27 Aug 2007 00:05:15 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 00:05:15 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 00:05:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:PNLOfsjrVD+MeUcDQV08EZy9P+Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56739>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> (create_branch): Extend die message from 'is not a valid branch name'
>> to '...(see git-check-ref-format)'.
>
> I think you meant to say "see git-check-ref-format(1)" as you
> meant the manual page.

Yes.

> I am a bit torn on this.  git-check-ref-format.1 is where we
> currently _happen_ to describe what valid refnames should look
> like, but it could be argued that it is a bug in the manual.
>
> Two possible improvements that are mutually incompatible would
> be:
>
>  - refactor that part of the manual to be included in the pages
>    for any and all commands that can take refname from the user;
>    this is inpractical as almost all command would be affected.
>
>  - move that to more central place, say git(7), and everybody
>    refer to that page;
>
> I'd personally prefer the latter, as "naming things" is such a
> central thing for the use of the system (this applies to the
> description of "SHA-1 expression" that we curently have in
> git-rev-parse(1) as well) and it is better for users to have
> understanding of such fundamental syntaxes and concepts before
> even using any individual commands.

Wholeheartedly concur.

Should I re-submit the patch to refer to git(7) instead?

Jari
