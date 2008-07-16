From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Wed, 16 Jul 2008 03:47:11 +0200
Message-ID: <20080716014711.GD31732@leksak.fem-net>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com, Joe Fiorini <joe@faithfulgeek.org>,
	git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIw85-0004HE-CF
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238AbYGPBrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758318AbYGPBrS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:47:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:43336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758247AbYGPBrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:47:17 -0400
Received: (qmail invoked by alias); 16 Jul 2008 01:47:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp032) with SMTP; 16 Jul 2008 03:47:15 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/EsDVMnqPECDdG0F6SgU4Nn5hppeV6CJoD+tkAEj
	8yGx7tyKXFDF98
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KIw6p-0002s5-CF; Wed, 16 Jul 2008 03:47:11 +0200
Content-Disposition: inline
In-Reply-To: <20080716012619.GM8185@mit.edu>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88627>

Hi,

Theodore Tso wrote:
> While you have "git am" open, how about adding an "git am --abort"
> which nukes the .dotest aka .git/rebase directory, and resets HEAD
> back to the original position?

Perhaps it will not conform you, but my sequencer patchset (coming
tomorrow or the day after, I think), will add --abort as a trivial
patch (running sequencer --abort).

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
