From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Sat, 19 Jul 2008 21:59:44 +0200
Message-ID: <20080719195944.GB5792@leksak.fem-net>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882454D.2080500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sat Jul 19 22:00:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKIbp-0004GD-MO
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 22:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYGST7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 15:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYGST7t
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 15:59:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:44174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752143AbYGST7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 15:59:49 -0400
Received: (qmail invoked by alias); 19 Jul 2008 19:59:47 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp054) with SMTP; 19 Jul 2008 21:59:47 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18vzjYMbk0vGlsZy0wOMJvOIGVxg7VoxGs1Dcn8AG
	aVBxxUoQTxpppM
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KKIam-0001jh-7D; Sat, 19 Jul 2008 21:59:44 +0200
Content-Disposition: inline
In-Reply-To: <4882454D.2080500@free.fr>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89131>

Hi,

Olivier Marin wrote:
> Note: the version that use "git sequencer" seems to work like I want
>       but I do not know if it is a side effect or not.

If you mean with "work like I want" that it complains about an unclean
work tree: the check is explicitly done by git-sequencer.

I guess there are situations where you want to apply a patch on a dirty
work tree, e.g. if you fixed some tiny issues so that patches can
apply cleanly.
But I think it does not hurt to commit such tiny changes and perhaps
squash later.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
