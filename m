From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] Ensure consistent usage of mergetool.keepBackup
 in git
Date: Sat, 11 Apr 2009 12:23:09 -0700
Message-ID: <7vljq7dmg2.fsf@gitster.siamese.dyndns.org>
References: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl> <9a358c8b6275a7103eb036a2d1d6073bcf191e09.1239376248.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipH-0004sO-He
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758956AbZDKTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758961AbZDKTXV
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:23:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758936AbZDKTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:23:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 349E9EEA0;
	Sat, 11 Apr 2009 15:23:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4700CEE9B; Sat,
 11 Apr 2009 15:23:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3763414A-26CE-11DE-BFED-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116330>

Ferry Huberts <ferry.huberts@pelagic.nl> writes:

> In several places merge.keepBackup is used i.s.o.
> mergetool.keepBackup. This patch makes it all
> consistent for git

A silly question.  The above makes it sound as if both merge.keepBackup
and mergetool.keepBackup are valid, but the latter is preferred, and your
patch makes things consistent even though without it there is nothing
broken per-se.

Is that really is the case?

Otherwise, perhaps the title and the message should read like this:

    Fix misspelled mergetool.keepBackup
    
    In several places mergetool.keepBackup was misspelled as merge.keepBackup.
    
    Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
