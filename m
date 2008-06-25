From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Keep some git-* programs in $(bindir)
Date: Wed, 25 Jun 2008 00:19:49 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806250015580.19665@iabervon.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080621121429.GI29404@genesis.frugalware.org> <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl> <20080624160224.GA29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806241709330.9925@racer> <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
 <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:20:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMUx-00068n-9s
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYFYETv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbYFYETv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:19:51 -0400
Received: from iabervon.org ([66.92.72.58]:58045 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbYFYETv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:19:51 -0400
Received: (qmail 15066 invoked by uid 1000); 25 Jun 2008 04:19:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jun 2008 04:19:49 -0000
In-Reply-To: <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86216>

On Tue, 24 Jun 2008, Junio C Hamano wrote:

> Otherwise remote executions directly over ssh won't find them as they used
> to.  --upload-pack and --receive-pack options _could_ be used on the
> client side, but things should keep working out-of-box for older clients.
> 
> Later versions of clients (fetch-pack and send-pack) probably could start
> asking for these programs with dashless form, but that is a different
> topic.

Should they use "git upload-pack" or should they look for their helper 
programs in a libexec dir? I don't think that either of these programs is 
useful to run independantly, but I don't know if finding a program that 
doesn't go in $PATH on a remote machine is going to be any fun.

	-Daniel
*This .sig lefti ntentionally blank*
