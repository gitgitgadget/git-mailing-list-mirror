From: "Max Kirillov" <max@max630.net>
Subject: RE: How to resume broke clone =?UTF-8?Q?=3F?=
Date: Thu, 28 Nov 2013 01:32:36 -0700
Message-ID: <20131128013236.96eec638b311907e2368f42b42021fd8.17478ad17f.wbe@email02.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "zhifeng hu" <zf@ancientrocklab.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 09:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlx6U-0007Fl-Oi
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab3K1Ihj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 03:37:39 -0500
Received: from p3plsmtp02-04-2.prod.phx3.secureserver.net ([72.167.218.97]:52404
	"EHLO p3plwbeout02-04.prod.phx3.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab3K1Ihi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 03:37:38 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2013 03:37:38 EST
Received: from localhost ([72.167.218.115])
	by p3plwbeout02-04.prod.phx3.secureserver.net with bizsmtp
	id uwYe1m0012VyfJY01wYew0; Thu, 28 Nov 2013 01:32:38 -0700
X-SID: uwYe1m0012VyfJY01
Received: (qmail 28380 invoked by uid 99); 28 Nov 2013 08:32:38 -0000
X-Originating-IP: 193.64.145.29
User-Agent: Workspace Webmail 5.6.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238479>

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> I am in china. our bandwidth is very limitation. Less than 50Kb/s.

You could manually download big packed bundled from some http remote.
For example http://repo.or.cz/r/linux.git

* create a new repository, add the remote there.

* download files with wget or whatever:
 http://repo.or.cz/r/linux.git/objects/info/packs
also files mentioned in the file. Currently they are:
 http://repo.or.cz/r/linux.git/objects/pack/pack-3807b40fc5fd7556990ecbfe28a54af68964a5ce.idx
 http://repo.or.cz/r/linux.git/objects/pack/pack-3807b40fc5fd7556990ecbfe28a54af68964a5ce.pack

and put them to the corresponding places.

* then run fetch of pull. I believe it should run fast then. Though I
have not test it.

Br,
-- 
Max
