From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Tue, 13 Oct 2009 08:36:53 +0200
Message-ID: <200910130836.57011.trast@student.ethz.ch>
References: <0016e68fd0123a175304754694b4@google.com> <200910122340.13366.trast@student.ethz.ch> <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 13 08:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxb4Y-0002Fr-DX
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 08:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380AbZJMGik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 02:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756276AbZJMGik
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 02:38:40 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:27117 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829AbZJMGij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 02:38:39 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 13 Oct
 2009 08:37:51 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 13 Oct
 2009 08:37:30 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130129>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Your idea is also a backwards incompatible change, so we can just as
> > well implement the original suggestion and force scripts (or us) to
> > use some other means when they want to detach.  Say, why not just
> > invent an option along the lines of
> >
> >   git checkout {-d|--detach} $ref
> >
> > to make it explicit.
> 
> Or can't you go the other way, say
> 
> 	git checkout -t $remote_tracking
> 
> to create a local branch forking from the named remote tracking branch?

Sure, but we already have that and we still failed to fix the users,
so FWIW, I think Dscho's right and we should try fixing the UI next.

[I've also seen several users shoot themselves with detached HEADs to
the point where I explain the concept before even mentioning
checkout.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
