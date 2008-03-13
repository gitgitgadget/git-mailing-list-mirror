From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/16] add test_cmp function for test scripts
Date: Thu, 13 Mar 2008 08:08:21 -0400
Message-ID: <20080313120821.GA19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213636.GG26286@coredump.intra.peff.net> <7vmyp34mn6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 13:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZmFU-00016J-FD
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 13:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbYCMMIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbYCMMIZ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:08:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4510 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341AbYCMMIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:08:24 -0400
Received: (qmail 26678 invoked by uid 111); 13 Mar 2008 12:08:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 08:08:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 08:08:21 -0400
Content-Disposition: inline
In-Reply-To: <7vmyp34mn6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77065>

On Wed, Mar 12, 2008 at 03:12:45PM -0700, Junio C Hamano wrote:

> I think I have an earlier round of this in 'pu'.

Oops, so you do. I remember discussing it but didn't recall a patch
coming out of it.

I see you have queued mine now in pu over yours. I actually think yours
looks a little nicer (you sanity-check the comparator, and you are more
careful with stdin (something that I considered, but figured we could
add if something actually broke)).

Any reason not to keep your existing one over mine?

-Peff
