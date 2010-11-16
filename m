From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick -x formats the message incorrectly
Date: Tue, 16 Nov 2010 11:20:56 -0800
Message-ID: <7vpqu5gjmv.fsf@alter.siamese.dyndns.org>
References: <loom.20101116T100730-967@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Svensson <martin.k.svensson@netinsight.se>
X-From: git-owner@vger.kernel.org Tue Nov 16 20:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIR5e-0002lY-1T
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab0KPTVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:21:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab0KPTVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:21:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A3F62BE6;
	Tue, 16 Nov 2010 14:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4TohILlWb6HEcGnLrjSyCEIj3/Y=; b=ukPNhE
	ooPksQhYc3NZBvjjA/u2NPBW13w4KssiWcHW0S+7P+hJEi6oMCxBUStERV3lkwNJ
	27C1mVpbB9Ea/tSgN16NVm0DYxWevbGhnng+tNXgXQ5XbxUk1SjVIjXXT3tSZNKG
	2pdReydf777edkXjqUqSbIukwRht4sO7LejC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SjXbW5aNIjKTqtA9TQrtdV1llaYZZsBQ
	Mjldyw5GZfRv4R8lWmKx69auDBBofsFxLA/1yMpo7jOSTSYmAe4/gPICQjfxdv4B
	BXLR+tkuIW2JviMu8hyz5BED+2xY/TT9jCnbWmsskAwWFaMc5KcJxUPuw+oN3Yar
	8SqJ+iREobo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC8972BE5;
	Tue, 16 Nov 2010 14:21:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1069A2BE4; Tue, 16 Nov 2010
 14:21:07 -0500 (EST)
In-Reply-To: <loom.20101116T100730-967@post.gmane.org> (Martin Svensson's
 message of "Tue\, 16 Nov 2010 09\:14\:15 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB892A30-F1B6-11DF-937F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161578>

Martin Svensson <martin.k.svensson@netinsight.se> writes:

> Now that's not good, because it is a two-line summary. In my opinion, the
> parentheses should _always_ end up in the detailed part.
> It should be:
>
>   foo
>   
>   (cherry picked from commit eb42a6475d2c2e4fff7a1b626ce6e27eec21e886)
>
> Am I right?

I tend to agree (modulo s/summary/subject/ would be the wording I would
have used).

This falls into "patches welcome" category, though.  I do not think
anybody sane is still using cherry-pick with -x option these days after
http://thread.gmane.org/gmane.comp.version-control.git/28378
