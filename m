From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Fri, 15 Jan 2010 16:08:54 -0500
Message-ID: <20100115210854.GA21540@coredump.intra.peff.net>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 22:09:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtPr-0004md-5y
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab0AOVJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073Ab0AOVJA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:09:00 -0500
Received: from peff.net ([208.65.91.99]:46891 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab0AOVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:08:58 -0500
Received: (qmail 31093 invoked by uid 107); 15 Jan 2010 21:13:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 16:13:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 16:08:54 -0500
Content-Disposition: inline
In-Reply-To: <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137118>

On Fri, Jan 15, 2010 at 12:52:40PM -0800, Junio C Hamano wrote:

> Just like some people wanted diff features that are not found in
> other people's diff implementations outside of a git repository
> and added --no-index mode to the command, this adds --no-index mode
> to the "git grep" command.

Out of curiosity, what are the interesting features in git grep versus
other greps?

-Peff
