From: Jari Aalto <jari.aalto@cante.net>
Subject: FEATURE REQUEST: Allow SSH style URLS (with extra colon)
Date: Sat, 30 Jan 2010 18:57:56 +0200
Message-ID: <87tyu3cyy3.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 17:58:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbGeR-0004UE-LN
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 17:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab0A3Q6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 11:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815Ab0A3Q6U
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 11:58:20 -0500
Received: from lo.gmane.org ([80.91.229.12]:39137 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab0A3Q6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 11:58:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NbGeH-0004NE-Ny
	for git@vger.kernel.org; Sat, 30 Jan 2010 17:58:17 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 17:58:17 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 17:58:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:wrkB5+IusV2aawDMDpD73GhIow8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138485>


According to git-clone[1] the SSH protocol is specied as:

    ssh://[user@]host.xz[:port]/path

It woudl be nice if the ":" were allowed, so that the familiar SSH style
patch notation could be used, making the spec:

    ssh://[user@]host.xz[:[port]]/path

An example:

    ssh://foo@examplecom:/path
                        |
                        Allowed

Jari

[1] http://www.kernel.org/pub/software/scm/git/docs/git-clone.html
