From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat()
 inside show_patch_diff()
Date: Wed, 28 Jan 2009 12:37:07 -0800
Message-ID: <7v63jznp58.fsf@gitster.siamese.dyndns.org>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-6-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHCg-0008BP-2I
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZA1UhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 15:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756583AbZA1UhO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:37:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597AbZA1UhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 15:37:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F13C61D7FD;
	Wed, 28 Jan 2009 15:37:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 534811D779; Wed,
 28 Jan 2009 15:37:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70C5C908-ED7B-11DD-AE32-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107571>

Kjetil Barvik <barvik@broadpark.no> writes:

> Currently inside show_patch_diff() we have and fstat() call after an
> ok lstat() call.  Since we before the call to fstat() have already
> test for the link case with S_ISLNK() the fstat() can be removed.

Good eyes.  Thanks.
