From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 03/12] send-email: Interpret --smtp-server "" as
 "use a default".
Date: Sun, 19 Apr 2009 18:41:45 -0700
Message-ID: <7v7i1gp0di.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 03:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LviXZ-0000TB-BO
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 03:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbZDTBlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 21:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbZDTBlu
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 21:41:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbZDTBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 21:41:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5924ACE0A;
	Sun, 19 Apr 2009 21:41:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AACC5ACE09; Sun,
 19 Apr 2009 21:41:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A943054-2D4C-11DE-8C3B-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116922>

Michael Witten <mfwitten@gmail.com> writes:

> Why not? It's at least useful for testing.

Why so?  "Use a default" as opposed to using what?

It is unclear what "a default" is in this context.  Do configured values
count as "a default"?  I suspect not.

I think you meant "allow overriding the configured values and use the
default", but then you should spell what the defaults are (an available
local MTA binary, or SMTP port on localhost, I think).  That is much more
informative than your "Why not?..."

In any case, I find it counterintuitive to trigger "use the default" with
an option.  Something like "--ignore-config=smtp-server,smtp-port" might
make sense, though.
