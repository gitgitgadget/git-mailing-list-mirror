From: Jari Aalto <jari.aalto@cante.net>
Subject: git-rev-parse(1) questions
Date: Mon, 30 Apr 2007 21:24:52 +0300
Organization: Private
Message-ID: <mz0pwwi3.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 20:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiaZN-0003Yd-Lz
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 20:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423535AbXD3SZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 14:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423614AbXD3SZr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 14:25:47 -0400
Received: from main.gmane.org ([80.91.229.2]:50051 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423579AbXD3SZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 14:25:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HiaZ6-0002QE-B3
	for git@vger.kernel.org; Mon, 30 Apr 2007 20:25:36 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 20:25:36 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 20:25:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:k90hVsQ0C3Dm3IsOYI25xCDLA9I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45872>


Could someone provide example commands where and how to use these:

    * A suffix ^ followed by an empty brace pair (e.g. v0.99.8^{})
      means the object could be a tag, and dereference the tag
      recursively until a non-tag object is found.

    * A colon, optionally followed by a stage number (0 to 3) and a
      colon, followed by a path; this names a blob object in the index
      at the given path. Missing stage number (and the colon that
      follows it) names an stage 0 entry.

Jari
