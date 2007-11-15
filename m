From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Unify the use of standard set of exclude files
Date: Thu, 15 Nov 2007 01:03:05 -0800
Message-ID: <7vbq9v6fue.fsf@gitster.siamese.dyndns.org>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
	<7v4pfo813i.fsf_-_@gitster.siamese.dyndns.org>
	<20071115070429.GD10185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, shunichi fuji <palglowr@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsadN-0005FF-M5
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148AbXKOJDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbXKOJDQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:03:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59567 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143AbXKOJDO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:03:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E1D2B2F2;
	Thu, 15 Nov 2007 04:03:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 46C0D94E93;
	Thu, 15 Nov 2007 04:03:29 -0500 (EST)
In-Reply-To: <20071115070429.GD10185@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 15 Nov 2007 02:04:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65096>

Jeff King <peff@peff.net> writes:

> git-add--interactive:list_untracked needs something like this, but I
> don't think your patch will work. We need something more like this (also
> on maint because your standard exclude patch is):
>
> -- >8 --
> git-ls-files: add --exclude-standard
>
> This provides a way for scripts to get at the new standard exclude
> function.

I like this, along with the patch to add--interactive.

Will forge your signature ;-).
