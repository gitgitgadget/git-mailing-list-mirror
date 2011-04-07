From: Arjen Laarhoven <arjen@yaph.org>
Subject: git diff-tree output inconsistency?
Date: Thu, 7 Apr 2011 15:59:38 +0200
Message-ID: <20110407135938.GA322@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 16:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7q8d-0000mf-Vz
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 16:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab1DGOYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 10:24:42 -0400
Received: from regex.yaph.org ([94.142.240.24]:49913 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060Ab1DGOYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 10:24:41 -0400
X-Greylist: delayed 1502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Apr 2011 10:24:41 EDT
Received: by regex.yaph.org (Postfix, from userid 1000)
	id C6E8F5B7D7; Thu,  7 Apr 2011 15:59:38 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171062>

Hi all,

I was fiddling with the git-diff-tree command to retrieve a list of
files which have in a commit:

$ git diff-tree --name-only HEAD

According to the documentation, the output starts with the SHA-1 of the
tree-ish given, after which the list of changed files follows.  This is
the case when just one commit-id is given.

However, when given 2 tree-ish objects, the separate line with the SHA-1
is not shown.

I browsed through the code and the history for diff-tree.c, but couldn't
find an explanation for the inconsistency.  The documentation for the
--no-commit-id confuses me a bit more, as it states that the commit id
is shown 'when applicable'.  Unfortunately, it fails to explain when
exactly that is :-)

Have I found a documentation bug/shortcoming, is it a code bug or am I
misunderstanding something else?

Arjen

-- 
Arjen Laarhoven

The presence of those seeking the truth is infinitely to be preferred to 
those who think they've found it.
                                -- Terry Pratchett, "Monstrous Regiment"
