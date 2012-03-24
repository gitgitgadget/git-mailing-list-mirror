From: Julia Lawall <julia.lawall@lip6.fr>
Subject: git show loop
Date: Sat, 24 Mar 2012 11:05:20 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1203241101390.2046@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 11:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBNql-00068z-Ar
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 11:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab2CXKFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 06:05:24 -0400
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:11412
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462Ab2CXKFY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 06:05:24 -0400
X-IronPort-AV: E=Sophos;i="4.73,640,1325458800"; 
   d="scan'208";a="137533195"
Received: from 194.64.13.109.rev.sfr.net (HELO hadrien) ([109.13.64.194])
  by mail4-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Mar 2012 11:05:21 +0100
X-X-Sender: jll@localhost6.localdomain6
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193823>

In linux, git show 60d9aa7 -U0 goes into an infinite loop.
The commit log starts with:

commit 60d9aa758c00f20ade0cb1951f6a934f628dd2d7
Merge: b2adf0c 2e16cfc
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 16 10:23:43 2009 -0800

Everything is fine without the -U0 option.

The commit only contains the following @@ lines:

@@@ -21,7 -21,7 +21,8 @@@
@@@ -33,7 -33,7 +33,8 @@@

That is, both have @@@, not @@.

thanks,
julia
