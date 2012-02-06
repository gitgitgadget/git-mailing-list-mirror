From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Mon, 06 Feb 2012 14:04:39 -0800
Message-ID: <7vliof62ko.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
 <20120205234750.GA28735@sigill.intra.peff.net>
 <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
 <20120206030339.GA29123@sigill.intra.peff.net>
 <7vy5sgaby1.fsf@alter.siamese.dyndns.org>
 <CAMP44s1RN+_UK9rAk_m9Z=YaJJtwHLyiCu2stMMDEWqZN9260g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 23:04:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWg3-0001R7-38
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab2BFWEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 17:04:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304Ab2BFWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 17:04:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21EA86962;
	Mon,  6 Feb 2012 17:04:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yRV4MlZWvENOpRXds+6Mz35dTI=; b=gMdk1t
	prQBGc6Jvpni+V4q5C5j60O4IrZPxFGtQA/l6idS7AG3LjowhFuDfPVkC0ClvYF/
	F+iODkpXT00cJYEzOJDP5qx2jXm5f8WaIKWjvduNqY2nMe8W2osMNHzu0ckiyZFZ
	m+cSHWxdMYvAJJ8mPebYhR8nPGoWLGZ386nPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o6PGxMWe7Kqu0kWRRuApjcCFU/ODstFT
	fVqvupFbyvyjgilYcWmlRl2QFZAuQEe9ZI1Ka9UsQadXGtyR5dZcpmYI6e1gBTes
	DUIhO4AmjyJwga9nU9nUNahE4QP+coJ9CnGXJGjxWLyPS1kOZiYB8iq0JUFpNQkI
	Fmi017zGAww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183996960;
	Mon,  6 Feb 2012 17:04:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1CF7695F; Mon,  6 Feb 2012
 17:04:40 -0500 (EST)
In-Reply-To: <CAMP44s1RN+_UK9rAk_m9Z=YaJJtwHLyiCu2stMMDEWqZN9260g@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 6 Feb 2012 14:14:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91499D54-510E-11E1-A833-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190112>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This subject doesn't explain the *purpose* of the patch: always return
> a plain mail address from map_user()

That would be a much better subject.

> I think the immediate problem should be here:
>
> Currently 'git blame -e' would add an extra '>' if map_user() returns
> true, which would end up as '<foo@bar.com>>'. This is because
> map_user() sometimes modifies, the mail string, but sometimes not. So
> let's always modify it.

That is just a symptom.  People who reached this commit by digging the
history of mailmap.c would need to see the *cause* of the symptom
described in the light of how the API is designed to be used.  In other
words, "the code after the update has to be this way because these are the
i/o constraints this API has".  "Otherwise you would see this breakage for
example" is merely a supporting material.
