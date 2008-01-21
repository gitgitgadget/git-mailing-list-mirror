From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 11:04:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211101450.5731@racer.site>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org> <alpine.LSU.1.00.0801191119050.5731@racer.site> <7vd4rw6siv.fsf@gitster.siamese.dyndns.org> <479438D1.2050107@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGuTO-0006yR-IP
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbYAULEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757417AbYAULEr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:04:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:59902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757357AbYAULEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 06:04:46 -0500
Received: (qmail invoked by alias); 21 Jan 2008 11:04:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 21 Jan 2008 12:04:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jgwpum9lj/zEzlo9vB7rRn3gcpqn1qdZAnqUNcu
	1qlzciyEw8YdzQ
X-X-Sender: gene099@racer.site
In-Reply-To: <479438D1.2050107@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71259>

Hi,

On Mon, 21 Jan 2008, Paolo Bonzini wrote:

> I would like to understand why both of you have not considered the point 
> that the script would need the updated index from git-commit.

I have.  But I want to avoid a regression at any cost.  And your patch 
just looks to me like it could do that.

But it _has_ been already suggested that you could provide arguments for 
the existing msg-hook, which would not break anything, since the hook does 
not get any argument yet, and therefore existing hooks would be 
unaffected.

Also, the change would be non-intrusive, easy-to-review, and it would not 
take so much time away from the bug-fixing that we want to do right now in 
the rc-cycle.

Okay?
Dscho
