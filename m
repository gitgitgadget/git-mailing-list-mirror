From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Mon, 15 Jul 2013 12:33:50 -0700
Message-ID: <7vtxjvaa8x.fsf@alter.siamese.dyndns.org>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
	<51E436B5.6000303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 15 21:33:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyoWz-0003m2-FN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 21:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab3GOTdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 15:33:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab3GOTdx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 15:33:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9971D3161A;
	Mon, 15 Jul 2013 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4OD+CpW4lv7xCkMhJYmcoM6DVRI=; b=onqylR
	gaLZjeevgLgYiKs14rHE3eXWff1qlwXKATQRaYiCSoJPcvsylIgM/oLz16p8zij7
	QxMIYAyZ2WmNKYOFHs7EuI8dPgGFMOLYsHgvwWgocUjGgM1bsOL1DYX+pHXPjrVx
	858njIoRXmSWBROI1meb6rE6D6qW2UBQptoIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ANEumHv8TK9Os+Wne1gC0xNG+LaDwsY/
	367zFbkmnMBeEMopmd51iUJezP1phXP0bMn4vYTnwRn4o1g1J7avLqwLzRUM/Qyw
	SzBrre0RaLoWH/UYSUAErJqmgVFRGPw1sdbWgMw4VoIMniK9y7pGBAT4pBCR4QaP
	yk7Z2zvk73w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DBCD31619;
	Mon, 15 Jul 2013 19:33:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E770131614;
	Mon, 15 Jul 2013 19:33:51 +0000 (UTC)
In-Reply-To: <51E436B5.6000303@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 15 Jul 2013 18:51:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB3881A-ED85-11E2-AFE9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230518>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> [Stalled]
>> 
>> * rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
>>  - ### DONTMERGE: needs better explanation on what config they need
>>  - pack-refs.c: Add missing call to git_config()
>>  - show-ref.c: Add missing call to git_config()
>> 
>>  The changes themselves are probably good, but it is unclear what
>>  basic setting needs to be read for which exact operation.
>> 
>>  Waiting for clarification.
>>  $gmane/228294
>
> Sorry, still on my TODO list. (Having said that, I'm no longer sure
> that these patches do the right thing! ;-)

Then let's discard them without prejudice.
