From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: demonstrate a weakness with identical conflicts
 in different files
Date: Wed, 11 Aug 2010 16:35:22 -0700
Message-ID: <7vmxssvi2t.fsf@alter.siamese.dyndns.org>
References: <4C629495.60105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 01:36:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjKq7-0003Gf-Mv
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 01:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab0HKXgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 19:36:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab0HKXgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 19:36:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70AA4CCE9D;
	Wed, 11 Aug 2010 19:35:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p/fpOWwQGbrn2kWTh/B4eBqIEyI=; b=uKOljq
	yHLRbClGKW8JGRzFwmljFDcD6GkSO0B94EVD+fa/T42ovMBTS4B00XjQO1OzyVMk
	PpT0hdc7NNfRnq0jwe/J/UJ5+GVfl6UnjdcisBJ+6jcH2Q97vKGRdT9DhVeqqKYa
	bH0CaUZdMFzuHpXQkNU3xq97k6FuNuwzThiVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Or3mxWyALVDURa7vv99gyC3p+NlBu4YO
	lZktdVCQIWegGCydQieQTmKaIiiWJIGPokEwqkqGUquwWVnWo/u1BFrwg4H+Ub4D
	mL1xgQPFi6SZlgyJg00WkePQLp8F9BRPb2bWOuLTNaJPTZ1yF2cUNR8XWqUDEsHf
	y19Hy86jY/Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36F2FCCE96;
	Wed, 11 Aug 2010 19:35:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAC2FCCE8C; Wed, 11 Aug
 2010 19:35:23 -0400 (EDT)
In-Reply-To: <4C629495.60105@viscovery.net> (Johannes Sixt's message of
 "Wed\, 11 Aug 2010 14\:16\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23A37A32-A5A1-11DF-AD11-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153313>

Hmm, my knee-jerk reaction was that something may be keying off of the
conflict ids to keep track of which ones are dealt with and which ones are
yet to be resolved, but I don't recall any part of the implementation that
would do something like that offhand.  Sorry.

Will try to find/make time to take a look at it later.
