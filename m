From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: color statistics (stat, shortstat, numstat)
Date: Fri, 24 Apr 2009 16:01:36 -0700
Message-ID: <7vbpqlac6n.fsf@gitster.siamese.dyndns.org>
References: <200904222313.50081.markus.heidelberg@web.de>
 <1240610808-7285-2-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUQP-0003yl-U9
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZDXXBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZDXXBm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:01:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbZDXXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:01:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AFFD911477;
	Fri, 24 Apr 2009 19:01:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 136D711476; Fri,
 24 Apr 2009 19:01:37 -0400 (EDT)
In-Reply-To: <1240610808-7285-2-git-send-email-markus.heidelberg@web.de>
 (Markus Heidelberg's message of "Sat, 25 Apr 2009 00:06:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF4458AE-3123-11DE-87D3-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117509>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> stat/shortstat:
> Color added and removed lines and the corresponding signs ('+' and '-')
> in the summary.
>
> numstat:
> Color added and removed lines per file.

I find this extremely unreadable.  Also numstat being for porcelain use, I
do not see the point.

I think [1/2] that removes the (plain)coloring of the stat summary text is
Ok.  The code is painting the stat summary in the same color as the
filenames in the stat graph, and the default "plain" color happens to be
"do not color--just use the terminal default", so it probably does not
have any practical difference.
