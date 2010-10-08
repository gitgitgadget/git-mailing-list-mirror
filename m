From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Unify argument and option notation in the docs
Date: Fri, 08 Oct 2010 12:43:51 -0700
Message-ID: <7v1v80wjuw.fsf@alter.siamese.dyndns.org>
References: <87fwwhszsf.fsf@gmail.com>
 <1286559080-27257-1-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 21:48:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4IvL-0000f0-Bc
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 21:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab0JHToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 15:44:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0JHToD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 15:44:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A50DD7E4;
	Fri,  8 Oct 2010 15:44:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7XgS6o9gdULE+MLe6zt8nCmegw=; b=utdH9S
	V0e82wLlFJwPGBI7H5NVctL+FcFWQ1aKzDUBxf/8nQsGV/lE271IRKzsZVSSPiHc
	g60Ajxuq7iMX5JVMlKZfykaj7C+OEkS1yb54vd9wXcBqDBu0+EqeoCuh0EfQKZyS
	UUgPNuOZgMCevwywS+uUGrZwiMkChk/gfQb94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDKC9VYtVIgAKoa/cPU7Mb9RQL8OtGPF
	uw3nrzVcWZt07ii/xT4tRboQVnV46th+nkvqh6EUtbo8ArKdjUIF+xDgXmxXt+3e
	3o2YZIXRVNq4CLMqbpOQtft4+kVzfihANTilLFymuLiGxtzGqn2Yx/kcrZqAu9N1
	Ttl8vXYzEIs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4003BDD7E3;
	Fri,  8 Oct 2010 15:43:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 768E7DD7E2; Fri,  8 Oct
 2010 15:43:53 -0400 (EDT)
In-Reply-To: <1286559080-27257-1-git-send-email-stepnem@gmail.com>
 (=?utf-8?B?IsWgdMSbcMOhbiBOxJttZWMiJ3M=?= message of "Fri\,  8 Oct 2010
 19\:31\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63D74E08-D314-11DF-AC56-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158527>

I had to fix up the whitespace damage in the rerolled 2/6 but otherwise
looked good.

Thanks, both.  It might make sense to outline the rules applied somewhere in
CodingGuidelines to help people who add to our documents.  Something along
the lines of...

 - A placeholder is spelled inside angle brackets, e.g. <file>, <object>.

 - Choosing one from many is written with possible choices separated with
   a vertical bar and the whole thing enclosed in parentheses, e.g.
   answer=(yes|no|true|false)

 - Repetition of zero or more times of X is spelled as [(X)...], e.g.
   [(-p <parent>)...]
