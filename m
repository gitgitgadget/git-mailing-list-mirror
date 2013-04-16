From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Tue, 16 Apr 2013 11:26:37 -0700
Message-ID: <7vr4ial4bm.fsf@alter.siamese.dyndns.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
 <7v4nf7qzkd.fsf@alter.siamese.dyndns.org>
 <CABPQNSaA7Qdt5eCZR3rs87gL730Y_xMrg6S-++YuaXdC2k45jg@mail.gmail.com>
 <7vsj2rpj0j.fsf@alter.siamese.dyndns.org>
 <CABPQNSZwc8Ae_fGwvyEq84NuBNntB7-KXnJtqt9ZLowCJof9Gw@mail.gmail.com>
 <516D926A.70106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAh8-0006DZ-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109Ab3DPS0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:26:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965061Ab3DPS0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:26:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E380E1768A;
	Tue, 16 Apr 2013 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21Co5VvJcFQqgDl8qN3SP+X0q+s=; b=rZntgx
	J38fdSuQ4fGaIx3WklLbMJZTrNCFHBKH6vEMvA2KKRK/ksO468Qx+xt+UKwqtkj4
	w9LF+FrhDcImq8PMM7Hc6GwsAFJmzinKczS8HzdILYbcy/20jzuciGu9W6Foo292
	Efg32z31sR5cp9NiXAuJj/0c9UiAlvpUFmEEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H9FB67yOjmriBEFPpM0jJSeIYh1nzTFk
	jkxrRe8zfGMyz+VO43iYmFrPOrp2P2dyFzzka/dO1yvCNwQFfzGJoHEMsgCQmkz4
	rttXXEkYFqVs/gcKHcqx2RMMboFK6lJo7yV1ukYY5sWfEa//M1TKCmnlmyXOyxhF
	cO4BJ1nJqyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA51F17689;
	Tue, 16 Apr 2013 18:26:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48A2E17686; Tue, 16 Apr
 2013 18:26:39 +0000 (UTC)
In-Reply-To: <516D926A.70106@kdbg.org> (Johannes Sixt's message of "Tue, 16
 Apr 2013 20:03:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DF05084-A6C3-11E2-8910-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221448>

Johannes Sixt <j6t@kdbg.org> writes:

>> I agree. I don't think we need it in maint; we don't track that branch
>> for msysGit.
>
> Yes, master is good enough.

Thanks to all those involved.  Applied.
