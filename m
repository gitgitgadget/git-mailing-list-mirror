From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: 'read-tree -m head' vs 'read-tree head'
Date: Wed, 4 May 2005 09:01:48 +0200
Message-ID: <20050504070148.GF18380@cip.informatik.uni-erlangen.de>
References: <20050503124935.GT25004@cip.informatik.uni-erlangen.de> <7vbr7sw2aj.fsf@assigned-by-dhcp.cox.net> <20050503213444.GD15995@pasky.ji.cz> <7vr7gnpjkq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 04 08:55:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTDn8-0007SH-8N
	for gcvg-git@gmane.org; Wed, 04 May 2005 08:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVEDHBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 03:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVEDHBv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 03:01:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60612 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261176AbVEDHBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 03:01:50 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4471mS8010543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 4 May 2005 07:01:48 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4471mSX010537
	for git@vger.kernel.org; Wed, 4 May 2005 09:01:48 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vr7gnpjkq.fsf@assigned-by-dhcp.cox.net>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Junio,

>     Normally "read-tree -m" is the preferred form from
>     performance point of view, especially on a large project.
>     The only case you need to use "read-tree" without -m is when
>     the cache contains conflicting merge results and you want to
>     start from scratch.

thanks for the bottom line. That explains why Linus uses it in his
git-pull-script.

	Thomas
