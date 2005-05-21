From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Sat, 21 May 2005 03:53:30 -0700
Message-ID: <7vhdgwj1ed.fsf@assigned-by-dhcp.cox.net>
References: <E1DZRMi-00021X-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: barkalow@iabervon.org (Daniel Barkalow), torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 12:53:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZRar-0001M7-Cy
	for gcvg-git@gmane.org; Sat, 21 May 2005 12:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEUKxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 06:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVEUKxe
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 06:53:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18926 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261720AbVEUKxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 06:53:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521105331.GHNE7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 06:53:31 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DZRMi-00021X-00@gondolin.me.apana.org.au> (Herbert Xu's
 message of "Sat, 21 May 2005 20:37:56 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HX" == Herbert Xu <herbert@gondor.apana.org.au> writes:

HX> It's also better to use -eq instead of = since you are comparing
HX> numbers, not strings.  If you do that you can keep the double
HX> quotes since the spaces will be removed automatically.

I remember being burned by busybox "test" which did not ignore
spaces.  I do not know if the latest one is fixed, though.

