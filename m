From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 02:37:34 -0800
Message-ID: <7vsl39i041.fsf@gitster.siamese.dyndns.org>
References: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 11:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsFd7-0001dQ-Bq
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 11:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbXKNKhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 05:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXKNKhj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 05:37:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34279 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbXKNKhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 05:37:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E70E92F2;
	Wed, 14 Nov 2007 05:37:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D4A7946FB;
	Wed, 14 Nov 2007 05:37:57 -0500 (EST)
In-Reply-To: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com> (Wincent
	Colaiuta's message of "Wed, 14 Nov 2007 11:19:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64979>

Wincent Colaiuta <win@wincent.com> writes:

> A statistician could probably make some interesting comments about the  
> results, but the basic trend is that, while there are plenty of  
> examples of isolated long lines in the source tree (the longest is a  
> 287-character line in one of the perl scripts), the frequency starts  
> to drop off pretty rapidly once you pass 70 columns and start climbing  
> towards 80.

Gaah.  287???

> + - In the case of documentation, mixing excessively long and short
> +   lines may make the AsciiDoc source harder to read, so try to
> +   keep line lengths consistent.
> +
> + - When submitting patches use common sense to decide whether to
> +   rewrap, avoiding gratuitous changes.

Hmph.  The last item applies only to the documentation because
it uses the word "rewrap", but otherwise applies equally well to
the sources (re-indenting).  So probably "whether to rewrap or
reindent" would be a good change there.
