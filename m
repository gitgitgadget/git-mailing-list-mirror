From: Junio C Hamano <gitster@pobox.com>
Subject: Re: {Spam?} push pull not working
Date: Tue, 24 Jan 2012 12:28:03 -0800
Message-ID: <7vliow3kx8.fsf@alter.siamese.dyndns.org>
References: <1327431631.21582.209.camel@thor>
 <20120124194153.GB19534@sigill.intra.peff.net>
 <7vty3k3lmh.fsf@alter.siamese.dyndns.org>
 <20120124201807.GA20145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rick Bragg <lists@gmnet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:28:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpmyT-0002vR-4o
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab2AXU2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 15:28:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756285Ab2AXU2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:28:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C06D27D57;
	Tue, 24 Jan 2012 15:28:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=70pQWz15cRaPv6EnCsFfhZVmczg=; b=c/HnmJ
	bV63NM4umSAxp2zJa/HgOstoxQpj9IkW5CeYOnZWCdpTec1WMxBrJDC6+gTQCB+o
	+snRbMtQTuLQwRN5vWWTWgInEQNr6PuLe/lzv2wesf77ixDf+2+DM1ztUO5oVbM/
	NplGxAbfgEvS1M1dgKY07V6XLODFkzDBtJWVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5wnmJ0xfsqJoIjizr4MCDRC1if0L4lo
	oMPB8yNh8oudaPB5OB29CsB8G7RYysbKuPgEw9ttstPJhHlyCFDda2hGtZhtoYDT
	FK538siO0nSsrM5cf07hUBcg4TIIMcG1Bc+1iPXyso1XLAH+fh7Ce3AH1leBF33z
	RfxbUkmV2CY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A837D56;
	Tue, 24 Jan 2012 15:28:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49EBD7D54; Tue, 24 Jan 2012
 15:28:05 -0500 (EST)
In-Reply-To: <20120124201807.GA20145@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 24 Jan 2012 15:18:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB9D21E4-46C9-11E1-8105-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189068>

Jeff King <peff@peff.net> writes:

> This might have been a better example (it exhibits the problem, but is
> not an example of a terrible thing to be doing):
>
>   1. repo1 has a "master" branch
>
>   2. clone repo1 with "git clone --bare repo1 repo2". Repo2 now has a
>      master branch.
>
>   3. create a new "foo" branch in repo and commit on it
>
>   4. "git push ../repo2" from repo1. This is a sane thing to be doing,
>      but will not push the newly-created "foo" branch, as some users
>      might expect.

Yeah, that is pretty much the standard thing people would do, at least
before GitHub era ;-), to start a project in repo1, and then to publish
for others to fetch at repo2.

Thanks for clarification.

P.S. Did you have chance to take a look at the "grep" thing? I thought
"grep --textconv" would make sense, but I may be missing some large
pitfalls.
