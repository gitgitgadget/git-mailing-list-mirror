From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to human 
 readable form
Date: Thu, 14 Aug 2008 16:40:39 -0700
Message-ID: <7vej4rcgi0.fsf@gitster.siamese.dyndns.org>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
 <1218752308-3173-2-git-send-email-marcus@griep.us>
 <1218752308-3173-3-git-send-email-marcus@griep.us>
 <20080814223429.GC10544@machine.or.cz>
 <7viqu3ci5k.fsf@gitster.siamese.dyndns.org>
 <20080814232459.GF10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmRx-0006yn-Qg
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYHNXkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYHNXkr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:40:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYHNXkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:40:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C1C3059DA9;
	Thu, 14 Aug 2008 19:40:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D847359DA7; Thu, 14 Aug 2008 19:40:41 -0400 (EDT)
In-Reply-To: <20080814232459.GF10360@machine.or.cz> (Petr Baudis's message of
 "Fri, 15 Aug 2008 01:24:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A87480E-6A5A-11DD-8249-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92442>

Petr Baudis <pasky@suse.cz> writes:

> Frankly, my gut feeling here is that we are overengineering the whole
> thing quite a bit, which is the same reason I dislike maxlen.

Fair enough.
