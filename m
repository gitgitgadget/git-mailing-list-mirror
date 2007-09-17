From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-apply: complain about >=8 consecutive spaces in initial indent
Date: Sun, 16 Sep 2007 17:24:31 -0700
Message-ID: <7vy7f63zr4.fsf@gitster.siamese.dyndns.org>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
	<11899829424173-git-send-email-bfields@citi.umich.edu>
	<1189982942187-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 17 02:24:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX4Pp-0006jb-4s
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 02:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXIQAYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 20:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXIQAYg
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 20:24:36 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXIQAYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 20:24:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D80821362EC;
	Sun, 16 Sep 2007 20:24:54 -0400 (EDT)
In-Reply-To: <1189982942187-git-send-email-bfields@citi.umich.edu> (J. Bruce
	Fields's message of "Sun, 16 Sep 2007 18:49:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58367>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> Complain if we find 8 spaces or more in a row as part of the initial
> whitespace on a line, and (with --whitespace=stripspace) replace such by
> a tab.
>
> Well, linux's checkpatch.pl complains about this sort of thing.

Some people program in Python, so I am afraid that this needs to
be a separate option.

Maybe it is time to redo the --whitespace options as bitmasks so
that we can say --whitespace-fix=tab,tail,lines to pick and
choose which kinds of breakage to fix?
