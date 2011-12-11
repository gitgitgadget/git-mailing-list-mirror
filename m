From: Jari Aalto <jari.aalto@cante.net>
Subject: git 1.7.7.3: BUG - please make git mv -f quiet
Date: Sun, 11 Dec 2011 23:22:37 +0200
Organization: Solea de Tirana
Message-ID: <877h226bxe.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 22:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZqrH-0002af-FB
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 22:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab1LKVWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 16:22:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:39325 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab1LKVWt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 16:22:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZqrA-0002YL-Oc
	for git@vger.kernel.org; Sun, 11 Dec 2011 22:22:48 +0100
Received: from a91-155-176-245.elisa-laajakaista.fi ([91.155.176.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 22:22:48 +0100
Received: from jari.aalto by a91-155-176-245.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 22:22:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-176-245.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:OVcyzaV84gX073sINxIeLHbT9N8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186816>


Every time I do:

    git mv -f FROM TO

Git displays:

    warning: destination exists; will overwrite!

Please don't display anything other than errors (no write permission....).

The "-f" is like with mv(1), cp(1); there is nothing than can be done
afterwards, so the message is redundant and obstructing.

If messages are needed, please add option:

    -v, --verbose

Jari
