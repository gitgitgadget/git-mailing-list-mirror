From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Salvaging borked project history
Date: Thu, 26 Feb 2015 15:54:11 -0800
Message-ID: <xmqqlhjkjkkc.fsf@gitster.dls.corp.google.com>
References: <54EB5DD7.7050202@free.fr>
	<xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>
	<54EF098B.4080803@free.fr>
	<xmqqh9u8mrha.fsf@gitster.dls.corp.google.com>
	<54EF814D.1020105@free.fr>
	<xmqqioeol5v4.fsf@gitster.dls.corp.google.com>
	<54EFB0AE.6000600@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Mason <slash.tmp@free.fr>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:54:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR8G3-0003hT-5S
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 00:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbBZXyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 18:54:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752169AbbBZXyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 18:54:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B47C93BC1F;
	Thu, 26 Feb 2015 18:54:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rzOEfn/LRdM2Z4seZr6PS69H768=; b=iLp/QC
	qzsaFegp3ekKTl2PAn6BIyrc23aL9u2u1hWg1Ezl0zC0e2gMtd9/Wf8kLiUo6tDF
	+MEmToORagrNTqg0Wtkr9BJFg16wHPIUysSbOXLDqJv8g6jQUvA9JWHZsmlhBrfj
	+OBb+40NPCu4oZvymSu0KF8xFAGXVOcsH8zuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pb+c9mSjgfvkQGHRdVLVa2I9tnGzaxus
	azAyfD6UJRVFRBR0Qq56dJLolUp8u70kzUrBs6xdeOh3xvsHUnP9mzoNAkUQqmPf
	g0usVgEnpvC3/KyRFy5YHNZX3aFcxn32pYstLrJyQ2RUx/N5ScjtcqtJBzoAl0ms
	gRZkltY1TEI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADDD33BC1D;
	Thu, 26 Feb 2015 18:54:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3916A3BC1C;
	Thu, 26 Feb 2015 18:54:12 -0500 (EST)
In-Reply-To: <54EFB0AE.6000600@free.fr> (Mason's message of "Fri, 27 Feb 2015
	00:47:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C340D970-BE12-11E4-B513-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264483>

Mason <slash.tmp@free.fr> writes:

>> Mason wrote:
>> 
>>> I was planning to write 'git diff -q commit^ commit'
>>> to test for empty commits.
>> 
>> s/-q/--quiet/ and all is well, no?
>
> Doh! I've no idea how I missed these...

Yeah, this is one of the unfortunate corners of Git that I can
apologize but cannot do much more than that about (in other words,
making "git diff -q" as a short-hand for "git diff --quiet" is not
acceptable) due to backward compatibility and consistency concerns.
