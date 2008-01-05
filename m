From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-stash clear: refuse to work with extra parameter
	for now
Date: Sat, 5 Jan 2008 05:00:28 -0500
Message-ID: <20080105100028.GB31220@coredump.intra.peff.net>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil> <477EDDD4.5060509@nrlssc.navy.mil> <20080105035118.GB26892@coredump.intra.peff.net> <871w8woc77.fsf@adler.orangeandbronze.com> <7vy7b4bon9.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: JM Ibanez <jm@orangeandbronze.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 11:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB5qA-0006pq-M1
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 11:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYAEKAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 05:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYAEKAb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 05:00:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbYAEKAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 05:00:30 -0500
Received: (qmail 23246 invoked by uid 111); 5 Jan 2008 10:00:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 05 Jan 2008 05:00:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2008 05:00:28 -0500
Content-Disposition: inline
In-Reply-To: <7vy7b4bon9.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69662>

On Sat, Jan 05, 2008 at 01:35:54AM -0800, Junio C Hamano wrote:

> I think something along this line may be necessary to
> futureproof our users. 

I think it not only futureproofs, but it helps those who misunderstand
(or don't read) the documentation from accidentally losing work.

Acked-by: Jeff King <peff@peff.net>

-Peff
