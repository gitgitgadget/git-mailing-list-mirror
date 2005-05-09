From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: History messup
Date: Mon, 09 May 2005 17:48:23 +0000
Organization: linutronix
Message-ID: <1115660903.19236.39.camel@tglx>
References: <1115657971.19236.33.camel@tglx>
	 <1115659677.16187.393.camel@hades.cambridge.redhat.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:55:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCG2-0001nG-4n
	for gcvg-git@gmane.org; Mon, 09 May 2005 19:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVEIRsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEIRsW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 13:48:22 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:17282
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261460AbVEIRrh
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 13:47:37 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 35F8565C003;
	Mon,  9 May 2005 19:45:17 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id DD05328204;
	Mon,  9 May 2005 19:47:37 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115659677.16187.393.camel@hades.cambridge.redhat.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-09 at 18:27 +0100, David Woodhouse wrote:
> On Mon, 2005-05-09 at 16:59 +0000, Thomas Gleixner wrote:

> It's normal practice, and it _has_ to be the case. Otherwise the trees
> would never stabilise -- every time Linus pulled from my tree he would
> create a merge-commit which I don't yet have, and vice versa.

Sure

> Unless a commit also carries a unique repo-id identifying the repository
> in which it originally occurred, you'll only ever be able to track
> history in the way people want by means of heuristics.

That would be really great. A line after "parents" like

repoid "username/reponame" 

would be sufficient

tglx


