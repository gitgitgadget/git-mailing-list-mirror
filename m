From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rev-list.txt: rev stands for revision, not reverse.
Date: Thu, 01 Nov 2007 12:51:11 -0700
Message-ID: <7vr6j9bv80.fsf@gitster.siamese.dyndns.org>
References: <20071101084552.GA4934@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 20:51:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ing4n-0005YL-CC
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 20:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbXKATvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbXKATvT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 15:51:19 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:44971 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381AbXKATvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 15:51:18 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D10FA2F9;
	Thu,  1 Nov 2007 15:51:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 69EA4911C1;
	Thu,  1 Nov 2007 15:51:35 -0400 (EDT)
In-Reply-To: <20071101084552.GA4934@ins.uni-bonn.de> (Ralf Wildenhues's
	message of "Thu, 1 Nov 2007 09:45:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62985>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> Mention revs, revisions as aliases for commit objects,
> to clarify that rev-list is not an abbreviation for
> listing in reverse order, but for listing revisions.
> ---
> Yes, believe it or not, but I stumbled over the synopsis
>
> | git-rev-list - Lists commit objects in reverse chronological order
>
> asking myself whether rev could possibly mean "reverse".
> I hope this helps avoid this pitfall for others.

In addition to your patch,

	git-rev-list - List commits from most recent to older

might be a good rewording?  "rev-list --reverse" reverses that
usual order and we end up explaining double reversal if we use
the phrase "reverse chronological order" to describe the normal
order.
