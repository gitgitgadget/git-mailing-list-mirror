From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH] Add git-squash tool and tests
Date: Tue, 10 Jun 2008 01:42:08 +0200
Message-ID: <20080609234208.GE8079@leksak.fem-net>
References: <484D47C9.9050509@gnu.org> <1213043398-30524-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0806092133260.1783@racer> <484D984F.20700@gnu.org> <alpine.DEB.1.00.0806092232480.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:43:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5r1I-0007v0-Ib
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760376AbYFIXmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761904AbYFIXmP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:42:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:44415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760097AbYFIXmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:42:14 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:42:12 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp061) with SMTP; 10 Jun 2008 01:42:12 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19gNVU4w3hgiWAXTRkBMPqh64pKeogDx4KA8kB1KB
	XBrklNseLHscI6
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5r04-0000UG-RV; Tue, 10 Jun 2008 01:42:08 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806092232480.1783@racer>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84457>

> Except that zucchini is meant for the sequencer, which can implement it 
> much more efficiently (i.e. it does not have to check out HEAD~$n).  Also, 
> it must not rely on reflogs being enabled.
> 
> sequencer is plumbing, while the reset mantra is porcelain.

Do I get you right, that the builtin sequencer must not use any of the
porcelain like cherry-pick, reset and even commit?

(Perhaps I got it wrong, but it doesn't seem "right" to me, if a
plumbing uses porcelain.)

Currently my prototype *uses* these porcelain, so is it a porcelain in
its current state? ;)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
