From: layer <layer@known.net>
Subject: git merge ignoring whitespace
Date: Thu, 05 Feb 2009 15:24:49 -0800
Message-ID: <2754.1233876289@relay.known.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 00:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVDbt-0005X7-Rl
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 00:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbZBEXYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbZBEXYv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 18:24:51 -0500
Received: from relay.known.net ([67.121.255.169]:34172 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751761AbZBEXYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 18:24:50 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000022727; Thu, 5 Feb 2009 15:24:49 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108633>

Junio, on 3/25/07 you said:

  I know Linus does not like applying patches with whitespace
  fuzziness, but I personally think a merge that ignores
  whitespace changes would be a useful thing to have, without
  having to call an external specialized merge backend. In other
  words, I do not think it is so special a thing to want to, but
  it is rather an unfortunate norm.  I am not opposed to give
  git-merge-recursive a command line option to tell it to merge
  ignoring the whitespace-only changes, when it does the 3-way
  file-level merge internally.

Whatever came of this?  I tried giving git merge a --ignore-whitespace
argument and the error message that followed show no equivalent
argument.

It would sure come in handy right now.  Is there some other way to do
it that I didn't find searching the mailing list?

Thanks.

Kevin
