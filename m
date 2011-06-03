From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 2/4] Add infrastructure for ref namespaces
Date: Fri, 03 Jun 2011 16:22:05 -0700
Message-ID: <7vd3iua4bm.fsf@alter.siamese.dyndns.org>
References: <1307136593-16306-1-git-send-email-jamey@minilop.net>
 <1307136593-16306-3-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSdhF-0005rD-KG
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1FCXWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:22:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab1FCXWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:22:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12DCA5B92;
	Fri,  3 Jun 2011 19:24:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mf3n4A6i5RiEDxfxaYKHwAgmcJI=; b=RC5z/t
	GYkaUku/l6sUfmYkYOAF+/0WymtDkwS7FuMV4A2JkUpNoa5az20J58Zlfw6+X4ky
	yKjVYtHSuAre8CygJFqgap56ciIfGnqcFSUJkAEjQDLNGX65/j5jDqL/7vi0l+jw
	9buIVFd8OE5/VpuYFOB17ESi93yOd1cURosCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gx8Rybdg39uabQsj6E5gwdoo5Gre+Sz5
	FuWjozC4qrC6Kg1XtKz2l95RR7Bja9yL5YkLnz9zyTEBXmwOK74d1wepcbjXsNb3
	LqwAYWD2PwhsSsob0U8kC8/Zfm6UaWrP19ys11U1+DB65BBYfVR4ttJxzGKnWCj+
	npYrVT1Ei/g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 967925B8D;
	Fri,  3 Jun 2011 19:24:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A7E75B8C; Fri,  3 Jun 2011
 19:24:16 -0400 (EDT)
In-Reply-To: <1307136593-16306-3-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Fri, 3 Jun 2011 14:29:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9ED7B094-8E38-11E0-BD60-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175038>

Jamey Sharp <jamey@minilop.net> writes:

> Note that namespaces which include a / will expand to a hierarchy of
> namespaces; for example, GIT_NAMESPACE=foo/bar will store refs under
> refs/namespaces/foo/refs/namespaces/bar/.  This makes GIT_NAMESPACE
> behave hierarchically, and avoids ambiguity with namespaces such as
> foo/refs/heads.

I would have expected that this explanation would be improved after you
having to answer my question on the list.  Otherwise it was a wasted
effort, for both me (asking) and you (answering).

>
> This adds the infrastructure for ref namespaces: handling the
> GIT_NAMESPACE environment variable and --namespace option, and iterating
> over refs in a namespace.  Subsequent commits use this infrastructure to
> implement the user-visible support for ref namespaces.
>
> Commit by Josh Triplett and Jamey Sharp.

Also please drop that "Commit by ...".  We can read Sign-off.
