From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: History messup
Date: Mon, 9 May 2005 19:06:11 +0200
Message-ID: <20050509170611.GJ24216@cip.informatik.uni-erlangen.de>
References: <1115657971.19236.33.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:09:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVBiO-0007Uv-8c
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEIRN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVEIRN5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 13:13:57 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34214 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261262AbVEIRN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 13:13:56 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j49H6CS8027744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 17:06:12 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j49H6CkT027743;
	Mon, 9 May 2005 19:06:12 +0200 (CEST)
To: Thomas Gleixner <tglx@linutronix.de>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>, git@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <1115657971.19236.33.camel@tglx>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
if merging with a repository just means to bring the head forward (e.g.
no local development since the fork) there is no seperate commit object,
just an update of the HEAD. Linus did explain this behaviour and the
thoughts behind this decission on the ML:

If two repositories pull alternating from each other one has never the
exact state the other has. They would play ping-pong and this is a bad
thing. That was AFAIK the reason there is no COMMIT object introduced on
'head forward' merges.

	Thomas
