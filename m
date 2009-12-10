From: Jari Aalto <jari.aalto@cante.net>
Subject: FEATURE REQUEST: display <commit SHA> in message: git tag -d
Date: Thu, 10 Dec 2009 12:06:56 +0200
Message-ID: <87ljhb87nj.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 11:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIfvp-0008Uh-Hs
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 11:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbZLJKHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933174AbZLJKHV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 05:07:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:56136 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933113AbZLJKHU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 05:07:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NIfvh-0008QT-AG
	for git@vger.kernel.org; Thu, 10 Dec 2009 11:07:25 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 11:07:25 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 11:07:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:/Z1l6CpwrsL54LrCDbJq+74CqR4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135016>


It would be helpful if the delete command would displayed the SHA:

    $ git tag -d foo/20060213-1
    Deleted tag 'foo/20060213-1'

    ...  oops, I didn't want to do that
    ...  Whatwas the commit ID again that I can restore the tag?

Instead:

    $ git tag -d foo/20060213-1
    Deleted tag 'foo/20060213-1' 4b397f6

    ...  oops, I didn't want to do that

    $ git tag 'foo/20060213-1' 4b397f6

    ... retagged, phew.

Notice that the message is in the format of copy/paste for immediate
retagging.

Jari
