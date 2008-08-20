From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] pull faulty 'not uptodate'
Date: Wed, 20 Aug 2008 14:22:28 -0700
Message-ID: <7v7iabpejv.fsf@gitster.siamese.dyndns.org>
References: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVv9Y-0001O1-2l
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbYHTVWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYHTVWf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:22:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYHTVWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:22:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFDF861969;
	Wed, 20 Aug 2008 17:22:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1E41961968; Wed, 20 Aug 2008 17:22:30 -0400 (EDT)
In-Reply-To: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl> (Pieter de
 Bie's message of "Wed, 20 Aug 2008 23:00:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A9FC016-6EFE-11DD-A37E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93051>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> I think git pull does not refresh the index before trying to merge:

Yeah, that is another regression from C rewrite.  Thanks for reporting.

But I also have to wonder why a git-list regular like you are reporting
this _long after_ v1.6.0-rc1 was released.  Perhaps this is not really a
big-deal bug spelled in capital letters like you have on your Subject
line?
