From: Julia Lawall <julia.lawall@lip6.fr>
Subject: git blame gives an ambiguous short revision
Date: Sun, 1 Jul 2012 08:30:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1207010825370.1873@hadrien>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 14:30:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlJIM-0006ed-O6
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jul 2012 14:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab2GAMaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jul 2012 08:30:25 -0400
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:52322 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750811Ab2GAMaY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jul 2012 08:30:24 -0400
X-IronPort-AV: E=Sophos;i="4.77,504,1336341600"; 
   d="scan'208";a="165168662"
Received: from unknown (HELO hadrien.local) ([96.47.147.200])
  by mail1-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Jul 2012 14:30:23 +0200
X-X-Sender: jll@hadrien
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200839>

Using linux-next cloned today (July 1), I then checkout out the
revision 60d5c9f5b.  The command

git blame drivers/staging/brcm80211/brcmfmac/wl_iw.c -L3675,3675

then gives:

60d5c9f5 (Julia Lawall 2011-04-01 16:23:42 +0200 3675)  if (!iscan->iscan_ex_params_p) {

Then I try:

git show 60d5c9f5

which gives:

error: short SHA1 60d5c9f5 is ambiguous.
error: short SHA1 60d5c9f5 is ambiguous.
fatal: ambiguous argument '60d5c9f5': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

If I give git blame the -l option, every thing is fine.

thanks,
julia
