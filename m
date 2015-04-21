From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: enable large transactions
Date: Tue, 21 Apr 2015 10:22:56 -0700
Message-ID: <xmqq618piefj.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
	<1429576506-10790-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:23:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykbt2-0006XG-W3
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbbDURW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:22:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755264AbbDURW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:22:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F64D4A51A;
	Tue, 21 Apr 2015 13:22:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aSUNFLp7GW2mgi7jyALdksX7jHY=; b=c26my6
	tPKKSMomxubjVs4GLjiCcsmOKp0/Z8L5PECgNsjphkElCc/ucG6CE9OgDHQ+30ce
	8HdA4wuUY/Yym9P5r4xt7nLmeuKwwABQIetiWShPeS/rTJSNWPoefWHtE9cpnGUN
	khsjOmxF48aejRV7+tTFRwinAdoM1Ms9rZObk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O6FiszZlwwClfsRLPcXwN8c/I1grOJYj
	pBKjK+pwz2edlyVHe+syNU0tQRMj8pQXb0flvO7V9scMNz7mE2XHwyjIM8HCz8wZ
	JD2cqjgxP67z9QYWxyecJoDBRGHvVwrlm/F5nZp+H4vfpJF374/FbFq6gNEVtj+w
	qo804BM7nqE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 278914A517;
	Tue, 21 Apr 2015 13:22:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89E544A514;
	Tue, 21 Apr 2015 13:22:57 -0400 (EDT)
In-Reply-To: <1429576506-10790-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 20 Apr 2015 17:35:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D913FB2-E84B-11E4-9A06-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267537>

Stefan Beller <sbeller@google.com> writes:

> This replaces the latest patch on origin/sb/remove-fd-from-ref-lock

Thanks, will replace.
