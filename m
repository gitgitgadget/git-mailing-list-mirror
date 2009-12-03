From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 3 Dec 2009 04:25:21 -0500
Message-ID: <20091203092521.GA3620@coredump.intra.peff.net>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 10:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG7wH-0002BV-Nb
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 10:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbZLCJZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 04:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbZLCJZQ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 04:25:16 -0500
Received: from peff.net ([208.65.91.99]:45383 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbZLCJZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 04:25:15 -0500
Received: (qmail 12966 invoked by uid 107); 3 Dec 2009 09:29:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 03 Dec 2009 04:29:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Dec 2009 04:25:21 -0500
Content-Disposition: inline
In-Reply-To: <7v638o76ra.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134444>

On Thu, Dec 03, 2009 at 01:21:13AM -0800, Junio C Hamano wrote:

>  * "git pack-objects --all-progress" is an option to ask progress output
>    from write-object phase _if_ progress output were to be produced, and
>    shouldn't have forced the progress output.

Shouldn't this actually be --all-progress-implied? Nico's patch
intentionally kept --all-progress with the same behavior.

-Peff
