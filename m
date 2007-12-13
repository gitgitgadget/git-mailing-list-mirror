From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-commit: squelch needless message during an empty
	merge
Date: Wed, 12 Dec 2007 23:34:28 -0500
Message-ID: <20071213043428.GB24213@coredump.intra.peff.net>
References: <7vabpg9x5k.fsf@gitster.siamese.dyndns.org> <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> <7v1w9r5m03.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 05:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2fmj-0000VE-0d
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 05:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbXLMEec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 23:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXLMEeb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 23:34:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4048 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbXLMEeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 23:34:31 -0500
Received: (qmail 7177 invoked by uid 111); 13 Dec 2007 04:34:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Dec 2007 23:34:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 23:34:28 -0500
Content-Disposition: inline
In-Reply-To: <7v1w9r5m03.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68118>

On Wed, Dec 12, 2007 at 07:09:16PM -0800, Junio C Hamano wrote:

> This introduces "nowarn" parameter to run_status() to avoid these
> useless messages.  If we are not allowed to create an empty commit, we
> already call run_status() again in the original codepath, and the
> message will be shown from that call anyway.

Looks good to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
