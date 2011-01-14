From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 10:28:58 -0800
Message-ID: <7vhbdbnxud.fsf@alter.siamese.dyndns.org>
References: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 19:29:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdoOp-0003rq-Po
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 19:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524Ab1ANS3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 13:29:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab1ANS3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 13:29:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3D6F33E7;
	Fri, 14 Jan 2011 13:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=djzyQHrbW4TiiSKX/6oq+wRSMIQ=; b=vd6Nuq
	esx0o4I7Cl+t1rqSusWGZ5RJRu6mk/z/pnX7LhetAxwwJja79lA7/+whBavVDO6m
	iQYQACviSkvcbmCxYW5xTatQ8sQ+UL4vyCofXqnqEC/UNvj3mQtYWXdswUX1KwV7
	aWhdkUYXU0sqZ7J8spluuRwbSs1ow+Sj4e+3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XR0+TAoDEjVlkr4lYBcSTDUlI/nEHaae
	et4vGY8nGxvLdE8KIl+Ah2ncpZkBEluiV/+FlFfHOQML8YbTMCSK1M0RHOkXoIol
	Sb4WEd6DW1x9v+/fCmz5PG6AFV4Ll7PXBS4kPjyoicYz8eZhSqtH1F/Dzs64wJEQ
	uhYZs8ZgDyo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 644F033E5;
	Fri, 14 Jan 2011 13:29:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F3CB833E3; Fri, 14 Jan 2011
 13:29:42 -0500 (EST)
In-Reply-To: <20110114162144.GA867@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 14 Jan 2011 11\:21\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4661D682-200C-11E0-A798-C83E909A2CA0-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165117>

Jeff King <peff@peff.net> writes:

> So we should probably do one or both of:
>
>   1. Make an --allow-any-name option to mailinfo, and use it when we
>      invoke mailinfo internally for rebasing. That still doesn't solve
>      the emailed patch problem, but at least keeps purely internal
>      operations sane.
>
>   2. Bump the check up to git-commit time, which is the best place to
>      catch and tell somebody that their name is too short, because they
>      can actually fix it.
>
> Even if we dropped the check now, option (2) is still useful, because
> you have no idea which version of git the other end will use to apply
> your patch.

I am perfectly Ok with making the check looser in "am" when $rebasing is
in effect.  Wouldn't that solve the issue?
