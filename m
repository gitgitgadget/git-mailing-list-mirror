From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 12:59:38 -0800
Message-ID: <7viqaw1ohx.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <20100120203636.GA9221@gnu.kitenet.net>
 <20100120205452.GA8843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhfK-0005nj-M5
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab0ATU76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191Ab0ATU7u
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:59:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab0ATU7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:59:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 772BF92E9F;
	Wed, 20 Jan 2010 15:59:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oRroJx0N4hyXIRztwRRXIBFWpos=; b=ntFPQP
	nNUxhL6M1eTS1nfd1LGADI9R3OFmsasVYl2N0DLS++GCW1/2EWbj0yKfdd2QwkaT
	ZtfKixgOtzxUSjh5W27SrvLD032c8Re0P4pm1cZUf0giQt63Uv+JxHugCWgRt+he
	qLyeDC32sSO4M/vxYCY2fwSHSuoi1UL4CeRGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEUleKl6+OCeiMulnG0A3Z3Gcufx+9Gh
	VuFDPxPGUGaaJr4B8JdZgLFV3/+MyXigSnGQDy2aRoxhz8dP7aXwQNshxeFliowr
	nNszM974X5NS1EEMFpuCLPw4mZol3iCXAe6wuNPwMeWxt+roWxA8Y+JmUG+/F8l1
	FULz5AaKrHw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4537D92E9E;
	Wed, 20 Jan 2010 15:59:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 875E092E98; Wed, 20 Jan
 2010 15:59:40 -0500 (EST)
In-Reply-To: <20100120205452.GA8843@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 20 Jan 2010 15\:54\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC43200C-0606-11DF-BBDA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137579>

Jeff King <peff@peff.net> writes:

> Is splitting on blank lines an error? I don't think so. The original
> format was never strictly defined, but given the --pretty=raw format, it
> seems like a fairly obvious thing to do.
>
> I am inclined to cut the notes output from --pretty=raw, and let callers
> ask for them explicitly with --show-notes or something similar. We can
> leave them on by default in the "normal" output. This will still break
> scripts doing "git log | ./script", but I don't think we have ever
> condoned that practice.

Sounds like a plan.
