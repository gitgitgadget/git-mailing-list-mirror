From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: History messup
Date: Mon, 09 May 2005 20:06:38 +0100
Message-ID: <1115665598.12012.422.camel@baythorne.infradead.org>
References: <1115657971.19236.33.camel@tglx>
	 <1115659677.16187.393.camel@hades.cambridge.redhat.com>
	 <1115660903.19236.39.camel@tglx>  <427FB3A7.8050906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 21:05:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVDTR-0004Eb-Im
	for gcvg-git@gmane.org; Mon, 09 May 2005 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVEITGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEITGm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 15:06:42 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:47794 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261507AbVEITGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 15:06:40 -0400
Received: from localhost.localdomain ([127.0.0.1])
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DVDaQ-0001MS-Ru; Mon, 09 May 2005 20:06:38 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427FB3A7.8050906@zytor.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-09 at 12:01 -0700, H. Peter Anvin wrote:
> Seems like a UUID or a SHA-1 identifier would be better.
> 
> However, one can definitely argue that even the meaning of "a 
> repository" isn't well-defined in the context of git.

Of course it isn't. But neither is the meaning "a committer" or 
"an author" or even "a date".

Including some kind of repo-specific identifier with each commit would
help us to make sense of the history, just as those other fields do.

-- 
dwmw2


