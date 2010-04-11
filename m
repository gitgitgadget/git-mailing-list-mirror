From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-gui: Fast staging/unstaging of hunks/lines
Date: Sun, 11 Apr 2010 21:01:54 +0200
Message-ID: <201004112101.54908.j6t@kdbg.org>
References: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com> <x2o36ca99e91004110038oce1ffa15jc49244f228ce218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 21:04:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O12S9-0001b5-BD
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 21:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab0DKTEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 15:04:12 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:49780 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752693Ab0DKTEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 15:04:11 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E2705CDF8D;
	Sun, 11 Apr 2010 21:04:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0891E19F5EB;
	Sun, 11 Apr 2010 21:01:55 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <x2o36ca99e91004110038oce1ffa15jc49244f228ce218@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144677>

On Sonntag, 11. April 2010, Bert Wesarg wrote:
> On Mon, Apr 5, 2010 at 11:01, Bert Wesarg <bert.wesarg@googlemail.com> 
wrote:
> > This adds a shortcut to stage/unstage hunks or a range of lines. Which is
> > done on a mouse button 1 release event and holding the control key in the
> > diff view. If there is currently a selection only the selected lines will
> > be staged/unstaged. Otherwise the hunk will be staged/unstaged.
>
> Ping.

I gave the patch a quick try.

I don't think that I would use it a lot because it is very easy to mess up a 
staged change: The problem is that a click without anything selected will 
stage an entire hunk. I frequently use "Stage Line(s)" to separate 
neighboring changes that must go to separate commits, but with you feature it 
is very easy to forget to select something and, hence, to stage the entire 
hunk accidentally - which means that I would have to start over with the hunk 
and all the "quick" aspects of the feature would be lost.

That said, since I don't have Ctrl pressed very often while working in 
git-gui, the patch wouldn't hurt me, I think.

-- Hannes
