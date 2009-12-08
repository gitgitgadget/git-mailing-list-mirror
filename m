From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git config does not reuse section name
Date: Tue, 8 Dec 2009 03:05:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912080304290.4985@pacific.mpi-cbg.de>
References: <4B1D360B.4070203@ubicom.com> <7vy6le35zv.fsf@alter.siamese.dyndns.org> <fabb9a1e0912071223l21c70e2ax9b0e3c9976ae9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 03:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHpOi-0004vf-BC
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 03:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935577AbZLHCBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 21:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbZLHCB3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 21:01:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:56067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934933AbZLHCB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 21:01:27 -0500
Received: (qmail invoked by alias); 08 Dec 2009 02:01:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 08 Dec 2009 03:01:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19f7tVjix5fNhGHLEImxSFfOzxgoJIPeliIa3sYdr
	VMto5YJqfnutsY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0912071223l21c70e2ax9b0e3c9976ae9d7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134802>

Hi,

On Mon, 7 Dec 2009, Sverre Rabbelier wrote:

> On Mon, Dec 7, 2009 at 21:04, Junio C Hamano <gitster@pobox.com> wrote:
> > If I recall correctly, this hasn't been even 
> > noticed/reported/recognized as an issue, ever since the "git 
> > repo-config" was introduced (which later was renamed to "git config").
> 
> I poked Dscho about it at some point.
> 
> > Dscho, do you remember details?
> 
> He told me that the 'git config' code is so horrible that it's 
> nigh-impossible to change the behavior, hence why he didn't do it :P.

Actually, I said something about the most obvious route being to re-use 
git_config() and that this approach had its limitations.

I also said that I earned (probably rightfully) a reputation of lousy code 
with Junio, which makes me think that I probably should refrain from ever 
contributing code to Git again.

Ciao,
Dscho
