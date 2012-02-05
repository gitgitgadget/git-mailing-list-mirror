From: Michael <kensington@astralcloak.net>
Subject: Build oddities
Date: Sun, 5 Feb 2012 06:34:49 +0000 (UTC)
Message-ID: <loom.20120205T072940-523@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 07:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtvll-0005nF-1O
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 07:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab2BEGkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 01:40:06 -0500
Received: from plane.gmane.org ([80.91.229.3]:57736 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab2BEGkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 01:40:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rtvlb-0005ih-3q
	for git@vger.kernel.org; Sun, 05 Feb 2012 07:40:03 +0100
Received: from ppp118-209-82-79.lns20.mel4.internode.on.net ([118.209.82.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 07:40:03 +0100
Received: from kensington by ppp118-209-82-79.lns20.mel4.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 07:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 118.209.82.79 (Mozilla/5.0 (Windows NT 6.1; rv:13.0a1) Gecko/20120203 Firefox/13.0a1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189931>

Hi there,

I ran into a build oddity with git today - the environment variable $X is
appended to most binaries. At the time, I had X=last, so I ended up with
gitlast, git-peek-remotelast etc.

Does anyone know why this behaviour exists, and if it is still desired?

Best regards,
Michael
