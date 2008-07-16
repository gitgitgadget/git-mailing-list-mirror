From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] add pack index v2 reading capability to git v1.4.4.4
Date: Wed, 16 Jul 2008 10:08:05 -0700
Message-ID: <7vhcapsqoa.fsf@gitster.siamese.dyndns.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <alpine.LFD.1.10.0807160924340.2835@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJAV6-0001Y1-J1
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 19:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbYGPRIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 13:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757058AbYGPRIN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 13:08:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854AbYGPRIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 13:08:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3ED4C2E1E2;
	Wed, 16 Jul 2008 13:08:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D6EEE2E1E0; Wed, 16 Jul 2008 13:08:07 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807160924340.2835@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 16 Jul 2008 09:25:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5878092-5359-11DD-A94A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88697>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Actually, it fixes a crash. Didn't 1.4.4 SIGSEGV without this on pack-v2?

I do not think it should SEGV.  The pack-idx signature was chosen rather
carefully to allow older ones to die gracefully.

    error: non-monotonic index
    error: Could not read 4a588075c54cd5902e5f4d43b9d6b0c31d0f9769

But as I said in the other message, it's tagged and pushed out already.
