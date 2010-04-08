From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH v9] Documentation/remote-helpers: Add invocation 
 section
Date: Thu, 08 Apr 2010 13:45:56 -0700
Message-ID: <7v634165bv.fsf@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 <20100407224942.GA20239@progeny.tock>
 <7vzl1eamss.fsf@alter.siamese.dyndns.org>
 <h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com>
 <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
 <r2ifabb9a1e1004081321ia91ad7f7r58f39b9173594af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 22:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzycL-0002GH-1d
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 22:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389Ab0DHUqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 16:46:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229Ab0DHUqS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 16:46:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA543A8F3B;
	Thu,  8 Apr 2010 16:46:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8zgONwRBItEZmDs3yjlhPf4hWU=; b=ayAqDB
	Su+17K46iwUT6ygzasraD0gC/He0556I52giLnPWUqn9oqlOSOv8EasXu4ld91Jf
	DDsQYHJUY714O+QySiJBEBoyEseqoy6vMqBH51iayIs+rK4fArVx1ivT/zx5LDNC
	1eidYPZIJ3pdsc2oskGEfiMRxfUCsEUkFMQG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bMU4E71kS/1aGqTtfXeC1E83XbUIlgE9
	kC6NvxJnwB8o6qyT6Lj7byhFLh4UQPTN/uo+pogK2kAKgHOJfluHc1w4N5uV4rdv
	W2lD9ZBDYPnmOaADGTnb1xLrNckft+PWzEAN/pWD0KGi1gDusva8v4pGZgkIhluV
	pEsV7jw03rw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E558A8F35;
	Thu,  8 Apr 2010 16:46:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1105DA8F32; Thu,  8 Apr
 2010 16:45:57 -0400 (EDT)
In-Reply-To: <r2ifabb9a1e1004081321ia91ad7f7r58f39b9173594af1@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 8 Apr 2010 22\:21\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C2489CD0-434F-11DF-B7D1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144382>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I like it, but...
>
>> -Note that your maintainer does not necessarily read everything
>> -on the git mailing list.
>
>> -Also note that your maintainer does not actively involve himself in
>> -maintaining what are in contrib/ hierarchy.
>
> ... I'm curious as to why you removed these two statements.

The rewritten paragraph already covers these two points, no?  Proposals
can be cc:ed to me only if what I did in the past is relevant to the
proposal, meaning "treat the maintainer just like any other contributors
and reviewers", and it applies to all the codebase, not just the contrib/
area.
