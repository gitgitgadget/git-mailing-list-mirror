From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch--tool and contrib/examples/git-fetch.sh
Date: Thu, 15 Nov 2007 21:16:15 -0800
Message-ID: <7vzlxe22jk.fsf@gitster.siamese.dyndns.org>
References: <473C45A8.7020903@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Fri Nov 16 06:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IstZJ-0007Zh-Lk
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 06:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXKPFQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 00:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbXKPFQY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 00:16:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51574 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbXKPFQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 00:16:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 59F622F0;
	Fri, 16 Nov 2007 00:16:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DD409934F8;
	Fri, 16 Nov 2007 00:16:39 -0500 (EST)
In-Reply-To: <473C45A8.7020903@lu.unisi.ch> (Paolo Bonzini's message of "Thu,
	15 Nov 2007 14:12:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65191>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> When git-fetch was builtin-ized the previous script was moved to
> contrib/examples.  Now, it is the sole remaining user for most of
> git-parse-remote (except for get_remote_url) and for git-fetch--tool.

Yeah, moving them when they cease to be used to contrib/examples
would be a good thing to do.
