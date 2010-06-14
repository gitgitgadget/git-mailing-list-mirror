From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 2/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Mon, 14 Jun 2010 09:44:20 +0200
Message-ID: <201006140944.20737.trast@student.ethz.ch>
References: <cover.1276336602.git.trast@student.ethz.ch> <93842467ca22405712cab23a9b3920c106df0f17.1276336602.git.trast@student.ethz.ch> <7v7hm2e27z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"SZEDER =?iso-8859-1?q?G=E1bor?=" <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 09:44:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO4LZ-0006W3-M1
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 09:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0FNHoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 03:44:37 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:12997 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851Ab0FNHog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 03:44:36 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 09:44:35 +0200
Received: from thomas.localnet (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 09:44:27 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <7v7hm2e27z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149082>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > +#       If you would like to see the difference between HEAD and its upstream,
> > +#       set GIT_PS1_SHOWUPSTREAM to one of the following:
> > +#           git          use @{upstream}
> > +#           svn          attempt to DWIM svn upstream for normal and --stdlayout
> > +#           ref <ref>    unconditionally use <ref>
> > +#           eval <code>  evaluate <code> which should print the commit to use
> 
> This looks somewhat overengineered, although "git" and "svn" are probably
> useful in real life.  I especially wonder if a fixed <ref> is useful at
> all.  Wouldn't the choice of "other" branch always depend on the current
> branch?

You're probably right.  I had 'ref' early on to test around, and then
made 'eval' to allow for arcane git-svn setups, but now that it seems
Andrew has a nice way of matching those, we can also just drop it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
