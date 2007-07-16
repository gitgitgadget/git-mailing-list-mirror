From: David Kastrup <dak@gnu.org>
Subject: Some questions about git-name-rev
Date: Mon, 16 Jul 2007 10:20:25 +0200
Message-ID: <86abtwyd2u.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 10:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IALox-0004VO-K3
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 10:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbXGPIUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 04:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836AbXGPIUh
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 04:20:37 -0400
Received: from main.gmane.org ([80.91.229.2]:46070 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbXGPIUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 04:20:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IALom-0004cc-NN
	for git@vger.kernel.org; Mon, 16 Jul 2007 10:20:32 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 10:20:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 10:20:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:aC6gfbxYV1jIgvSpvb1cj8CDr38=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52650>


Hi, I am working on git support in Emacs.  This involves putting
version labels into the mode line and using them for specifying
revisions to diff.

40 digit commit numbers are not really fun for that.

So I need to use git-name-rev.  If I call it with the option --tags,
it might return an empty string.

If I don't call it with --tags, _and_ the commit number I feed into it
is the output of some git-rev-list, am I _guaranteed_ to become some
output?

Now is there a way to _abbreviate_ the output to the shortest _valid_
form, namely not have something like ref/remote/heads/branchname (or
similar) when branchname is sufficient?

-- 
David Kastrup
