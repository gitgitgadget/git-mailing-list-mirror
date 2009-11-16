From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 16:11:33 -0800
Message-ID: <7vtywvcoqy.fsf@alter.siamese.dyndns.org>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0911151711170.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 01:13:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9pDk-00038b-4X
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 01:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZKPALi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 19:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZKPALh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 19:11:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbZKPALh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 19:11:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 717B380DAC;
	Sun, 15 Nov 2009 19:11:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UlEpiV1xx+RUEFBxsWp8hRxiiAI=; b=NxjwbI
	taQkW3nLM2IEdpvrvkJx2rQ9/bUg0NkyR39gpLOCgtZ68o4J4q2iDh+fAKQWEZd6
	X2Z51mMpD6faDn+xw0GlvTZLsph9FOz1AnA9rajYrQ8O6D/+KIGrh3SXyfCOPJlM
	bdI4AD3t3hD07P3VCR1nL6uj1WRnjygPK1VGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+6CQzxSJEWQzfT8KHps0YXS9hqePI0n
	oZQRnoZR6SSPccwOdY6znRaiyQ5EqA1I2dmI5oeEXX/kaiPdbkBPQEm/6B8lrNEi
	2HsJilxSVjDCp2hZ2snCJatfEriKYvSKA8pPSIvMav0dHqRX6SBMkz9T+QjjBqKo
	JpLFukNZ/Ug=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5359580DAB;
	Sun, 15 Nov 2009 19:11:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91AA080DAA; Sun, 15 Nov
 2009 19:11:35 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.0911151711170.14365@iabervon.org> (Daniel
 Barkalow's message of "Sun\, 15 Nov 2009 17\:26\:51 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D1ADB0C-D244-11DE-9E53-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132974>

Daniel Barkalow <barkalow@iabervon.org> writes:

> My initial cleanup for "Allow helper to map private ref names into normal 
> names" was wrong (and the original was supposed to be RFC, and isn't 
> signed-off); I identified the bug he reported in it, but haven't gotten 
> positive test results from him yet, and the series obviously needs a 
> proper version rolled in before it goes into next.

Thanks; will wait for a re-roll.
