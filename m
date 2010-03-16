From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 23:03:31 -0700
Message-ID: <7vljdsu7kc.fsf@alter.siamese.dyndns.org>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
 <20100315213221.GA12941@vidovic> <7vhbohi80n.fsf@alter.siamese.dyndns.org>
 <buovdcw6fjj.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 16 07:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPsd-0005BW-80
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 07:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935533Ab0CPGDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 02:03:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935167Ab0CPGDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 02:03:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 370BDA29DB;
	Tue, 16 Mar 2010 02:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6dPqibrWpdCj6lQzk0PzKUyBS+k=; b=o/joQf
	5+wPJ18v+cTcoo3/IjAPt/2i3C0U9jj5oO7+rhsAYin3Z9RyDqdg906k4S5wyz3q
	4C1rVUOD4kpq9VwnP1h4V4RMKMVB6hRXl5ZI/4fxznTOjl/3MIlk4G8d9Hl+YRnI
	pSTQskXv1Z568CLwN/RuPXaTSOXpnjgFf1+xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mIzeM6rRj5fqUqeG2VCc0j/UPxipUFjy
	/19JU4+vUmBK4dy39m1ckFHszqhflTiw3VqvCK2kUTwFUVXxnMMGW9Cs4BhRFAPx
	oc2havDMp5yUCRm5eQy0ExaPGSv1GzdYVxccZcnqJXunp8t6Hbah/nFegOewK5v8
	z9CIbfaspdY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1D4A29D9;
	Tue, 16 Mar 2010 02:03:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2699AA29D8; Tue, 16 Mar
 2010 02:03:33 -0400 (EDT)
In-Reply-To: <buovdcw6fjj.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Tue\, 16 Mar 2010 13\:45\:04 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9C2D00E-30C1-11DF-A440-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142319>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> My understanding is that it is more like:
>>
>>     [branch "frotz"]
>>     	comment = "This is to add frotz command to the system"
>>
>> I do not have a fundamental objection to such a feature, but the
>> presentation needs to be well thought out.
>
> This would seem especially useful for publicly visible branches...

If you mean by "publicly visible" branches in public repositories, I
suspect not.  At places like repo.or.cz, github, or installations managed
by gitosis, you typically do not have direct access to $GIT_DIR/config
files (they belong to site administrators) in your repositories, and that
is not likely to change for security reasons.
