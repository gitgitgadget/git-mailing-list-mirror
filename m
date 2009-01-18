From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log-tree.c: date hardwired
Date: Sat, 17 Jan 2009 16:52:08 -0800
Message-ID: <7vbpu55tc7.fsf@gitster.siamese.dyndns.org>
References: <87r637oq41.fsf@jidanni.org> <87fxjhcy3i.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sun Jan 18 01:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLv2-00088R-SY
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbZARAwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbZARAwR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:52:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbZARAwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:52:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 157AE1CBE0;
	Sat, 17 Jan 2009 19:52:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E17F81CBDC; Sat,
 17 Jan 2009 19:52:10 -0500 (EST)
In-Reply-To: <87fxjhcy3i.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Sun, 18 Jan 2009 07:27:29 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F95E69E-E4FA-11DD-8D9D-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106120>

jidanni@jidanni.org writes:

> Can I get a go-ahead from somebody for me to begin work on implementing a fix?

No, don't "fix" it.

Please keep it as a known constant.  That way, you can come up with an
/etc/magic entry to teach find(1) that it is not just a random mailbox but
is an output from format-patch.
