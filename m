From: layer <layer@known.net>
Subject: post-checkout hook not run on clone
Date: Mon, 02 Mar 2009 14:43:37 -0800
Message-ID: <20273.1236033817@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 23:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeGtC-00086A-R0
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 23:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbZCBWnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 17:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbZCBWnk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 17:43:40 -0500
Received: from relay.known.net ([67.121.255.169]:51747 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754839AbZCBWnk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 17:43:40 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000027434; Mon, 2 Mar 2009 14:43:37 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111970>

I realize this might be a feature, but when I switch to the master
branch with "git checkout master" it is, and I would think that a
clone that gets the master branch would also does a sort of "checkout
master" and would run the hook.

In any case, I'd be happy of there was a post-clone hook, instead, but
there isn't.

Any suggestions?

Thanks.

Kevin
