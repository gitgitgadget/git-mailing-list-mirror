From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-branch --with=commit
Date: Wed, 07 Nov 2007 18:05:08 -0800
Message-ID: <7vk5ot7aqz.fsf@gitster.siamese.dyndns.org>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711080008050.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 03:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipwm4-0003tF-ED
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 03:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbXKHCFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 21:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbXKHCFY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 21:05:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39930 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbXKHCFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 21:05:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BB1672EF;
	Wed,  7 Nov 2007 21:05:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B78393637;
	Wed,  7 Nov 2007 21:05:42 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711080008050.4362@racer.site> (Johannes
	Schindelin's message of "Thu, 8 Nov 2007 00:09:19 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63923>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> would it not be better to call it --containing=commit?  Besides, I think 
> that the opt_parse_with_commit() function would be better named 
> opt_parse_commit() and be put into parse-options.[ch].

git-describe has "--contains" so that may be a better match.  I
do not know the particular function is generic enough to be in
parse-options.
