From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email.perl: implement suggestions made by
 perlcritic
Date: Sun, 31 Mar 2013 18:39:39 -0700
Message-ID: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
References: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org>
 <1364474835-23416-1-git-send-email-artagnon@gmail.com>
 <7vsj3fs22i.fsf@alter.siamese.dyndns.org>
 <CALkWK0nGZUV9umbe9UoV79QU+ojCc-=j+RFpCNn_vjM_QTPyPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 03:40:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMTjJ-0000Mm-5S
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 03:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab3DABjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 21:39:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721Ab3DABjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 21:39:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93393ECD4;
	Mon,  1 Apr 2013 01:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PuIIYi2ZfyDQ0TM9o0aVrRtQT84=; b=jr1HN1
	EQZovVfiBXsMjg8E7l0siv4Wy/UzhRXIluNDFp5OYvvSvib0DGir4D9VWJ7mH5Fq
	dp/F5jgpovbNUCC1Rtxu0GBjW2cf7aITiSF4WXDqNBPcOur8rlc+nfwNZHLzsOM3
	Fw2RSdBhW/J1E++NQ7DSDf6H12cct0DhRPhyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWjRWfhc7BjU2123pLPQpH67GQibYyKl
	EX3w8Zam0xE0M1I1VTjYGwqAbs/XBeyBBIJOLdKxEp/U3qWtwAP3SO04WhzTcnSz
	tQYwx//rOoP+UPq07dt/5OajswFxMusMb9Xwril4hbYkHbA62JYh+TeRhrUitnFn
	ZnJ3THBWLyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86E37ECD1;
	Mon,  1 Apr 2013 01:39:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3DDEECCE; Mon,  1 Apr 2013
 01:39:40 +0000 (UTC)
In-Reply-To: <CALkWK0nGZUV9umbe9UoV79QU+ojCc-=j+RFpCNn_vjM_QTPyPQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 1 Apr 2013 02:29:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0587E9F2-9A6D-11E2-A99A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219651>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>     sub foo ($) { my ($arg) = @_; print "$arg\n"; }
>>     sub bar     { my ($arg) = @_; print "$arg\n"; }
>>     my @baz = (100, 101, 102);
>>     foo @baz; # says 3
>>     bar @baz; # says 100
>
> Ouch.  Please drop this patch; I'll resubmit when I feel confident
> about my change.

No, let's not do that.  I will forget and end up spending time to
read the same patch again.
