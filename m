From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Newbie: Do I need to download the entire repo to work on just
	1 file?
Date: Mon, 23 Mar 2009 00:31:20 +0100
Message-ID: <20090322233120.GC12974@vidovic>
References: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl> <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com> <20090322231002.GA12974@vidovic> <fabb9a1e0903221610p3b11f09ctc6a9f4d38b1bda3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>, git@vger.kernel.org,
	Anthony Rasmussen <evoluenta@hotmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlXA7-0000r6-7n
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612AbZCVXb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbZCVXb3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:31:29 -0400
Received: from out2.laposte.net ([193.251.214.119]:9635 "EHLO out1.laposte.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753326AbZCVXb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:31:28 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8211.laposte.net (SMTP Server) with ESMTP id C91937000096;
	Mon, 23 Mar 2009 00:31:21 +0100 (CET)
Received: from ? (91-165-135-230.rev.libertysurf.net [91.165.135.230])
	by mwinf8211.laposte.net (SMTP Server) with ESMTP id 56D817000086;
	Mon, 23 Mar 2009 00:31:21 +0100 (CET)
X-ME-UUID: 20090322233121355.56D817000086@mwinf8211.laposte.net
Content-Disposition: inline
In-Reply-To: <fabb9a1e0903221610p3b11f09ctc6a9f4d38b1bda3e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-200)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeduucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114204>


On Mon, Mar 23, 2009 at 12:10:48AM +0100, Sverre Rabbelier wrote:
> 
> Heya,
> 
> On Mon, Mar 23, 2009 at 00:10, Nicolas Sebrecht
> <nicolas.s-dev@laposte.net> wrote:
> > No, you don't. Why not use the '--depth <depth>' option of 'git clone' ?
> 
> That depends on if he wants to push back to the original repo or not, right?

It depends of what the OP means by "entire repository". You can't
"cherry-pick" one single file without download the entire tree of the
working directory.

You can push with a truncated history. What you can't do is checkout
from the history you don't have in your local repository.

-- 
Nicolas Sebrecht
