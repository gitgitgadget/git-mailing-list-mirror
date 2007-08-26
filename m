From: Jari Aalto <jari.aalto@cante.net>
Subject: [RFC] Branch naming -- allowed characters?
Date: Sun, 26 Aug 2007 11:54:43 +0300
Organization: Private
Message-ID: <bqcuhe0c.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 10:51:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPDpt-0006Ut-NW
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 10:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXHZIun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 04:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbXHZIun
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 04:50:43 -0400
Received: from main.gmane.org ([80.91.229.2]:46220 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbXHZIum (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 04:50:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPDpL-0002Fm-L5
	for git@vger.kernel.org; Sun, 26 Aug 2007 10:50:35 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 10:50:35 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 10:50:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:TRPh5TB1o3Fm4s+Q9CHY4JJDXHs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56679>


I just noticed this while trying to track quilt project and making a
local branch with name '.pc':

    'fatal: '.pc' is not a valid branch name.'

Would it be possible to allow using arbitrary names with branches in
future git, even UTF-8?

If that is not possible, would it be possible to at least broaden the
charcter set with regular typeable US ascii letters, excluding the
control ones. Something found in filenames/URLs. Like regexp:

    [][{}()_=+%!&@#~*.:;,/A-Za-z-]

Jari

[*] Emacs even saves with names like: *Messages*
