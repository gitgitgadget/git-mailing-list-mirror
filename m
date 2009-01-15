From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Thu, 15 Jan 2009 01:49:02 +0100
Message-ID: <20090115004902.GE32313@leksak.fem-net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGRV-0000sD-Tu
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542AbZAOAtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757925AbZAOAtS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:49:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:39352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757352AbZAOAtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:49:17 -0500
Received: (qmail invoked by alias); 15 Jan 2009 00:49:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp019) with SMTP; 15 Jan 2009 01:49:15 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19x+1NQpmtxq93f5SOlW/5KT5TI0SIR5ZLDdm5ST2
	B3FPp4rlumkQKZ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNGPu-0000Jq-QC; Thu, 15 Jan 2009 01:49:02 +0100
Content-Disposition: inline
In-Reply-To: <87ab9th0rh.fsf@cup.kalibalik.dk>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105746>

Hi,

Anders Melchiorsen wrote:
> As I expect this to not be acceptable due to compatibility concerns, I
> have not tested it much. The patch is mostly to catch some attention,
> but I will be happy to complete it if there is interest in the change.

I think I like it and I think it's not the first time this comes up on
the list. (Not sure, and too lazy to grab the archives.)

Also, in the design process of "git-sequencer" we (at least my mentors
and I) discussed about doing this ("edit" vs "pause"), too, but it is
always bad to change behavior many people are used, too.
But sequencer instructions support options. So this could be solved as
an option for "edit", e.g. "edit --no-commit" (or "edit -n").

So I'm writing this on my TODO list for the time after sequencer is
merged into git...

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
