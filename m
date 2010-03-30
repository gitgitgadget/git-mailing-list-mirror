From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Wed, 31 Mar 2010 00:59:33 +0200
Message-ID: <201003310059.33937.trast@student.ethz.ch>
References: <1268855753-25840-1-git-send-email-lars@pixar.com> <7vr5n44crq.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Lars R. Damerow" <lars@pixar.com>, <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:59:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkPO-0003BB-Hv
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab0C3W7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:59:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:42194 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab0C3W7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 18:59:37 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 31 Mar
 2010 00:59:36 +0200
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 31 Mar
 2010 00:59:34 +0200
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143617>

Linus Torvalds wrote:
> 
> I suspect that it is _very_ unusual to have a source repo that crosses 
> multiple filesystems, and the original reason for this patch-series seems 
> to me to be likely to be more common than that multi-fs case. So having 
> the logic go the other way would seem to match the common case, no?

Not sure if I'm the only one, but I noticed at some point that
mounting the t/ directory of git.git on tmpfs gives a huge speed boost
to the test suite...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
