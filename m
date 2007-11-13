From: Jeff King <peff@peff.net>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
	repositories?
Date: Tue, 13 Nov 2007 06:40:59 -0500
Message-ID: <20071113114059.GC15845@sigill.intra.peff.net>
References: <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <vpqzlxiiii6.fsf@bauges.imag.fr> <20071113100209.GE14735@spearce.org> <vpqpryefmhj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 12:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iru93-0003By-QD
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 12:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbXKMLlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 06:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbXKMLlF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 06:41:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4447 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbXKMLlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 06:41:04 -0500
Received: (qmail 19794 invoked by uid 111); 13 Nov 2007 11:41:01 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 06:41:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 06:40:59 -0500
Content-Disposition: inline
In-Reply-To: <vpqpryefmhj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64797>

On Tue, Nov 13, 2007 at 11:50:16AM +0100, Matthieu Moy wrote:

> The "git remote add" thing adds this to my .git/config:
> 
> [remote "origin"]
>         url = /tmp/git1
>         fetch = +refs/heads/*:refs/remotes/origin/*
> 
> While clone normally does a bit more:
> 
> [remote "origin"]
>         url = /tmp/git1/.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master

Also, git-clone sets up the HEAD symref automagically (you can specify
it manually with git-remote, but git-clone will put it from the remote's
HEAD).

-Peff
