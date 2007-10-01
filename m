From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve bash prompt to detect various states like an unfinished merge
Date: Mon, 01 Oct 2007 01:15:25 -0700
Message-ID: <7vabr3tfmq.fsf@gitster.siamese.dyndns.org>
References: <20070904071301.GA18160@spearce.org>
	<1191111645134-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.sixt@telecom.at,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 10:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcGRK-0006jF-7q
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 10:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbXJAIPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 04:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbXJAIPe
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 04:15:34 -0400
Received: from rune.pobox.com ([208.210.124.79]:42502 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXJAIPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 04:15:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A7AED13F5FE;
	Mon,  1 Oct 2007 04:15:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DFCD613F5E8;
	Mon,  1 Oct 2007 04:15:48 -0400 (EDT)
In-Reply-To: <1191111645134-git-send-email-robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Sun, 30 Sep 2007 02:20:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59587>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> This patch makes the git prompt (when enabled) show if a merge or a
> rebase is unfinished. It also detects if a bisect is being done as
> well as detached checkouts.

Since you show the name of the branch anyway, I have to wonder
why you should say BISECT.

Also if you know you normally get branch name, lack of branch
name would indicate detached HEAD, I would presume.

But other state information may be helpful.
