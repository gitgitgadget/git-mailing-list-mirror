From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: Topics currently in the Stalled category
Date: Tue, 20 Nov 2012 21:46:47 -0500
Message-ID: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 03:47:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb0L9-0004Nq-F6
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 03:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab2KUCqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 21:46:49 -0500
Received: from colo.foxharp.net ([166.84.7.52]:58313 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab2KUCqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 21:46:48 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id B94F2540E4;
	Tue, 20 Nov 2012 21:43:43 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 1000)
	id BBCC82E9301; Tue, 20 Nov 2012 21:46:47 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id A921C2E9300;
	Tue, 20 Nov 2012 21:46:47 -0500 (EST)
Content-ID: <29365.1353466007.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210130>

In-reply-to: <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org> (sfid-20121120_190548_379327_D3EE7D14)
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org> <7vy5hvq1ey.fsf@alter.siamese.dyndns.org> <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org> (sfid-20121120_190548_379327_D3EE7D14)
Fcc: outbox
--------

junio c hamano wrote:
 > Here is a list of stalled topics I am having trouble deciding what
 > to do (the default is to dismiss them around feature freeze).
...
 > * pf/editor-ignore-sigint (2012-11-11) 5 commits
 > 
 >  Avoid confusing cases where the user hits Ctrl-C while in the editor
 >  session, not realizing git will receive the signal. Since most editors
 >  will take over the terminal and will block SIGINT, this is not likely
 >  to confuse anyone.
 > 
 >  Some people raised issues with emacsclient, which are addressed by this
 >  re-roll. It should probably also handle SIGQUIT, and there were a
 >  handful of other review comments.
 > 
 >  Anybody interested in moving this forward?

i started this, but then jeff took it and ran with it and made it
right.  i think the remaining changes are small -- if jeff would
prefer, i can probably finish it.  (but i won't guarantee not to
mess up the "From:" lines.  :-)

paul
=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 36.0 degrees)
