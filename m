From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git revert ignore whitespace
Date: Fri, 10 Sep 2010 09:34:50 -0700
Message-ID: <7vr5h1h80l.fsf@alter.siamese.dyndns.org>
References: <14756.91.183.48.98.1284105472.squirrel@stevenleeuw.kwik.to>
 <20100910142114.GB6936@sigill.intra.peff.net>
 <15732.91.183.48.98.1284130451.squirrel@stevenleeuw.kwik.to>
 <20100910152434.GA8891@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven <redalert.commander@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 10 18:35:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6Z9-0004GL-2j
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0IJQe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:34:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0IJQe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:34:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7280D5F3E;
	Fri, 10 Sep 2010 12:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+SMOC/8qdh3cm/LS7hZ6rzzYuIY=; b=VLSmLN
	wAehS84oXrpKkvZG+4XqUj18wWPAnyoHodnj3X1TbaJxV9xUSvcmNeFvMruhbiUN
	ezGf7hWMsGHDrLDSgnmBYgNfTbB7ygLLyJXMOheIpIe2X/GpwlLiBuHqayceOvf8
	ONu9c8TSpYaKEJny8FK9XY4xl289uLrJbX4QY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KATJtH4mWEJnBki4HNEuopYfG1sbLc5G
	hEaTPI27dQJu84sXzH0/axJwZwBC0s92/rmKiilgcfdDnCCWf9MTVEIn07NePK6L
	Ixyg3eaxv+grrhTuMcBpHjb3kc7/uyWGLVGQfPOZTH4EuA1awIeg5fZezg373XOV
	1YZOAIwY//8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D698D5F3D;
	Fri, 10 Sep 2010 12:34:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95002D5F3C; Fri, 10 Sep
 2010 12:34:51 -0400 (EDT)
In-Reply-To: <20100910152434.GA8891@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 10 Sep 2010 11\:24\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 580240BE-BCF9-11DF-8E73-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155945>

Jeff King <peff@peff.net> writes:

> Revert is written in C these days, but you can see the shell script
> version using git-merge-recursive in contrib/examples/git-revert.sh.
> However, I don't think there is an easy way to ask merge-recursive to
> ignore whitespace changes.

See jf/merge-ignore-ws in 'pu' ;-)
