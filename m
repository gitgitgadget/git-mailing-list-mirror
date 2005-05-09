From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: History messup
Date: Mon, 09 May 2005 18:05:54 +0000
Organization: linutronix
Message-ID: <1115661954.19236.44.camel@tglx>
References: <1115657971.19236.33.camel@tglx>
	 <20050509170611.GJ24216@cip.informatik.uni-erlangen.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 20:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCW6-0005Fn-Qm
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEISFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVEISFO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 14:05:14 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27266
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261469AbVEISFI
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 14:05:08 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 168CD65C003;
	Mon,  9 May 2005 20:02:47 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id B2D1A28204;
	Mon,  9 May 2005 20:05:08 +0200 (CEST)
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050509170611.GJ24216@cip.informatik.uni-erlangen.de>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-09 at 19:06 +0200, Thomas Glanzmann wrote:
> If two repositories pull alternating from each other one has never the
> exact state the other has. They would play ping-pong and this is a bad
> thing. That was AFAIK the reason there is no COMMIT object introduced on
> 'head forward' merges.

That makes totaly sense, but for history tracking it is a horror
scenario, unless you dont have head history lists per repository or an
unique repository identifier in the commit blob itself.

tglx


