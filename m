From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] rebase -i: prepare to write reflog message for checkout
Date: Thu, 13 Jun 2013 10:52:39 -0700
Message-ID: <7v4nd1vqxk.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:52:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBhZ-00053q-W2
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758573Ab3FMRwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:52:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756256Ab3FMRwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:52:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A413627E2E;
	Thu, 13 Jun 2013 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wwoqhBQHCBkaSqcfnifD0avAjzI=; b=q2gfin
	NCHxngNmNXAzPrckfX+qtDVXLyGRlV41/pvuyNzqZg9WVznboCrXl3tz/0R5Hg6A
	bGT3yLrcRf3R2ac4Ml44wAzIEvkd0TUoLt8r/t0t0eOf98EhAZJ3mta8nQKVPLZD
	I4ov/Eh/uL3FEvf1YhW2Dw3rNAzY2ntLJH6VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VG16B76cUrh2mBDscWy0Bh4Sf0Qxek2N
	AZoOwA3VjatL0mQF48AXdeNTX/XaA3HhuKLJuj0PSWG0PRK/woWeyvS3MvtutyZn
	hDOjSRl6ViBLDACjVwYo8ku0UXAO9AlxJXLr0oLFB0/Y9/xyqeq44SUiPRDjQKlO
	+G5Omj7edBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 933D927E2C;
	Thu, 13 Jun 2013 17:52:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C90127E2A;
	Thu, 13 Jun 2013 17:52:40 +0000 (UTC)
In-Reply-To: <1371130349-30651-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 19:02:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AF24256-D452-11E2-AD0E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227757>

The same comment as 2/6 applies to this one.  What these two do
makes sense, but I think having 6/6 before them would make the
series easier to follow.
