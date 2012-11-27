From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4041 (diff-submodule-option): change tense of test
 names
Date: Tue, 27 Nov 2012 09:51:57 -0800
Message-ID: <7vpq2zlyrm.fsf@alter.siamese.dyndns.org>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
 <1354005692-2809-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPKS-0000qU-0p
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab2K0RwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:52:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868Ab2K0RwA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:52:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C6A7A823;
	Tue, 27 Nov 2012 12:51:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7bxSlifFOBm5Vwh3rj2AJIpj4JE=; b=mGgkXC
	5SuwD0mTBp78ssS9Q+BKdEsshyxEe3jV3l6uN8HHG9PgUQQC0lE7aaODvmgeLInJ
	4PCvJnTVtEfyakLM6NFL/jCKsLC5kAtXGVRk+8/ieP0Z+2MGnDL+KVJPsJI2b5Wk
	fgBD649E5OVQn3xAvyhmmqis7U94JSB2MZ348=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7hjnULV1d0ZUychLxlS5kMrl0BAgh9x
	iGhmiDxCrFAgoVFby4FPyG2Um2c6fCWBripzQNqafzCzrUqT/AwM0qsga8j1DDdd
	M6kpSxr9vL6mkkTZ2XdbDYIn+aenbck731eBrDGGDdMIJo/hWDfE+6pWnV44SFAf
	sQ9aJkxxKu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79ED6A822;
	Tue, 27 Nov 2012 12:51:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D450AA821; Tue, 27 Nov 2012
 12:51:58 -0500 (EST)
In-Reply-To: <1354005692-2809-5-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 27 Nov 2012 14:11:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 240346BA-38BB-11E2-86EF-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210579>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Change the tense of test names from past to present, as this is the
> prevalent style.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

I see most of them are not "past" but "past particle" used as if
they are adjectives.

For example, I think this test

> -test_expect_success 'added submodule' '

tries to say "See what happens to an added submodule".

The same for the others.

> -test_expect_success 'modified submodule(forward)' '

"See what is shown for modified submodule."

> -test_expect_success 'typechanged submodule(submodule->blob), --cached' '

"See what is shown for typechanged one, when --cached option is
given".

So I do not think this patch is needed; the current wording looks
not so grammatically kosher, but still is understandable.  Updated
result isn't.
