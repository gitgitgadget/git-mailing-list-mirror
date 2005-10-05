From: Christian Meder <chris@absolutegiganten.org>
Subject: Notes and questions while reading the documentation
Date: Thu, 06 Oct 2005 00:06:06 +0200
Message-ID: <1128549966.11363.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 00:18:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENHQ2-0001Jv-Px
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 00:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVJEWGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVJEWGy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 18:06:54 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:34007 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S1030385AbVJEWGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 18:06:53 -0400
Received: from p54a2345f.dip0.t-ipconnect.de ([84.162.52.95] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.52)
	id 1ENHPY-0001xT-CB
	for git@vger.kernel.org; Thu, 06 Oct 2005 00:06:52 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1ENHOp-0004ov-Bf
	for git@vger.kernel.org; Thu, 06 Oct 2005 00:06:07 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9739>

Hi,

while (proof-)reading the Documentation I noted down some remarks and
questions:

* a lot of the manpages include something like "v0.1, June 2005" in the
header; these versions tags are pretty obscure to interpret, timestamp
when last edited ? version of the manpage ? version of git when the
manpage was included ? maturity the author assigned to the content ?
If these tags don't follow some sane schema they should be removed.

* git-applymbox: -q for interactivity seems like a strange choice, ok I
knew -i for interactive and -q for quiet but -q for interactive editing
is _not_ really intuitive

* the usage of git, Git and GIT isn't consistent in the documentation.
I'd vote for only using git.

* git-clone says that http transport is not supported yet I used it to
clone the git repo from kernel.org yesterday. Should the documentation
get updated ?

* the manpage synopsises aren't consistent wrt command naming; it's "git
commit" but "git-branch"; I guess all the manpages should reference
their commands as "git-x" and not "git x"

Greetings,



				Christian 
-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)
