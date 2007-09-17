From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: testsuite problems
Date: Mon, 17 Sep 2007 23:50:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709172350190.28586@racer.site>
References: <20070917211742.GF19019@genesis.frugalware.org>
 <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org>
 <Pine.LNX.4.64.0709172337470.28586@racer.site> <20070917224828.GI19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPRW-0008P0-Or
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbXIQWv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755888AbXIQWv1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:51:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:35763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755364AbXIQWv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:51:26 -0400
Received: (qmail invoked by alias); 17 Sep 2007 22:51:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 18 Sep 2007 00:51:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZVTM5cK9ZPUQdIjsRu36y8Rck9UWkUck30qT3W8
	RWPgkZHEmn7UZn
X-X-Sender: gene099@racer.site
In-Reply-To: <20070917224828.GI19019@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58490>

Hi,

On Tue, 18 Sep 2007, Miklos Vajna wrote:

> On Mon, Sep 17, 2007 at 11:40:27PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Ah, that's my friend GNU diff again... Try running the test with "-i -v", 
> > and it will pass, if I am right.
> 
> * expecting success: diff -r a d/a
> diff -r a/l1 d/a/l1
> 1c1
> < simple textfile
> ---
> > a
> \ No newline at end of file
> * FAIL 21: validate file contents
>         diff -r a d/a
> 
> it still fails, so i don't think this is that issue

Oops.  I blame it on tiredness...

Sorry for the noise,
Dscho
