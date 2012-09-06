From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Renaming a remote is 'rename', but removing is 'rm'
Date: Wed, 05 Sep 2012 20:53:22 -0700
Message-ID: <7vehmf6c3x.fsf@alter.siamese.dyndns.org>
References: <1346831961-ner-2892@calvin>
 <CACsJy8Bi=b1Fuht8q5XcnGE3rFAVojj+MAXvKZAnrqseYnDy+g@mail.gmail.com>
 <vpqr4qg2044.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9T9p-0002gC-7Q
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 05:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2IFDx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 23:53:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab2IFDxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 23:53:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3351942D;
	Wed,  5 Sep 2012 23:53:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MnOnu4+qTdmEDAMNjq3bcOPYEy8=; b=KBeWC/
	JPQt24SAi/U62M47B1yEKfXb937ZT23f2l+OPAmuYUoKICvXtLBGtivTveDIRDId
	o26nsqo10ClxleZvqwMXKIDS/Kdby6IolOUDUOXUOPzxo5zLg+QQ/UIblw6Nf1mr
	jj+DyP4qtJy2oBpNXxJb0/Y+ADq/PEvd5O3Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FBlm56wU8bvgkEgRqQxb2hVvZm4XF+jz
	Sop3C6g/T08+/y33WDj9HlOLpgcIIXg5Qs9Vqjq+5Q68iFxgFf6HoDQj7W2CbgL6
	YnxI7ARO1qhNFuDn544cU1BU0tejTAhz/NMxP75pZ4PzaLoJABc9ooNNwZgYe5Vu
	WOyUo0+KhrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFA0D942C;
	Wed,  5 Sep 2012 23:53:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D08D942B; Wed,  5 Sep 2012
 23:53:24 -0400 (EDT)
In-Reply-To: <vpqr4qg2044.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 05 Sep 2012 13:13:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68542D8C-F7D6-11E1-BF5E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204860>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Looking at the remote command list, "rm" is the only abbreviation. I
>> guess we should add "delete" (or "remove") as an alias for "rm".
>
> I'd vote for "remove", to make it clear that "rm" is the abbreviation.

Sounds sensible.  Please make it so.
