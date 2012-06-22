From: Wesley Shields <wxs@FreeBSD.org>
Subject: Problem using curl + c-ares
Date: Thu, 21 Jun 2012 22:03:08 -0400
Message-ID: <20120622020308.GA31477@atarininja.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 04:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShtMo-0001ov-QA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 04:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab2FVCMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 22:12:55 -0400
Received: from syn.csh.rit.edu ([129.21.49.45]:51911 "EHLO syn.atarininja.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785Ab2FVCMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 22:12:54 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2012 22:12:54 EDT
Received: by syn.atarininja.org (Postfix, from userid 1001)
	id BA6395C34; Thu, 21 Jun 2012 22:03:08 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200421>

I'm trying to debug a problem that came to my attention when using git
to clone a repository over HTTP or HTTPS if curl is built to use the
c-ares bindings.

The symptom is well documented at:

http://www.freebsd.org/cgi/query-pr.cgi?pr=ports/167517

If you run tcpdump while triggering this problem you will see that the
bytes for the destination port in the packet for the A record query are
swapped. I'm not familiar enough with the git code to debug it fully but
I would be happy to provide any information needed to help.

Just using curl on the box works fine so I suspect it's not a problem
with curl, but with how git is using curl? I'd appreciate any pointers
with this!

Please keep me on CC as I am not subscribed to this list. Thanks!

-- WXS
