From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 18:17:22 +0200
Message-ID: <20050502161722.GN20146@opteron.random>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 18:06:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSdQR-0004KZ-Sh
	for gcvg-git@gmane.org; Mon, 02 May 2005 18:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVEBQLl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 12:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEBQLi
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 12:11:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11564
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261383AbVEBQLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 12:11:33 -0400
Received: by opteron.random (Postfix, from userid 500)
	id DA2DB1C180F; Mon,  2 May 2005 18:17:22 +0200 (CEST)
To: Bill Davidsen <davidsen@tmr.com>
Content-Disposition: inline
In-Reply-To: <42764C0C.8030604@tmr.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 11:49:32AM -0400, Bill Davidsen wrote:
> Could you explain why this is necessary or desirable? I looked at what 

This is necessary here because of this:

andrea@opteron:~> which python
/home/andrea/bin/x86_64/python/bin/python

Of course I've /home/andrea/bin/x86_64/python/bin in the path before
/usr/bin.

The generally accepted way to start it is through env, other scripts in
mercurial were already getting that right too so it was probably not
intentional to hardcode it in the hg binary.
