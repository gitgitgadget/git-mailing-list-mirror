From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RED] git-init: Cannot setup bare repository
Date: Mon, 27 Aug 2007 03:01:53 -0700
Message-ID: <7vtzqljnxq.fsf@gitster.siamese.dyndns.org>
References: <20070826204531.11592.36481.stgit@rover>
	<Pine.LNX.4.64.0708270949590.28586@racer.site>
	<20070827095523.GQ1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbQM-0006kn-RO
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXH0KB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXH0KB6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:01:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbXH0KB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:01:58 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 35AE7127ADC;
	Mon, 27 Aug 2007 06:02:17 -0400 (EDT)
In-Reply-To: <20070827095523.GQ1219@pasky.or.cz> (Petr Baudis's message of
	"Mon, 27 Aug 2007 11:55:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56802>

Petr Baudis <pasky@suse.cz> writes:

> On Mon, Aug 27, 2007 at 10:51:04AM CEST, Johannes Schindelin wrote:
>> On Sun, 26 Aug 2007, Petr Baudis wrote:
>> ...
>> You were too busy playing Go, probably, so you missed my patch which tried 
>> to fix this issue.  Alas, it broke more than it fixed, so it was just 
>> worked around for git-clone --bare.
>
>   AFAICS that patch is already applied as well; I tried to ask on IRC
> for more fixes but seemed there is none and Junio almost threatened to
> even release 1.5.3 with this bug. ;-) Well, I just needed something that
> would fix this on repo.or.cz which totally broke after upgrade to new
> Git version.

Heh, "threaten" is a good word.  Could you two help me with this
issue?  I suspect you (and probably Shawn) have the most "old
fashioned" scripts that rather rely on pre-work-tree behaviour
and have better chance than others to catch unintended side
effects like the current "git --bare init"  issues.
