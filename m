From: Junio C Hamano <junkio@cox.net>
Subject: Re: new features in gitk
Date: Wed, 29 Jun 2005 23:20:21 -0700
Message-ID: <7vd5q45psq.fsf@assigned-by-dhcp.cox.net>
References: <17088.31798.17291.605567@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 08:13:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnsIz-0006a1-0S
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 08:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVF3GUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 02:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVF3GUx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 02:20:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51900 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262798AbVF3GUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 02:20:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630062021.BLUN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 02:20:21 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17088.31798.17291.605567@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Tue, 28 Jun 2005 08:22:46 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Finally I started converting my workflow of day-job I do on my
home machine from darcs to git, so I started running cvs2git
over ssh slurping from my office environment (sloooooooooow).

While I was watching the import going, I started up gitk on the
halfway imported repository, and it showed Japanese characters
in the source correctly without any special configuration (the
only thing I have is LC_CTYPE=ja_JP).  Very often GUIish
software would not work properly for me with Japanese
characters, and this was a pleasant surprise.

The credit is probably owed more to tk, not something you do
special in gitk, but nevertheless I am impressed and happy ;-).
