From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow git-shell to be used as a ssh forced-command
Date: Tue, 21 Apr 2009 01:13:17 -0700
Message-ID: <7vbpqqa0gy.fsf@gitster.siamese.dyndns.org>
References: <20090418063100.GA18568@glandium.org>
 <1240292586-28192-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwB8B-0006j9-ID
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbZDUIN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbZDUINZ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:13:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbZDUINY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 04:13:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E51E610B49;
	Tue, 21 Apr 2009 04:13:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5A68E10B48; Tue,
 21 Apr 2009 04:13:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 477A5A20-2E4C-11DE-A692-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117103>

Mike Hommey <mh@glandium.org> writes:

> When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> variable to what would otherwise be passed to $SHELL -c. When this
> variable is set and git-shell was given no argument, we use it.

I might be being extremely slow, but I had an impression that I saw only
the downsides discussed in the earlier thread and did not see what use
case this is supposed to help.

Is it a valid question to ask "what's wrong with gitosis"?
