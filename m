From: Jari Aalto <jari.aalto@cante.net>
Subject: 1.7.7.3 wishlist: add --verbose option to git-tag
Date: Sat, 31 Dec 2011 01:32:19 +0200
Organization: Solea de Tirana
Message-ID: <87d3b51vr0.fsf@cante.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 00:32:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RglwI-00086N-4Y
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 00:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1L3Xcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 18:32:35 -0500
Received: from lo.gmane.org ([80.91.229.12]:50520 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab1L3Xcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 18:32:33 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rglw8-0007zu-3T
	for git@vger.kernel.org; Sat, 31 Dec 2011 00:32:32 +0100
Received: from a91-155-176-245.elisa-laajakaista.fi ([91.155.176.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 00:32:31 +0100
Received: from jari.aalto by a91-155-176-245.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 00:32:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-176-245.elisa-laajakaista.fi
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:b3MbwIv1C0EKNXkQDGWw+N+k9L0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187809>


In scripts it would be useful if "git tag" would provide option:

    --verbose

As in script:

    git tag --verbose -m "Initial import" upstream/1.0

It would also help if all commands would use similar interface. In "git
tag" case, this would meen relocating:

    -v      =>      -g, --verify-gpg

And reserve these:

    -v, --verbose

Jari
