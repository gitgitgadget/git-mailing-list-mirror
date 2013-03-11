From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Mon, 11 Mar 2013 12:02:22 -0700
Message-ID: <7vppz592v5.fsf@alter.siamese.dyndns.org>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi>
 <vpq620yfj6g.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 20:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF7zr-0002hp-B9
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab3CKTC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:02:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047Ab3CKTC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:02:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05DD1ABD8;
	Mon, 11 Mar 2013 15:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TlpSjOBDbfmmdbShyHEJ+xYJ33Y=; b=iNG8Le
	ZjipvJvD7uQjDxw8I5awJOMeaxNYk9A0kf21f+6mjiZF2Hf6FoREElB/zE+6XN6t
	D/t9E66jvwzg7dLxEA6WE6H5qORo5GpMcLVLSqA47SDIPjzGwbFr3OvILMJYBgu3
	FFSbkH+G9d4j4VF7iOmLYW+SewdvNkYQuDG2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oezxZvwGUeHEcis90vyt4kKQLDPUkFwj
	tNoU/dDYDcMxK0zudliESRG3xk+TP9C+XTRArMwX3OvQr+l+KFLRyo3VeYEdy9v2
	fBRHMcM8y/55k0Wdp4xXZwNwE9qEZ/pJi6BAQhR0bUIDVsU39bFBCHpm7qYU7wAg
	qEZFhNkq4Cc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE851ABD7;
	Mon, 11 Mar 2013 15:02:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 619CAABD3; Mon, 11 Mar 2013
 15:02:26 -0400 (EDT)
In-Reply-To: <vpq620yfj6g.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 11 Mar 2013 09:13:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36C74002-8A7E-11E2-A2EB-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217899>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Two significant usability flaws here:
>>  - If using man, "man git" to side-step "git help" is obvious. But if
>>    trying to use help.format=web, how to get the root html page? My
>>    technique was "git help XXX" and click the "git(1) suite" link at the
>>    bottom. "git help git" is non-obvious and apparently undocumented
>>    (it's not mentioned by "git", "git help", or "git help help"...).
>
> Can't this be solved by adding something like
>
>   See 'git help git' for general help about Git.
>
> to the output of "git help"? I think the fact that "git help" provides a
> small amount of output (typically: fits on one screen) is a nice feature
> that avoids scaring people too early with the actual doc.

That sounds like a good direction to go in.
