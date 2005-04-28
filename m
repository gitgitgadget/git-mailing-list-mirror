From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Cogito nit: cg-update should default to "origin".
Date: Wed, 27 Apr 2005 20:32:32 -0400
Message-ID: <42702F20.3050200@dwheeler.com>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:25:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwq7-00080H-Jg
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVD1AaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVD1AaT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:30:19 -0400
Received: from aibo.runbox.com ([193.71.199.94]:29066 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262119AbVD1AaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:30:16 -0400
Received: from [10.9.9.9] (helo=fetch.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DQwv1-0007Z7-Ox; Thu, 28 Apr 2005 02:30:15 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fetch.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DQwus-0007F5-FG; Thu, 28 Apr 2005 02:30:11 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427235115.GN22956@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Minor nit on Cogito: I think cg-update should default to "origin",
not the head, if you leave it unspecified.  Instead, add an
option flag to specify the HEAD.  The origin seems (to me)
to be a MUCH more common situation (and thus the better default).

--- David A. Wheeler
