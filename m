From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Wed, 26 Mar 2008 02:22:32 -0400
Message-ID: <20080326062232.GB26286@coredump.intra.peff.net>
References: <7vmyosskyu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210134070.19665@iabervon.org> <7v3aqksic6.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211148120.19665@iabervon.org> <7vlk4boh6v.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803251841420.2775@woody.linux-foundation.org> <7vod92jh3u.fsf@gitster.siamese.dyndns.org> <7vfxuejf9d.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803260130390.19665@iabervon.org> <7vtziughqo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeP2Z-00019k-FF
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYCZGWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYCZGWf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:22:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2771 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbYCZGWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:22:34 -0400
Received: (qmail 4306 invoked by uid 111); 26 Mar 2008 06:22:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 02:22:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 02:22:32 -0400
Content-Disposition: inline
In-Reply-To: <7vtziughqo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78262>

On Tue, Mar 25, 2008 at 10:46:23PM -0700, Junio C Hamano wrote:

> I agree.  refs/*:refs/* could have been useful before --mirror, but refs/*

It still is, unless there is a way to specify --mirror in your config
file.

-Peff
