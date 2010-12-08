From: layer <layer@known.net>
Subject: missing tags!
Date: Wed, 08 Dec 2010 11:44:35 -0800
Message-ID: <7986.1291837475@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 21:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQQBk-00036P-2j
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 21:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab0LHUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 15:00:18 -0500
Received: from relay.known.net ([173.13.135.57]:33387 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756106Ab0LHUAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 15:00:15 -0500
X-Greylist: delayed 938 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2010 15:00:15 EST
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000146769; Wed, 8 Dec 2010 11:44:35 -0800
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163218>

I have a repo to which I push to frequently.  For each release of the
software from this repo, I create an annotated tag and push it to this
repo.  I noticed yesterday that he has a single tag in it, when it
should have 100+.  The tag there was the last one I pushed to it.

The missing tags were created with

  git tag -a -m "release 4.2rm t1" release42rm_t1 HEAD

and pushed to the (bare) repo in question with

  git push origin release42rm_t1

I cannot imagine how the tags got deleted, and I'm looking for some
guidance.

Thanks.

Kevin
