From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: try lazy read of config only once
Date: Fri, 4 Jan 2008 03:40:24 -0500
Message-ID: <20080104084024.GA3522@coredump.intra.peff.net>
References: <20080104083116.GA3354@coredump.intra.peff.net> <7v1w8ym1g6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:40:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAi6n-0000zq-Va
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYADIk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbYADIk1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:40:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2321 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbYADIk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:40:27 -0500
Received: (qmail 15977 invoked by uid 111); 4 Jan 2008 08:40:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:40:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:40:24 -0500
Content-Disposition: inline
In-Reply-To: <7v1w8ym1g6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69564>

On Fri, Jan 04, 2008 at 12:36:57AM -0800, Junio C Hamano wrote:

> Thanks.  I think you can lose "if (!user_diff_tail)" there as
> well.

Oops, yes. Please mark it up when you apply.

-Peff
