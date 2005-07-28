From: Darrin Thompson <darrint@progeny.com>
Subject: Dump http servers still slow?
Date: Thu, 28 Jul 2005 16:00:23 -0500
Message-ID: <1122584423.12374.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 23:06:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyFZh-0000N7-IK
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 23:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVG1VFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVG1VC6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 17:02:58 -0400
Received: from zealot.progeny.com ([216.37.46.162]:56496 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262313AbVG1VA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 17:00:27 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 44701636A4; Thu, 28 Jul 2005 16:00:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio,

I just ran git clone against the mainline git repository using both http
and rsync. http was still quite slow compared to rsync. I expected that
the http time would be much faster than in the past due to the pack
file.

Is there something simple I'm missing?

--
Darrin
