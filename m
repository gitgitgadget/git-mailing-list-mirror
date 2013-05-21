From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 11:09:23 -0700
Message-ID: <7vbo84nr1o.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<1369132915-25657-2-git-send-email-artagnon@gmail.com>
	<7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
	<7vfvxgnrdo.fsf@alter.siamese.dyndns.org>
	<CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 20:09:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uer0D-0008Es-6o
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab3EUSJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:09:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642Ab3EUSJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2391E0D7;
	Tue, 21 May 2013 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Ok2A3X5QGxS+gzQXGunxLNHnzs=; b=txGvco
	b8ooQgGdSjVj3KPoMl2mfvRZl+tkZOI2OW4z37FtfuL5SYkFUI6HJ257EUxdDr4b
	s23Z93p+CPtM2GjNmmTRhZ3I0AalGVKZhDNPcZuxhPwAB8ey8k5zM05WEspa9eKx
	NCUshoGmUhMcnrocdbaHdyNuWNFV6k1DIh46s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOyLm192vo0addXWlscSamS80+1IeOZH
	2FDliBjNhm4ABO0ZhGj9ffqXK4BEljqH2lQiQ4Blc9iAM7hVuY2pFGBa74QAxjD/
	Uhss4jdap8E7tc1dms3pZw+c33hF6BnL2mq0VuSwzVFIC75ReaSKWE9DAbtqZW1i
	vBPb4DYjJ7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0B991E0D6;
	Tue, 21 May 2013 18:09:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07FC41E0D0;
	Tue, 21 May 2013 18:09:24 +0000 (UTC)
In-Reply-To: <CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 21 May 2013 23:34:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91DD86FE-C241-11E2-8412-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225057>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> So did you or did you not audit the codepath?
>
> No; I was explaining why I didn't in the first place.  Going through it now.

I did not mean "You must do so or we should discard the patch".  I
just wanted to make sure the log messages say how firmly the change
is backed.
