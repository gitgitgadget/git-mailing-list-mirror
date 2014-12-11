From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/5] glossary: introduce glossary lookup command
Date: Thu, 11 Dec 2014 12:06:45 -0800
Message-ID: <xmqqiohidk8a.fsf@gitster.dls.corp.google.com>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
	<585191103e7bdd21ed422324504b6503bec2b914.1418052470.git.git@drmicha.warpmail.net>
	<xmqqa92vf7ao.fsf@gitster.dls.corp.google.com>
	<5489B70E.2040604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzA1A-0000ub-AO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 21:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbaLKUHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 15:07:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933296AbaLKUGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 15:06:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AAB124DC3;
	Thu, 11 Dec 2014 15:06:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=giOSqB/wKGSVdbWALgXdhr33fMo=; b=UNpNqd
	wG5CafPJw0ls6CaAlMEkBwo3tNZlaBulrlNjMr0+rYTEd+OzHOsjwZVx7mFTIzQx
	wDsZlLFvxxvpRdgjL1v8/YWhnzh169CjLfMeN8952uuxuOHN+qMMU3hL28FWohAP
	5NHz5IxBNyCX20Uwq4K+KpMLR5Ft8of+Cv/po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKlOOry7EsofPkIWvL/U/ZUzHsRh654Y
	95NHObgXPStoz2x3OJhlM58DVoqlVw1uRNko8bGOaijQKVqltwJLbBqbgUzE8IWg
	JoSSKxMUbDeixRdkUdXIf32EVbJQtcijndq0lw0utr1fCNmMO13mvR1kvangleMH
	uk8xLT36YF4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 808BB24DC1;
	Thu, 11 Dec 2014 15:06:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EECBA24DC0;
	Thu, 11 Dec 2014 15:06:46 -0500 (EST)
In-Reply-To: <5489B70E.2040604@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 11 Dec 2014 16:23:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C3E16B4-8171-11E4-AC99-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261289>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> I wondered if we want to also have the associated documentation in
>> response to a query, but I am not sure how well that would go
>> without having a translated glossary at least.  I.e. pulling the
>
> Yes, I think we would need something different then. The glossary
> entries are asciidoc which we can't format easily from the glossary
> command. I really think of the glossary command as being orthogonal to
> the definitory glossary. I guess I should name it "translate" instead.
> ...
>
>> original from glossary-content.txt would produce something like
>> this:
>> 
>> 	$ LANG=de git glossary -l blob object
>>         Blob-Objekten
>> 	Untyped <<def_object,object>>, e.g. the contents of a file.
>> 
>> which is not ideal.

I didn't mean the AsciiDoc part, though.  I meant that the contents
are not in LANG=de, which is not ideal.  So translating "blob object"
to whatever it is called in LANG=de, without the description, is the
best we can do without having a translated documentation set.
