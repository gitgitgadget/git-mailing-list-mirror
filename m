From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Accept-language test fails on Mac OS
Date: Fri, 05 Dec 2014 14:51:37 -0800
Message-ID: <xmqqppbxogli.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, EungJun Yi <semtlenori@gmail.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:52:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1jN-0003NO-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbaLEWvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:51:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752881AbaLEWvj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 17:51:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D58D524816;
	Fri,  5 Dec 2014 17:51:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9C+kGeoXDGKW/EC8FoTSbmlmumg=; b=tmMfcN
	a/Bqx7o27NvaEBcL1FMBgVHf4FD83WDyWTY3ZEvXZJIlEszzHlF42eih3xQN08wY
	1Hsu4C9VW0wxEk+ePaUFB/hJTfupdaoTB3zm6AGTXjQP8ZJtaUmzjBITtfEP7Q7a
	nykOkuY8EvqMvWwo40EiITFi4QLWHzR0QfFnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LT+GIHNs+SVKhid3RAVJQRFwqFu6U45a
	sN1Mt/8opmHKO8rIKVAbEIaaUeKuJ+ZdrGAQ0eL3ka4XuUHi0NBZoupMYIJUKkjl
	JKw4D38WOHnXwPaoOYP5G+RtEKw9M1JvcezZWnXAIIsy/IsAAViGXGFDX8uT/Blg
	TIKGVOhCgeY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA4C424814;
	Fri,  5 Dec 2014 17:51:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5156524813;
	Fri,  5 Dec 2014 17:51:38 -0500 (EST)
In-Reply-To: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
	(Michael Blume's message of "Fri, 5 Dec 2014 14:35:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4577744A-7CD1-11E4-AFCB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260907>

Michael Blume <blume.mike@gmail.com> writes:

> Test #25 'git client sends Accept-Language based on LANGUAGE, LC_ALL,
> LC_MESSAGES and LANG' in t5550 fails consistently on my mac, and has
> since the test was introduced. Test 26 and 27 ('git client sends
> Accept-Language with many preferred languages' and 'git client does
> not send Accept-Language') seem fine.
>
> I'm building git with NO_GETTEXT=1, which may be an issue? But in that
> case the test should probably be gated on gettext?

I recall queuing a SQUASH??? on top of the posted patch; does these
tests pass with it reverted?
