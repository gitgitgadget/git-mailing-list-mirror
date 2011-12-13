From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 13:09:42 -0800
Message-ID: <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 22:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaZbj-0007Yq-1v
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 22:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab1LMVJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 16:09:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab1LMVJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 16:09:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A86E079B4;
	Tue, 13 Dec 2011 16:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYcXFrSjcaN4ksAYxgrRYo9welA=; b=GvamM0
	0ijgxWCkiBbgZjTLBjI3GN8uO6DfnoV5nNT15Hra+InarfTKDrnCLTWB4F4RjP1I
	AFv4wWOzi0d9ciOWvbSMm0hmm1kkLP+3xASBPLPbbQaYlFp8qFWN1RLRkcrXi97k
	AsM9/aikKG8EV9V+/Pnl1wO/OI4ZzkP/X25T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0jl8enyWCtiQ0w6nLXmL4pAENox5sx4
	PDns+88KDTp6m+Rm7aHSxkDdVk/HtfrLbNepi+fkGfZ3ZD5OVkUi2RMS03VvHpil
	zjtr9mU6/Bxksy5GIgBJChEZrSIQwhZDEyyG7Qv6tY4gar+Tb+Mhfrx4JrBRg55h
	1B5IvEBpf8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DD8279B3;
	Tue, 13 Dec 2011 16:09:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36F6A79B2; Tue, 13 Dec 2011
 16:09:44 -0500 (EST)
In-Reply-To: <20111213202508.GA12187@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Dec 2011 15:25:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7BD1520-25CE-11E1-BDEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187060>

Jeff King <peff@peff.net> writes:

> Doing (3) is obviously the easiest thing. And given the complexity of
> the other two solutions, I think it makes sense to revert 986bbc08
> (i.e., apply this patch), ship a working v1.7.8.1, and then look at
> doing one of the other two solutions for v1.7.9.

Or just let the "dumb HTTP" die.

I thought push over DAV has long been dead; is anybody using it for real?
