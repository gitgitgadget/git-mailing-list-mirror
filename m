From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 02:29:26 -0500
Message-ID: <20100104072926.GB10611@coredump.intra.peff.net>
References: <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <7vhbr2pcsh.fsf@alter.siamese.dyndns.org>
 <7v4on2pciw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 08:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRhNe-0007jA-0M
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 08:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0ADH3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 02:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223Ab0ADH33
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 02:29:29 -0500
Received: from peff.net ([208.65.91.99]:34304 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab0ADH33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 02:29:29 -0500
Received: (qmail 13097 invoked by uid 107); 4 Jan 2010 07:34:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 02:34:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 02:29:26 -0500
Content-Disposition: inline
In-Reply-To: <7v4on2pciw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136101>

On Sun, Jan 03, 2010 at 11:14:31PM -0800, Junio C Hamano wrote:

> > I vaguely recall that somebody fairly competent mentioned that modern grep
> > implementations are based on DFA engines, but I offhand don't remember if
> > the discussion had concrete numbers.
> 
> I found only this one.  The author was indeed somebody fairly competent.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/23798

Er, that link seems to be about internal grep beating external on a cold
cache because it does less I/O. Did you mean something else (maybe the
thread I pointed to in another message)?

-Peff
