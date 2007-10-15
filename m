From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 16:39:54 -0700
Organization: Bluelane
Message-ID: <4713FA4A.5090501@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhZnL-0004vN-TR
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 01:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbXJOX4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 19:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbXJOX4O
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 19:56:14 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56806 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755202AbXJOX4N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 19:56:13 -0400
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2007 19:56:13 EDT
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 Oct 2007 19:39:58 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 15 Oct 2007 23:39:58.0684 (UTC) FILETIME=[B29DB9C0:01C80F84]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61054>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Mon, 9 Jul 2007, VMiklos wrote:
>>> I think bk can export to CVS and then git can import from CVS.
>> i think so
> 
> That's how I did my kernel history, and cvsps has a special "BK mode", 
> which knows to trust the CVS timestamps more when importing from a BK CVS 
> archive (since the timestamps will then be exact).
> 
> That said, the quality of the result isn't stellar. The CVS export will 
> obviously linearize the BK information, so you do lose things. So there's 
> actually a better kernel BK->git archive around which doesn't do that, but 
> that was done apparently from a custom database, so it's not reproducible.
> 
> 			Linus
> -

We have a CVS repository that we want to import into bitkeeper. I tried
the bk import option, including with a branch bug fix, but it's
still having problems.

I imported the CVS repository to git and it worked great. Since all
of our other repository are in bitkeeper the management would like to
stick with CVS. With git apparently still being weak in the area of
supporting difftool on different version that seems somewhat reasonable
for the time being.

The folks at bitmover are converting you kernels to bk and it's
maintaining the branch history and I'd like to do the same. So far
they haven't help us convert the git repository to bk. Do you happen
to know of someone else that might now how to do this in case the
folks at bitmover can't provide the scripts to convert this git
repository to bk?

I was curious why the difftool paradigm hasn't been integrated into
the git GUIs. It's very comfortable and I think it has been used in
other source code control systems, for example Sun Microsystems.

- -piet

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHE/pKJICwm/rv3hoRAs/QAJoDL0HQDaOAI1x6UakEiVvti9tI2wCfUpGI
bfyKH+ykUK7p2AL9CSE+XXc=
=0gnp
-----END PGP SIGNATURE-----
