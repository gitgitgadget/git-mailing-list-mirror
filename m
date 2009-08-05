From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Implement git-vcs-p4
Date: Wed, 05 Aug 2009 11:45:51 -0700
Message-ID: <7vws5i3xr4.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908050056580.2147@iabervon.org>
 <7vocqu9mzx.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908051424370.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Pete Wyckoff <pw@padd.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlV6-0006Cw-TE
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbZHESp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbZHESp7
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:45:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZHESp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:45:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8586921DEE;
	Wed,  5 Aug 2009 14:45:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C5EA21DEB; Wed, 
 5 Aug 2009 14:45:53 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0908051424370.2147@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 5 Aug 2009 14\:32\:49 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 372A4570-81F0-11DE-A86C-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124950>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> But we need to disable this in the Makefile by default and force
>> interested parties to explicitly ask for it if we were to do that.
>
> ... The Makefile only tries to build against the API if 
> configured to have the location of it;...

Ah, ok, that is exactly what I meant.  I just didn't want to suddenly
break people who routinely did "git pull && make test".
