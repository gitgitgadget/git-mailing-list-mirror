From: Luca Barbato <lu_zero@gentoo.org>
Subject: [patch] Make git-svn init accept a target dir
Date: Thu, 29 Jun 2006 01:07:25 +0200
Message-ID: <44A30BAD.60907@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 29 01:07:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvj87-0002er-Oq
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 01:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWF1XH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWF1XH3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 19:07:29 -0400
Received: from smtp2.libero.it ([193.70.192.52]:44521 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S1751759AbWF1XH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 19:07:28 -0400
Received: from localhost (172.16.1.15) by smtp2.libero.it (7.0.027-DD01)
        id 4464BDCD040B542D for git@vger.kernel.org; Thu, 29 Jun 2006 01:07:27 +0200
Received: from smtp0.libero.it ([172.16.1.204])
 by localhost (asav11.libero.it [193.70.192.93]) (amavisd-new, port 10024)
 with ESMTP id 04173-18 for <git@vger.kernel.org>;
 Thu, 29 Jun 2006 01:07:27 +0200 (CEST)
Received: from [192.168.0.6] (adsl-ull-62-62.44-151.net24.it [151.44.62.62])
	by smtp0.libero.it (Postfix) with ESMTP id 0624E33386D
	for <git@vger.kernel.org>; Thu, 29 Jun 2006 01:07:26 +0200 (MEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22826>

Since I'm lazy I just hacked a bit git-svn in order to create a target
dir and init it if is passed as second parameter.

git-svn init url://to/the/repo local-repo

will create the local-repo dir if doesn't exist yet and populate it as
expected.

Maybe someone else could find it useful

lu

-- 

Luca Barbato

Gentoo/linux Gentoo/PPC
http://dev.gentoo.org/~lu_zero
