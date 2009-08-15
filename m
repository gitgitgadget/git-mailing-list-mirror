From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: do not attempt to coalesce mode changes
Date: Sat, 15 Aug 2009 11:19:24 -0700
Message-ID: <7vtz09lz2r.fsf@alter.siamese.dyndns.org>
References: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru>
 <770693df8f416615f57423141fb59f3d6eccc915.1250344341.git.trast@student.ethz.ch> <20090815141710.GA15978@sigill.intra.peff.net> <200908151635.24341.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Kirill Smelkov <kirr@mns.spb.ru>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 15 20:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McNqz-0005je-3C
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 20:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbZHOSTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbZHOSTb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 14:19:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbZHOSTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 14:19:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB4AEB8A6;
	Sat, 15 Aug 2009 14:19:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20B8AB8A4; Sat, 15 Aug
 2009 14:19:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CFB49C0-89C8-11DE-ACCE-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126016>

Thomas Rast <trast@student.ethz.ch> writes:

> Hmm.  I briefly considered worrying about futureproofing, but then
> decided it wasn't worth it since we also rely on
> coalesce_overlapping_hunks only being run over the hunks of a single
> file.

Thanks, all.
