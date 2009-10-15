From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: quote in help code example
Date: Thu, 15 Oct 2009 14:02:55 +0200
Message-ID: <200910151402.56295.trast@student.ethz.ch>
References: <20091012102926.GA3937@debian.b2j> <20091013153031.GX23777@genesis.frugalware.org> <200910132215.46840.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 14:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyP6i-000679-Vg
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 14:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762719AbZJOMEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 08:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762710AbZJOMEk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 08:04:40 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:27741 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758479AbZJOMEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 08:04:39 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 15 Oct
 2009 14:03:50 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 15 Oct
 2009 14:03:30 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <200910132215.46840.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130389>

Thomas Rast wrote:
> 
> The patch below just replaces said template with a no-op for git's
> manpage creation.  I have not been able to substantiate the claim that
> apostrophes are special, and in fact with the patch my manpages look
> fine.  Then again I don't know anything about roff syntax either, and
> manuals seem a bit hard to come by.

Actually, scratch the patch.  I haven't been able to nail it yet, and
I'm not sure I have the energy for another stab at this mess; but
during testing with older versions, I learned that they behave
differently and the patch just shifts the breakage a bit.

Also, the single quotes are apparently special at the beginning of a
line and to delimit function arguments, though not elsewhere.  The
bash manpage uses \(aq to get a literal apostrophe, which I will aim
to convert them to.  Oddly enough, the groff(7) manpage does not
document \(aq, but lists \(cq as the official escape for ' ... which
then turns out to mutate into this cursed non-apostrophe again.  Sigh.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
