From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 23:38:16 +0200
Message-ID: <201008052338.16668.trast@student.ethz.ch>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org> <20100805190653.GA2942@sigill> <7vd3twdbny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ted Ts'o <tytso@mit.edu>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh894-0004jL-NY
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934043Ab0HEViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 17:38:20 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:35955 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932693Ab0HEViT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:38:19 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 5 Aug
 2010 23:38:18 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 5 Aug 2010 23:38:18
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7vd3twdbny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152724>

Junio C Hamano wrote:
> *1* Also we would want to do something similar to the commit.util field so
> that more than one utility libraries can attach their own stuff to each
> commit.  It _might_ make sense to instead get rid of commit.util and
> migrate the users to a separate "one object hash per one type of info",
> though.  In any case it is a separate topic.

I thought this already existed in decorate.c?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
