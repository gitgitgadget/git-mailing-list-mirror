From: Pavel Roskin <proski@gnu.org>
Subject: Autoconf/Automake
Date: Wed, 14 Jun 2006 18:27:10 -0400
Message-ID: <1150324030.23268.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 15 00:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqdpU-0002eU-I9
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 00:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWFNW1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 18:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWFNW1N
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 18:27:13 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:5055 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964852AbWFNW1M
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 18:27:12 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FqdpP-0001C5-AE
	for git@vger.kernel.org; Wed, 14 Jun 2006 18:27:11 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FqdpO-00064P-Bb
	for git@vger.kernel.org; Wed, 14 Jun 2006 18:27:10 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21868>

Hello!

Is there any interest in converting the build system used by git to
Autoconf and Automake?  The ad-hoc configuration in Makefile is getting
too big.  As for nice features like remembering $prefix, wouldn't it be
better to add them to Automake instead of limiting them to just one
project?

Other goodies from Automake are "make distcheck" and automatic
dependency tracking.  Compatibility with non-GNU make could earn us some
respect from BSD folks.

I converted several projects to the GNU build system, including qgit.
It may be hard to get right, but then it just works for any
configuration without giving any trouble.

-- 
Regards,
Pavel Roskin
