From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Wed, 19 Sep 2012 17:35:47 -0700
Message-ID: <7vy5k5cyzg.fsf@alter.siamese.dyndns.org>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
 <7vboh1eew2.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUkr-0003Jd-IG
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab2ITAfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:35:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634Ab2ITAfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:35:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C979037;
	Wed, 19 Sep 2012 20:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ln7TX5LbDidTwYOwcaMOD1hTkcU=; b=yNvqE5
	f8p1L7jKEN1k/XIbaZGqLVWh1lycZPlNqL4qTl7Q++k6AY5nwHXFAu0m/gOrJYes
	10k2iHXZIMFkkIFAT76oPrL7LBnqaK8RG/hJILycbTiSKR+GwxHfOu4JMsLLm+a+
	0W18BOmtUu/DNLX/L0N3+g2ElEYvn0FBeQKD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BGe8lr4/zvmo486Q8Y1jOlLBW49wdo+V
	R/ffo85N7GPR0ue2TmQBH6+JpEIjgtAiNJCib+z6Y//tFVG+Q/n/BJWHxPTRwEBO
	NruRSU1xRC596dkH55oWnvcgbri8IADPH3u/On00pSPpL4il+LdYhj/XcRMdhTkX
	OJ2V3aj+2h8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF9DE9036;
	Wed, 19 Sep 2012 20:35:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E1CC9034; Wed, 19 Sep 2012
 20:35:49 -0400 (EDT)
In-Reply-To: <CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com> (Adam
 Spiers's message of "Thu, 20 Sep 2012 01:25:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FF1E864-02BB-11E2-88D3-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206022>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Sep 20, 2012 at 1:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>>
>>> ---
>>
>> No explanation why this is a good idea, nor sign-off?
>
> I realised I forgot the sign-off seconds after sending :-(
>
> Isn't it completely self-explanatory? e.g.
>
>     test_expect_code: command exited with 0, we wanted 128 git foo bar
>
> clearly makes more sense than
>
>     test_expect_code: command exited with 0, we wanted 128 from: git foo bar

If it were "..., we wanted 128 from 'git foo bar'", then I would,
but otherwise, not really.
