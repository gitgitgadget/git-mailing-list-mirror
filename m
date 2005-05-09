From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cache optimizations
Date: Sun, 08 May 2005 22:49:17 -0700
Message-ID: <7vzmv5ymn6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505090058240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 07:43:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV12x-0000dD-QL
	for gcvg-git@gmane.org; Mon, 09 May 2005 07:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVEIFt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 01:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVEIFt1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 01:49:27 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25031 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263051AbVEIFtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 01:49:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050509054917.XAJK16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 01:49:17 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505090058240.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 9 May 2005 01:15:09 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Does anyone know of a reason not to refresh each entry in
DB> the cache as it's checked out?

I vaguely recall Linus saying something about wanting to keep
checkout-cache being a read-only consumer of the index file;
I've checked mailing list archive but I cannot not find a
reference to point you at, though.

