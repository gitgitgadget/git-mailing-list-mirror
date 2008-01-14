From: William Morgan <wmorgan-git@masanjin.net>
Subject: format-patch usage
Date: Sun, 13 Jan 2008 16:40:17 -0800
Message-ID: <1200270370-sup-4560@south>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 01:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEDP9-0006Ag-7g
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 01:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbYANAlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 19:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbYANAlm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 19:41:42 -0500
Received: from nlpi001.sbcis.sbc.com ([207.115.36.30]:22228 "EHLO
	nlpi001.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbYANAll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 19:41:41 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi001.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m0E0faTn028180
	for <git@vger.kernel.org>; Sun, 13 Jan 2008 18:41:39 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JEDNB-00070a-Dk
	for git@vger.kernel.org; Sun, 13 Jan 2008 16:40:17 -0800
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70429>

Hi all,

Two questions from a git neophyte about using format-patch:

First, what's the point of adding the Signed-off-by footer, if you're
the author of the patch? I can see the utility of the committer adding
this, as a record of who committed it, but if you wrote a patch and are
submitting it to the list, then you've presumably "signed off", haven't
you? Or is there some subtle distinction between exploratory patches and
"real" patches being made?

Second, it seems like commentary about a patch can be placed after the
"---" but before the "diff --git" lines. Is that correct? Is that
accepted practice? It seems a little backwards to have the commit
message first, then the commentary. Am I correct in assuming that
git-apply ignores anything between those two lines, including the diff
stat, and so that's the reason people put it there?

Thanks,

-- 
William <wmorgan-git@masanjin.net>
