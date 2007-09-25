From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Tue, 25 Sep 2007 11:33:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251132110.28395@racer.site>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
 <7vhcllc9bz.fsf@gitster.siamese.dyndns.org> <85ps08k2fj.fsf@lola.goethe.zz>
 <86bqbsta3g.fsf@lola.quinscape.zz> <7vodfr8wts.fsf@gitster.siamese.dyndns.org>
 <85hcljgtlr.fsf@lola.goethe.zz> <7v4phj6yxb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7kj-0001r0-FF
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbXIYKer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbXIYKer
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:34:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751752AbXIYKeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:34:46 -0400
Received: (qmail invoked by alias); 25 Sep 2007 10:34:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 25 Sep 2007 12:34:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TKeFh83vTETaLKb7rsyeUSWZ8tmql4Vtv0dVbdT
	0cHYVUy4M6Qfbm
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4phj6yxb.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59109>

Hi,

On Mon, 24 Sep 2007, Junio C Hamano wrote:

> David Kastrup <dak@gnu.org> writes:
> 
> > As a completely irrelevant side note: the autoconf documentation 
> > mentions that "false" is more portable than "true" since calling it 
> > returns a non-zero exit status even when it is not installed or 
> > built-in.
> 
> Ah, I like that ;-)  It is obvious when you think about it, and it is so 
> true but in a very twisted way...

But would you not have to redirect stderr to /dev/null, then?

In the same vein, we could replace "true" by "! false".

That's such a good idea that I'll go and make a patch.

Ciao,
Dscho
