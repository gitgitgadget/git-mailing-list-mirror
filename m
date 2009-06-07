From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] daemon: Skip unknown "extra arg" information
Date: Sun, 7 Jun 2009 20:56:08 +0200
Message-ID: <200906072056.08680.j6t@kdbg.org>
References: <20090604220824.GT3355@spearce.org> <7vbpp3tsg0.fsf@alter.siamese.dyndns.org> <20090605013332.GV3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 20:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDNXj-0001ip-9A
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 20:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbZFGS4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 14:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbZFGS4L
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 14:56:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:58738 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931AbZFGS4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 14:56:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 855AE2C4007;
	Sun,  7 Jun 2009 20:56:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2037B1D1B0;
	Sun,  7 Jun 2009 20:56:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090605013332.GV3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120992>

On Freitag, 5. Juni 2009, Shawn O. Pearce wrote:
> Actually, we're already f'kd.  We can't change the protocol like
> we had hoped.  I still think this should go in maint.
>
> --8<--
> daemon: Strictly parse the "extra arg" part of the command
>
> Since 1.4.4.5 (49ba83fb67 "Add virtualization support to git-daemon")
> git daemon enters an infinite loop and never terminates if a client
> hides any extra arguments in the initial request line which is not
> exactly "\0host=blah\0".

I see you applied this to maint. Since this patch actually fixes a 
DoS-exploitable bug, shouldn't it be applied all the way back to 1.4.4.5?

-- Hannes
