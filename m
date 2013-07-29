From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 10:38:19 -0700
Message-ID: <7vob9l1d2s.fsf@alter.siamese.dyndns.org>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
	<51F6826D.2010606@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
	git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rOt-00063N-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab3G2RiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:38:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab3G2RiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:38:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEA8634F1C;
	Mon, 29 Jul 2013 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L0GZTqOFKFSHbdpqquoBo5MFhnk=; b=X6IXq+
	5WLHkvv6myKviJFu6xCPFrGQud4IuspWJgViltPAPPiKeYYoR69FYCPGiXUHUW0i
	wmGiFZ5t08GZQ4uAwu1wyQoZFOopSTJq6gCNJD/XMbNNCH25J6el1JFrlzw2oyqV
	9+jQ2g+O0DqHSbDKF6IljGOTOHIGtvfdHpD1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NgUSpHGg0pbT/RnR+iBYNcFRZcv3X6JB
	siYbS8tcEF4rCtd5EtPFNRwlmKJYouygkTdsTwbRRoEytZyqt8KsOn32leFpuGl3
	CcuggwrPMKtUy86j8879HgXrjsNQNXCI9K7uraKzU8wuaGKWBrg6KYttnnbEusc1
	ZW0oD9TAhN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D267234F1B;
	Mon, 29 Jul 2013 17:38:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E68034F18;
	Mon, 29 Jul 2013 17:38:21 +0000 (UTC)
In-Reply-To: <51F6826D.2010606@xiplink.com> (Marc Branchaud's message of "Mon,
	29 Jul 2013 10:55:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9649046-F875-11E2-B389-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231305>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Unfortunately no automated system is perfect (see some of my comments below).
>  I'm all for an automated system that identifies potential misspellings, but
> I'm wary of anything that attempts to automatically correct perceived errors,
> or that can't be overruled.  In the end a human must make the final decision.

I'd actually prefer to see no patch that says "this was done with an
automatic tool".  You can use automation on your end all you want,
but the final result needs to be eyeballed before sending it out,
and at that point both the credit and the blame lies on you, not any
automated tool.

>>  core.sharedRepository::
>> -	When 'group' (or 'true'), the repository is made shareable between
>> +	When 'group' (or 'true'), the repository is made sharable between
>>  	several users in a group (making sure all the files and objects are
>>  	group-writable). When 'all' (or 'world' or 'everybody'), the
>>  	repository will be readable by all users, additionally to being
>> -	group-shareable. When 'umask' (or 'false'), Git will use permissions
>> +	group-sharable. When 'umask' (or 'false'), Git will use permissions
>
> "Sharable" is the North American spelling.  AFAIK git doesn't specify what
> kind of English the documentation source files should use.  Perhaps one day
> there'll be en_UK and en_US translations, and all the sources will be written
> in Klingon...

;-)

It often is a good idea to ask your search engine "What is X", and I
seem to get a positive result for "what is shareable" just fine.
