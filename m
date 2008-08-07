From: Junio C Hamano <gitster@pobox.com>
Subject: Re: NO_MMAP and cygwin
Date: Wed, 06 Aug 2008 20:07:58 -0700
Message-ID: <7vljz9ldyp.fsf@gitster.siamese.dyndns.org>
References: <489A5ED7.7060100@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 07 05:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQvsF-0002HT-NL
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 05:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYHGDII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 23:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbYHGDIH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 23:08:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYHGDIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 23:08:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1C914E8C4;
	Wed,  6 Aug 2008 23:08:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B44DF4E8C1; Wed,  6 Aug 2008 23:08:00 -0400 (EDT)
In-Reply-To: <489A5ED7.7060100@griep.us> (Marcus Griep's message of "Wed, 06
 Aug 2008 22:32:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CE377AE-642E-11DD-B0A4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91558>

Marcus Griep <marcus@griep.us> writes:

> Is there any reason that NO_MMAP should continue to be
> set by default for cygwin?

Think of it not as the one true way but a mere hint that suggests the safe
default.
