From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] strbuf's in builtin-apply
Date: Sun, 16 Sep 2007 15:54:50 -0700
Message-ID: <7v3axe5ih1.fsf@gitster.siamese.dyndns.org>
References: <20070915141210.GA27494@artemis.corp>
	<20070916172134.GA26457@artemis.corp>
	<20070916172833.GB26457@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 00:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX310-0006Gt-Qi
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbXIPWyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbXIPWyz
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:54:55 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbXIPWyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:54:54 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AE30F1364E9;
	Sun, 16 Sep 2007 18:55:13 -0400 (EDT)
In-Reply-To: <20070916172833.GB26457@artemis.corp> (Pierre Habouzit's message
	of "Sun, 16 Sep 2007 19:28:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58365>

Pierre Habouzit <madcoder@debian.org> writes:

> The builtin-apply part:
>   [1/6] New strbuf APIs: splice and attach.
>   [2/6] Rewrite convert_to_{git,working_tree} to use strbuf's.
>   [3/6] Now that cache.h needs strbuf.h, remove useless includes.
>   [4/6] builtin-apply: use strbuf's instead of buffer_desc's.
>
> And the two somehow more independant patches (need 1/6 still):
>   [5/6] Refactor replace_encoding_header.
>   [6/6] Remove preemptive allocations.

Quite nice.  Thanks, will queue.
