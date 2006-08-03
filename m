From: Jeff King <peff@peff.net>
Subject: git-annotate bug report
Date: Thu, 3 Aug 2006 16:38:48 -0400
Message-ID: <20060803203848.GA15121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 22:38:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8jy2-0005kv-56
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 22:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWHCUiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 16:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHCUiv
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 16:38:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:46055 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751265AbWHCUiu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 16:38:50 -0400
Received: (qmail 8000 invoked from network); 3 Aug 2006 16:38:14 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Aug 2006 16:38:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  3 Aug 2006 16:38:48 -0400
To: ryan@michonline.com
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24755>

git-annotate on the tip of master seems to be broken for some files (but
not for others):

$ git-describe
v1.4.2-rc2-gfba0cbd
$ make && ./git-annotate builtin-read-tree.c
parent eff97e3faeb28f6521851c1b3be1a54a2138f12a is on line 852
Line 852, does not match:
||
|                       cnt++;|
021b6e454944a4fba878651ebf9bfe0a3f6c3077

-Peff
