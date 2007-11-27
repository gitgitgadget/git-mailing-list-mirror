From: Emanuele Giaquinta <e.giaquinta@glauco.it>
Subject: git-cvsimport bug
Date: Tue, 27 Nov 2007 16:01:36 +0100
Message-ID: <20071127150136.GA50697@orion.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 17:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix3R2-0006ac-MK
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878AbXK0QhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 11:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755819AbXK0QhA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:37:00 -0500
Received: from 62-101-89-40.ip.fastwebnet.it ([62.101.89.40]:4343 "HELO
	mx0.glauco.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755516AbXK0Qg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 11:36:59 -0500
X-Greylist: delayed 5689 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2007 11:36:59 EST
Received: FROM pcnmail BY mx0.glauco.it ; Tue Nov 27 16:02:04 2007 +0100
Received: FROM localhost ([87.6.101.174]) BY pcnmail WITH ESMTP ; Tue, 27 Nov 2007 16:02:02 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66238>

Hi,

a call to git-cvsimport after a 'git-pack-refs --all' seems to mess up
the origin branch, because the first new change is committed with no
parent (git-cvsimport reports 'Parent ID (empty)').
It does not happen if I disable loose refs pruning with --no-prune. A
tiny test repo you can use to reproduce the problem is
mextli.tomaw.net/~exg/lzf.tar. Is it expected?

Thanks,

Emanuele Giaquinta
