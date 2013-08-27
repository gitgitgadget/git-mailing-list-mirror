From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 00/23] Preliminary pack v4 support
Date: Tue, 27 Aug 2013 00:25:44 -0400
Message-ID: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsM-0007jK-2T
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab3H0E0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab3H0E03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:29 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0E9O41090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:28 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 8B4772DA052D	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233061>

Subject says it all... at last !

This can also be fetched here:

	git://git.linaro.org/people/nico/git

Demonstration of what it does at the moment:

	http://article.gmane.org/gmane.comp.version-control.git/233038

I'd like to preserve the author time stamps as they relate to where in
the world I was when the corresponding code was written.  You'll notice
I didn't work on the code in the same order as it is now presented.

Still open question: what to do with a thin pack.  Should we really
complete it with local objects upon reception, or were we only over
paranoid at the time we imposed this rule?  Fixing a thin pack version 4
could be possible but not very eleguant.  Hence my pondering about
relaxing this rule.

Comments welcome !


Nicolas
