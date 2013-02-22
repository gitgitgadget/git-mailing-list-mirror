From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Fri, 22 Feb 2013 08:58:53 -0800
Message-ID: <7vip5ks2sy.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org>
 <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
 <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
 <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com>
 <7vtxpf341w.fsf@alter.siamese.dyndns.org>
 <CAH5451mMG-U8qETAy_6pRJLbtOjtAPhbapVA9RLbrrS2yy7rCw@mail.gmail.com>
 <7vd2w23k7k.fsf@alter.siamese.dyndns.org>
 <7vvc9uwkmm.fsf@alter.siamese.dyndns.org> <87hal4n3z1.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 17:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8vxw-00047I-Km
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 17:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab3BVQ64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 11:58:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757926Ab3BVQ6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 11:58:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41ABFA5B0;
	Fri, 22 Feb 2013 11:58:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IFY273SFbg5RAIi1l3QyGLOVNiI=; b=fJxnbm
	WvhInEsBvoz+mdXsKdLMFPwRPTzBx9q8zeJj4ZMLC3v62Wxr90xZ0zlIFDhkPsKW
	z6kNwoOjbiVZkNDL7d00S2KAgrj3Nqd3MDsZCATOl/QIm/tRgZsiWccULYa/Nxd5
	yo/iz2MS4YhtJ0W4j1WLlmqMN4TbvjhqTzF0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n0Qqbqz1taDIAtpNhuW2XlkWJAEHYIr0
	FterJ28za7jWrtdY5/IUQb2OnOM0MEJJ30TOFyzeln0WeDUh3zQEiHpT4eeEY3PI
	serMYzPLD7IccVTvPtE9nJH4U09f81VP6K7uS7y8C9OjwGR4McKwxzCD1AtMx+FK
	oc/YTCWAPH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B65A5AF;
	Fri, 22 Feb 2013 11:58:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC0D7A5AE; Fri, 22 Feb 2013
 11:58:54 -0500 (EST)
In-Reply-To: <87hal4n3z1.fsf@catnip.gol.com> (Miles Bader's message of "Fri,
 22 Feb 2013 17:32:34 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 240A970E-7D11-11E2-B962-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216839>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>  * Introduce "git add --ignore-removal" option in the release after
>>    the current cycle (a new feature is too late for this cycle):
>
> Too late in the cycle even if the option is simply ignored ... ?
>
> [To extend the range of git versions where it's not an error]

I'd feel safer to have enough time to cook the "alleged no-op"
before merging it to 'master' and include it in a release.

Possible implementation mistakes aside, "--ignore-removal" is
probably too long to type, we haven't even discussed if it deserves
a short-and-sweet single letter option, the obvious "-i" is not
available, etc. etc.  I do not think we have a concensus that the
transition plan outlined is a good way to go in the first place.

So, I do think it is a bit too late for this cycle, especially when
we still have doubts about the design. Actually it is *I* who have
doubts; I do not even know if other people share the doubts or they
support the direction wholeheartedly.
