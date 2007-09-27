From: Junio C Hamano <gitster@pobox.com>
Subject: Re: History over-simplification
Date: Wed, 26 Sep 2007 22:34:29 -0700
Message-ID: <7v4phgzn6i.fsf@gitster.siamese.dyndns.org>
References: <20070927045640.31040.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Sep 27 07:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iam1N-0001lP-3v
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbXI0Feg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 01:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbXI0Feg
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:34:36 -0400
Received: from rune.pobox.com ([208.210.124.79]:54996 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbXI0Fef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:34:35 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DC1A813C6FF;
	Thu, 27 Sep 2007 01:34:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 37A4113C6FE;
	Thu, 27 Sep 2007 01:34:53 -0400 (EDT)
In-Reply-To: <20070927045640.31040.qmail@science.horizon.com>
	(linux@horizon.com's message of "27 Sep 2007 00:56:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59264>

linux@horizon.com writes:

> These seem like roundabout ways of expressing the requirement.
> The desired rule is "no silent changes in the simplified history".
> E.g. if the revision history of a particular file is:
>
>       +-C-+
>      /     \
> A---B       B---D
>      \     /
>       +-B-+
>
> Then the normal code will notice that there are no changes on the
> lower branch, prune the merge entirely, and simplify to A---B---C---D.
> This is, however, misleading; the true history is A---B---C---B---D.

Do you denote the same content with the same letter in the
above?

If so, wouldn't the simplified history be just A-B-D?
