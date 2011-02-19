From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Git rename detection improvements
Date: Fri, 18 Feb 2011 22:57:56 -0800
Message-ID: <7vlj1cmryj.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=+5w6=-RCge3n=bv-5CLBbdY3bNVGcepyz7HrR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 07:58:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqgls-0003Jz-8g
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 07:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab1BSG6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 01:58:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1BSG6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 01:58:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D602322DE;
	Sat, 19 Feb 2011 01:59:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QZ+05i9q4NGJqlUz1OVRKEm0tGI=; b=DE/R6t
	GB8t3SuOpbylPMtEdnOtNwAenOKpAwr/eMxpiiu7KOl01xy6C3lDfYx0whMR3TCn
	7hbOxB/I20VDXv0zhzp0k23X+iKpdmxchiIsx0w4Rk2WebukJcjbXhSW0WsZPHNJ
	NykDgqr3cp+NLJ7MDyIH0b6L4EaL7+bIEmeX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gfuj8TiYN+IYseUl40DDw1qnGv+UOkBK
	O1x2XXV2T99VoKjfBA7KC9/QDF1OtatZq9Mfw8S6TnKe/Zh4yPds6KEQovgMfwYW
	FVkK9p58fd+WkTOwo2YNG1cQvOUhl/widLQa0o2oh1JlTQUR/g5A9K0jjZ31KRxS
	6QuYzUaPja0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B441622DD;
	Sat, 19 Feb 2011 01:59:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA31422DC; Sat, 19 Feb 2011
 01:59:07 -0500 (EST)
In-Reply-To: <AANLkTi=+5w6=-RCge3n=bv-5CLBbdY3bNVGcepyz7HrR@mail.gmail.com>
 (Linus Torvalds's message of "Fri\, 18 Feb 2011 20\:22\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0B1686C-3BF5-11E0-8BD6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167251>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, so this is a cleaned-up series of three commits that I think are
> worthy of being considered for inclusion.

Thanks; they all look very sane.  There indeed is a small conflict with a
topic in 'pu', but the resolution is straightforward.

> Linus Torvalds (3):
>   for_each_hash: allow passing a 'void *data' pointer to callback
>   diffcore-rename: propler honor the difference between -M and -C
>   diffcore-rename: improve estimate_similarity() heuristics

I would suggest s/propler/properly/, though...
