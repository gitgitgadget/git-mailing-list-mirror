From: Jari Aalto <jari.aalto@cante.net>
Subject: FEATURE REQUEST: Announce branch name with merge comamnd
Date: Fri, 11 Dec 2009 20:55:50 +0200
Message-ID: <87zl5p1gsp.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 19:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJAfA-0002Eo-8x
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 19:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758950AbZLKS4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 13:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758866AbZLKS4M
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 13:56:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:59172 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758394AbZLKS4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 13:56:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NJAf2-0002Aq-Af
	for git@vger.kernel.org; Fri, 11 Dec 2009 19:56:16 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 19:56:16 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 19:56:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:BvxVf+LdKE6JOHXpEvkhQArRUfY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135099>


Doing octopus merge results:

    $ git merge ...

    Trying simple merge with c87c49b1e413e5dc378d7e6b16951761a1e82f6d
    Trying simple merge with b650c8c8809ef493ad4128fc941ed6b520c82f28
    Trying simple merge with 047f83d6c8a08c4016004780e94257d9e487b7e6
    Simple merge did not work, trying automatic merge.
    Auto-merging example.jwmrc
    Trying simple merge with 16860b016e198acd0814492092e2ad5ea88fb219
    Simple merge did not work, trying automatic merge.
    Auto-merging example.jwmrc
    Trying simple merge with 9a397ff24a381ce49dd093c4f51c06c4c62f3ce7
    Simple merge did not work, trying automatic merge.
    ...

SUGGESTION

Please announce the branch name being merged so that the listing is
easier to follow (possibly only with --verbose, -v option). Add
"Branch: <name>" just before the merge is attempted. somethiglike this

    Branch: bug--manpage-fix-hyphen
    Trying simple merge with c87c49b1e413e5dc378d7e6b16951761a1e82f6d
    Branch: bug--manpage-fix-TH
    Trying simple merge with b650c8c8809ef493ad4128fc941ed6b520c82f28
    Branch: bug-manpage-change-binary-name
    Trying simple merge with 047f83d6c8a08c4016004780e94257d9e487b7e6
    Branch: feature--example.jwmrc-change-browser
    Simple merge did not work, trying automatic merge.
    Auto-merging example.jwmrc
    Branch: feature--example.jwmrc-change-clock
    Trying simple merge with 16860b016e198acd0814492092e2ad5ea88fb219
    Simple merge did not work, trying automatic merge.
    Auto-merging example.jwmrc
    Branch: feature--example.jwmrc-change-font
    Trying simple merge with 9a397ff24a381ce49dd093c4f51c06c4c62f3ce7
    Simple merge did not work, trying automatic merge.
    ...
