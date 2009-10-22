From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: when failing, tell the user about options that
  work
Date: Thu, 22 Oct 2009 15:26:45 -0700
Message-ID: <7v63a7f4ka.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
 <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch> <81b0412b0910220940n78ddb774i30338147327b198a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 00:27:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N167d-0000x9-II
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 00:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZJVW0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 18:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZJVW0y
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 18:26:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZJVW0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 18:26:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 123126368E;
	Thu, 22 Oct 2009 18:26:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jf2VEhG1I5r3hDB6X0FApc7xbIk=; b=nuzw+s
	IqSfvOuGzH1nqS95Xc5wBkGY6vzKZiCbvXmFGrplPbuaKsnPcMMulAlloGC455JW
	3isC/JiXaHLw9unq/3ssxsmTrC0OknoA6T6mxEiCHS8mmXPJ7VY1kQEKX4bXk9+k
	dN0dA/GhOSP11g5x1JZDSu3cQ2pOAg9JU74cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Deb4dkTdNZREmvinBcYRO5KlCKmkhwaa
	uWnoQFPTJYHuFwth8w2q+tViMAJ+CdPuw6O+E2mv1rNGfpSVHVFkUA9QKTkBZ+SR
	1b/AuOPbVmW5biH3+CWNXFMZqPeGZUZt1pZ4ObxLCsN3xKWeWAL7dWP64SMLN132
	Wio1xIssbAw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C536368B;
	Thu, 22 Oct 2009 18:26:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CF3863688; Thu, 22 Oct
 2009 18:26:46 -0400 (EDT)
In-Reply-To: <81b0412b0910220940n78ddb774i30338147327b198a@mail.gmail.com>
 (Alex Riesen's message of "Thu\, 22 Oct 2009 18\:40\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEF09EB4-BF59-11DE-93D2-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131072>

Alex Riesen <raa.lkml@gmail.com> writes:

> These are quite verbose. Could they be conditional on something like
> advice.describeHints?

Concurred.  Please make it so.
