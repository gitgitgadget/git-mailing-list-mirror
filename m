From: ib@wupperonline.de (Ingo Brueckl)
Subject: question concerning branches
Date: Wed, 19 Aug 2009 19:33:00 +0200
Message-ID: <4a8c373f@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 20:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdpV3-0004sH-MD
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 20:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZHSSC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 14:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZHSSC5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 14:02:57 -0400
Received: from smtp.tal.de ([81.92.1.5]:54915 "EHLO smtp.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZHSSC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 14:02:56 -0400
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2009 14:02:56 EDT
Received: from ib (unknown [89.244.118.72])
	by smtp.tal.de (Postfix) with SMTP id D2368AC1C22
	for <git@vger.kernel.org>; Wed, 19 Aug 2009 19:34:56 +0200 (CEST)
X-Mailer: blueMail 1.4 (SlipDoor 2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126568>

I'm a git novice and have a comprehension question concerning branches.

Within a git repository, I do:

  git branch test
  git checkout test
  # edit foo.bar
  git checkout master

I'd expect that master is in the exactly same unchanged state it was at
branching time, but what a surprise, foo.bar is modified here, too!

If I continue now working in the master branch (applying patches and such) I
will use a changed foo.bar with testing branch content. I can't even apply
patches to foo.bar without conflict.

Of what use are branches if the files aren't totally separated from each
other?

What must I do to get a test branch I can't work without affecting master?

Ingo
