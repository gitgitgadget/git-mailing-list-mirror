From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/14] ls-remote doc: fix example invocation on git.git
Date: Sun, 23 Jun 2013 01:04:47 -0700
Message-ID: <7vvc55fe1s.fsf@alter.siamese.dyndns.org>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
	<1371887901-5659-9-git-send-email-artagnon@gmail.com>
	<7vy5a1guk4.fsf@alter.siamese.dyndns.org>
	<CALkWK0=LRe9V7ETdEAZ7bBEDPFcTv=4cdcAE=CdNA_Xx76+LcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 10:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqfIB-0004CY-4U
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 10:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab3FWIEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 04:04:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab3FWIEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 04:04:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9F54267BC;
	Sun, 23 Jun 2013 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yN+9Jid6YEtgQniJrw2CK6NlySs=; b=IoVPxl
	W2q6hRP+o6toI9IjF1tmmSbGUBPVo8+dwzjmsFp9n1kX24KCXIjqPakx1+0+D4Gn
	I1VPOHt8uLOYGIdQyWA6JhNyXoI59iFQ1hsXnp0X95h9Ek2CdDax54ADcP3++p8c
	Kdbpi2VxQxq4vtVo7LoOS5+XhKzUveme9z0yU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SgadXDo9iapUnReQZun2aXZViGxwY8Se
	bYin3M21i419CpQrQAAfdGG92/fpUzXejEAn7gRivWHlst5ES7n+sY/gZQnO4A6N
	cZ1G617asQNPcWElfkQGsFqXo4bwgECKJdCX+WX3USbfLa9gLA+iOGDEnnd4lFfk
	Jcel66GQRcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDA42267BB;
	Sun, 23 Jun 2013 08:04:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 254B8267BA;
	Sun, 23 Jun 2013 08:04:49 +0000 (UTC)
In-Reply-To: <CALkWK0=LRe9V7ETdEAZ7bBEDPFcTv=4cdcAE=CdNA_Xx76+LcQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 23 Jun 2013 13:23:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93636044-DBDB-11E2-8B4E-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228730>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Under the EXAMPLES section, there is one invocation on the git.git
>>> repository that attempts to list the refs master, pu, and rc.  The ref
>>> rc does not exist in today's repository, so remove it.  Among other
>>> things, this example demonstrates that the "<refs>..." argument is
>>> simply a filter; requesting a non-existent ref is not an error.
>>
>> These last two lines are better be in the documentation, no?
>
> You're no happy with the existing documentation?

I am not so happy with the existing EXAMPLE.  Lazy people (myself
included when trying to figure out other people's software) jump
straight to the EXAMPLES section without reading the main body.

Especially for these people, it makes tons of difference if a sample
command is accompanied by an explanation of key points the example
tries to illustrate.  In this particular manual page, there are a
couple of commands and its sample output listed but nothing else.
