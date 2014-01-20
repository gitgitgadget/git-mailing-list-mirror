From: Christophe <Christophe.Troestler@umons.ac.be>
Subject: git-remote-hg
Date: Mon, 20 Jan 2014 18:18:32 +0100
Organization: Universite de Mons (http://math.umons.ac.be/anum/)
Message-ID: <20140120.181832.898588286941108442.Christophe.Troestler@umons.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 20 18:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Ia6-0007Dv-AN
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 18:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbaATRYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jan 2014 12:24:10 -0500
Received: from mx2.umons.ac.be ([193.190.208.48]:40586 "EHLO TMGM2.umons.ac.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaATRYI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 12:24:08 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2014 12:24:08 EST
Received: from EXCHANGEHUB1.umons.ac.be (10.104.2.76) by TMGM2.umons.ac.be
 (10.104.2.75) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 20 Jan
 2014 18:17:05 +0100
Received: from poincare (10.104.2.63) by smtp.umons.ac.be (10.104.2.84) with
 Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 20 Jan 2014 18:17:04 +0100
Received: from localhost ([::1])	by poincare with esmtp (Exim 4.82)
	(envelope-from <Christophe.Troestler@umons.ac.be>)	id 1W5IUb-0007aC-9H	for
 git@vger.kernel.org; Mon, 20 Jan 2014 18:18:33 +0100
URL: https://github.com/git/git
X-Face: #2fb%mPx>rRL@4ff~TVgZ"<[:,oL"`TUEGK/[8/qb58~C>jR(x4A+v/n)7BgpEtIph_neoLKJBq0JBY9:<qMr[nclFSC*8GVW;&@q*7^R?u"i{y>}8v|j
X-Mailer: Mew version 6.5 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
X-Originating-IP: [10.104.2.63]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240720>

Hi,

I am using git-remote-hg to access to projects on bitbucket.  I can
clone the master branch fine and push to it.  I also see hg branches
as remotes/origin/branches/=ABbranch=BB.  However, if I create a local
branch "branches/x" and want to push it to remotes/origin/branches/x,
it gets pushed to the remote master (aka default) branch.

What is the recommended way of working with multiple branches when
interacting with a remote hg repository?

Best,
C.


P.S. The remote helper also prints many lines like:

error: Object 4a83cec050af8749b3eacc9da9b216350bb86c07 already has a ma=
rk
