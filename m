From: "Steven E. Harris" <seh@panix.com>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 07 Feb 2010 21:03:42 -0500
Organization: SEH Labs
Message-ID: <831vgw5vr5.fsf@torus.sehlabs.com>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
	<201002070236.12711.johan@herland.net>
	<7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
	<20100207050255.GA17049@coredump.intra.peff.net>
	<2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
	<20100207193320.GB3185@coredump.intra.peff.net>
	<7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 15:10:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeUJi-0003Ll-TG
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 15:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab0BHOKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 09:10:17 -0500
Received: from lo.gmane.org ([80.91.229.12]:47387 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120Ab0BHOKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 09:10:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NeUJY-0003EO-Ed
	for git@vger.kernel.org; Mon, 08 Feb 2010 15:10:12 +0100
Received: from c-24-23-120-65.hsd1.pa.comcast.net ([24.23.120.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 15:10:12 +0100
Received: from seh by c-24-23-120-65.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 15:10:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-120-65.hsd1.pa.comcast.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (windows-nt)
Cancel-Lock: sha1:+S6tKs1BpATMZ+R7XPtAMjJGSsQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139289>

Junio C Hamano <gitster@pobox.com> writes:

> It's like "keeping track of /etc" (or "your home directory").  It is a
> misguided thing to do because you are throwing in records of the
> states of totally unrelated things into a single history.

I've recently tried doing this again with Git, so this comment piqued my
interest. (That is, tracking changes to my various configuration files.)
I agree that browsing the history in toto is jarring, though the history
of a particular file may be telling.

Is there an alternative you'd recommend?

-- 
Steven E. Harris
