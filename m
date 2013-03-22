From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Support triangular workflows
Date: Fri, 22 Mar 2013 08:16:08 -0700
Message-ID: <7v7gkz8nyf.fsf@alter.siamese.dyndns.org>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <26A2BE0824FE4C999592D392FCBEF988@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 16:16:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3hx-0004aE-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 16:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470Ab3CVPQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 11:16:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933456Ab3CVPQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 11:16:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80083BFAE;
	Fri, 22 Mar 2013 11:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KxctYRNebRqDw550ol2zZQarGYI=; b=Ndvs5c
	p3Vn+s9iJAR49SUnA9Wz+/v+m/A/YGqIcxfwlW9zFFlrEO5ciJEwfXYB6Q7Fd1YL
	O2BoXU7rf/cD5PRRKmDeyFWAI81F8Lp6NwuINY9VAQD1cys9vsl7B+jFRmDTrxxQ
	lT7aFaLuOiBBbYXQyrC2ntcOQPVtu4yK6aPYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEMA66OtlfTgvYdUbM95s2klW3x2APcp
	jNBKLYgSwvJgBNtQUanP3Vao9+Mp9VgS1drD7KTt2o/CMRMGdA2sa+7RxCMPvL8M
	IkJhH3kbxfJaBsRFJgJnEzQxwr41VYUaBaEo8PBeZj+QQWrxYIbBhnncoANOozS3
	8G0S3RA9RkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72AD2BFAD;
	Fri, 22 Mar 2013 11:16:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3F16BFAA; Fri, 22 Mar 2013
 11:16:11 -0400 (EDT)
In-Reply-To: <26A2BE0824FE4C999592D392FCBEF988@PhilipOakley> (Philip Oakley's
 message of "Wed, 20 Mar 2013 23:04:01 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E544780-9303-11E2-AF0F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218813>

"Philip Oakley" <philipoakley@iee.org> writes:

> Shouldn't Documentation/gitworkflows.txt also be updated with the
> triangular workflow and its configuration?

What is missing from gitworkflows documentation is actually a
non-triangular workflow, where people pull from and push into the
same central repository.

The "merge workflow" part in the "distributed workflows" section
teaches:

 * fetching others' work from <remote> and merging it to yours;
 * publishing your work to <remote>; and
 * advertising your work.

and it is written for the triangular workflow.

Two triangles are involved.  The maintainer may pull from you but
pushes to her own, which is one triangle, and you pull from the
maintainer and push to your own, which is another.

As to your suggestion, I do think it is reasonable to clarify these
triangles with an illustration, and to even add descriptions for
short-cut configurations as a side note.
