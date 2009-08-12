From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] more changes to port rebase -i to C using
 sequencer code
Date: Wed, 12 Aug 2009 14:49:10 -0700
Message-ID: <7vljlowvmx.fsf@alter.siamese.dyndns.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbLhJ-0002Qy-QE
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 23:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZHLVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZHLVtU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 17:49:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbZHLVtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 17:49:19 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D1598B9C;
	Wed, 12 Aug 2009 17:49:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CE238B9B; Wed, 12 Aug
 2009 17:49:12 -0400 (EDT)
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed\, 12 Aug 2009 07\:15\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD1ACD2E-8789-11DE-A1F7-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125751>

Christian Couder <chriscool@tuxfamily.org> writes:

> These is just the current state of my work.
> Some patches have already been sent but are not yet in pu.

It seems that some later patches in the series are "oops, the earlier one
made mistakes and this patch fixes them".  Could you fix them where they
were introduced?
