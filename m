From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Thu, 07 Feb 2008 10:01:32 +0200
Organization: Private
Message-ID: <ve51w5yb.fsf@blue.sea.net>
References: <20080205211044.GP26392@lavos.net>
	<7vodatqu6w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 09:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN1ii-0008HW-Ch
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 09:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbYBGICX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 03:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYBGICX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 03:02:23 -0500
Received: from main.gmane.org ([80.91.229.2]:47884 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbYBGICW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 03:02:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JN1i7-0004Dv-0a
	for git@vger.kernel.org; Thu, 07 Feb 2008 08:02:19 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 08:02:19 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 08:02:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:2TzBwqZ3+GsIouGSwQL9GGLfZ8M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72906>

* Wed 2008-02-06 Junio C Hamano <gitster@pobox.com>
* Message-Id: 7vodatqu6w.fsf@gitster.siamese.dyndns.org
> I picked up the qsort patch from Brian while reading the list
> via gmane's newsfeed and applied it without realizing that it
> was one of the articles whose addresses on all the address
> header fields _and_ all strings that look like e-mail addresses
> have been mangled by gmane.  Sign-offs by Dscho and Steffen

FYI,

Emacs Gnus + news.gmane.org gives access to raw articles with single
command. Suppose cursor is at thread start "!"

! R. [  40: Junio C Hamano         ] Applying patches from gmane can be dangerous.
  R.     [  19: Nicolas Pitre          ]


Pressing "C-u g" will display the unmodified article as seen by mail
transport. Running git's apply command can be automated pretty easily
from there.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
