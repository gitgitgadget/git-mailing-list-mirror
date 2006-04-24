From: "David S. Miller" <davem@davemloft.net>
Subject: Re: weird pull behavior as of late
Date: Mon, 24 Apr 2006 12:46:00 -0700 (PDT)
Message-ID: <20060424.124600.93277140.davem@davemloft.net>
References: <20060423.175953.52710961.davem@davemloft.net>
	<20060424132922.6e634188.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 21:46:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY70h-0005BX-AP
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 21:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWDXTqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 15:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDXTqM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 15:46:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40353
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751177AbWDXTqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 15:46:11 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1FY70V-0008At-38; Mon, 24 Apr 2006 12:46:03 -0700
To: vsu@altlinux.ru
In-Reply-To: <20060424132922.6e634188.vsu@altlinux.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19107>

From: Sergey Vlasov <vsu@altlinux.ru>
Date: Mon, 24 Apr 2006 13:29:22 +0400

> On Sun, 23 Apr 2006 17:59:53 -0700 (PDT) David S. Miller wrote:
> 
> > Fast forward
> >  MAINTAINERS |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > I got 446 objects and this amounted to just a 4 line change to the
> > MAINTAINERS file? :-)
> 
> I got the same problem recently and tracked it down to a stale diff.o
> object file inside libgit.a - apparently "ar rcs" does not recreate the
> archive from scratch.  After "make clean" the problem has vanished.

Thanks, I'll give that a try.
