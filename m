From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/5] Add more tests of cvsimport
Date: Mon, 23 Feb 2009 06:08:09 +0100
Message-ID: <1235365694-28935-1-git-send-email-mhagger@alum.mit.edu>
References: <7vzlge1kob.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 06:10:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbT58-00014D-CB
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 06:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbZBWFIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 00:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZBWFIi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 00:08:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37135 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbZBWFIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 00:08:36 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1N58Efv019166;
	Mon, 23 Feb 2009 06:08:14 +0100
X-Mailer: git-send-email 1.6.1.3
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111081>

@Junio, sorry for the screwup.  The attached patch series definitely
works on my machine (Linux, cvsps 2.1).

Junio C Hamano wrote:
> Thanks, both.  I generally am not very fond of adding tests without
> intention to look into fixes, but if they make outstanding bugs more
> visible, they may have the effect of shaming the original authors
> badly enough to step in in the effort of fixing them :-)

Please note that the new tests only check the very basic minimal
functionality of a conversion tool: that all of the CVS branches are
present, and that the tips of the branches have the same content as
those in the original CVS repository.  So far they cover perhaps 5% of
the cvs2svn/cvs2git test repository.

I am convinced that robust cvsps-based repository conversion is so
fundamentally impossible [1] that I am not interested in working on
it.  If people absolutely need incremental conversions, then let them
struggle on.  But let them be warned :-)

Cheers,
Michael

[1] http://selenic.com/pipermail/mercurial-devel/2008-February/004975.html
