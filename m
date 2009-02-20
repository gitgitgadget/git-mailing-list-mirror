From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Thu, 19 Feb 2009 16:09:30 -0800
Message-ID: <7v8wo2klz9.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 <200902151942.15055.robin.rosenberg.lists@dewire.com>
 <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org>
 <200902192321.17802.robin.rosenberg.lists@dewire.com>
 <alpine.DEB.1.00.0902192337040.6223@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaIyx-0002E8-DH
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbZBTAJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbZBTAJk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:09:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbZBTAJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:09:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E96D2B80F;
	Thu, 19 Feb 2009 19:09:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F33F62B819; Thu,
 19 Feb 2009 19:09:31 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902192337040.6223@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Thu, 19 Feb 2009 23:44:37 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2816F40-FEE2-11DD-A862-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110767>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +for name in $names
>> +do
>> +	rm -f "$PACKDIR/old-pack-$name.idx"
>> +	rm -f "$PACKDIR/old-pack-$name.pack"
>> +done
>> +
>> +# End of pack replacement.
>
> Is this comment really needed here?

Is that hunk still needed?  I think the removal part is already there all
the way down to maint.

Other than that, I think your comments are all sane.
