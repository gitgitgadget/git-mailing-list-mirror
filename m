From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 0/5] some shell portability fixes
Date: Tue, 6 Nov 2007 21:15:18 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUpm-0001Fz-Lw
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbXKFUPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757474AbXKFUPW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:15:22 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:56961 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370AbXKFUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:15:20 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id C73F24000269A
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:15:19 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63713>

Here's a bunch of rather trivial patches against master to fix
portability issues, mostly shell ones.  FWIW I did not test the
patches other than ensuring the set of testsuite errors remains
the same, and that I only did on one system.

All of the issues are ones that are encountered on some real
system, most are documented either in POSIX or in the shell
portability section of the Autoconf manual.

Cheers,
Ralf
