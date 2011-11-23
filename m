From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Wed, 23 Nov 2011 09:02:08 -0800
Message-ID: <7v4nxudb73.fsf@alter.siamese.dyndns.org>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local>
 <7vd3ckdjx9.fsf@alter.siamese.dyndns.org>
 <CAHVLzc=SPD+AHhAPP_=mEVv5cJvn0oiJ_k-KBEkG=Qhcw2UxHA@mail.gmail.com>
 <CAH6sp9OXzHj=r707zyRQxaJmndHm5_DcWWMLn_1zyLdEZ_TSbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGDB-0006SN-LH
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab1KWRCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 12:02:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab1KWRCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 12:02:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68EF86A0F;
	Wed, 23 Nov 2011 12:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K4tGtSgOVndvYYzXtwwJUKWDWK8=; b=m4mwKs
	m1Zut0OD71Yz9OQK5IR0sxK8EUc3xM81hOkMotWp+fbNLWGG5Mn0RP9SO2wlh7JN
	r+JrS28NSMxx/03o4ywK/CW3IHhXQQCXPFTKpofCo8QmDqLCaFhqz09J61S7xEVT
	4xFvBcSi7aOYrZ1ttwe/oOJaP/tGCOoZgoVHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DenLfLlggJDNvQS2PxGtedne6XOT6xaf
	rbkyt3zQx1G00V+DaAhfiZN45MNcpwMdLDlA/IIT1ML3Fu91rsocjqgYYYDw1DLV
	LlRYQxDH4EnrfnofyZk0T/uaOqCVjV9FHzDttbzav6j7aVZUUSQucSkJT6A92lts
	FKBhzAPnM/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53DBE6A0E;
	Wed, 23 Nov 2011 12:02:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA5346A09; Wed, 23 Nov 2011
 12:02:09 -0500 (EST)
In-Reply-To: <CAH6sp9OXzHj=r707zyRQxaJmndHm5_DcWWMLn_1zyLdEZ_TSbA@mail.gmail.com> (Frans
 Klaver's message of "Wed, 23 Nov 2011 16:47:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E19B048C-15F4-11E1-8849-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185854>

Frans Klaver <fransklaver@gmail.com> writes:

>> But that's the only repo mentioned in the git-scm home page.
>
> The note from the maintainer[1] mentions
>
> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git
> 	https://github.com/git/git
> 	https://code.google.com/p/git-core/
>
> I would assume one of those would be a nomination for 'official' repo.
>
> Maybe something for Scott C. to address?

As long as the link says "Git source repository" without "the official",
Scott is doing the right thing. It is just one of the copies that I push
into, so it may be considered more official than a fork of my history by a
random unknown person.

As Git is distributed, we do not need a single "official" repository. If
you really want to name one, my private working repository at my home
machine would be what is closest to one, as patches and pull requests are
processed there and then the result is pushed out to the above four and a
few others. But that "official" one is not exposed to the outside world ;-)
