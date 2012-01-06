From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Managing signed git tags and expiring keys
Date: Fri, 06 Jan 2012 12:09:24 -0800
Message-ID: <7vk454k2yz.fsf@alter.siamese.dyndns.org>
References: <CABQG1aSY53-Z73CiUf2kstfaKLJ8zBGzu51CFdWHGiVR16JJ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
X-From: git-owner@vger.kernel.org Fri Jan 06 21:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjG6W-0000xl-Q1
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 21:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038Ab2AFUJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 15:09:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759021Ab2AFUJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 15:09:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13900675D;
	Fri,  6 Jan 2012 15:09:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lZQqv9WaKUhnTge7y1Hw7iO3MEM=; b=Ws11pv
	Tp4q64z94H8oRAyklM2uINswHNAV0zUnDvbrRB+EXwTlwDLvHiolwGxlahPK4sR4
	xXkrggMcuM3uzKmO5MkCVRcghOgSxiUFHllv3M1FjbrAd3tMBQcwN7eYQzY2Y4Qq
	rlBS8lwSzQQcSLwj3u9IaKhcO+ahCMzg5hY/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S7TOjEQKhko7+CtG/FsMGsywEwtLgPD+
	u+9PsrD95xOKDc7uTPZsC1y9dKSyM7+DWeDLqFQfyTXHAhJEGhtjJ0sgvySccBLB
	udnKZPcr1iNk2cQQSEc9d5F2JkVsN6sxrHa1XAXTM2owlm6OzbbxuOTNI4R4hNzU
	eJwwjt+HpoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0754B675C;
	Fri,  6 Jan 2012 15:09:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F002675B; Fri,  6 Jan 2012
 15:09:25 -0500 (EST)
In-Reply-To: <CABQG1aSY53-Z73CiUf2kstfaKLJ8zBGzu51CFdWHGiVR16JJ7w@mail.gmail.com>
 (Jonathan Leto's message of "Fri, 6 Jan 2012 00:13:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54C6406E-38A2-11E1-83C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188045>

"Jonathan \"Duke\" Leto" <jonathan@leto.net> writes:

> When the key changes, all existing tags are signed with the previous
> key in the chain of trust.
>
> Do people:
> 1) resign all the tags, causing people to overwrite their local tags
> 2) keep all versions of the keys in the chain of trust
> 3) something else more involved?
>
> Is anybody doing this currently?

Many kernel.org users (Linus and myself included) changed their signing
keys last year, so their project histories have tags signed with different
keys. I highly doubt anybody revoked old key and re-signed his tags with
new one.
