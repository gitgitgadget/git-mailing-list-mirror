From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Thu, 20 Sep 2012 10:45:15 -0700
Message-ID: <7vipb8bnbo.fsf@alter.siamese.dyndns.org>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
 <7vboh1eew2.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
 <7vtxusbpub.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9hvBz5wYbj+q=oYTz7zWnP2E9dqtKZ-V=6jBW-FomfbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEkoa-0001Dv-CP
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 19:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab2ITRpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 13:45:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab2ITRpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 13:45:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10F6288A4;
	Thu, 20 Sep 2012 13:45:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PF3M4FxbB5kHIuFm9UAs7ugL+I0=; b=if8pmz
	Y4YLY9/uzQgWQevtM4C89iQUELMjJTgC7Xe6phHLbBlux1sfY4Fnd+IH1yoSxhfY
	FOlTTBybvh6mdekxUejtd6E15UjhMq4HY1ZDtFLUzhJzl6DzOn0Q4z9DrelEPd3J
	UcyXxkA2H8oMhhHLaaWtquc0ATyHjYQXUqGWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjDV++XuGFi0gqHjGGft2uegceky2/Ay
	8XonIEyfuGTsMWpOj/lmshe+Ti8NSfxBfpUlz6UP69Z9xRH4DGZOYCGcW7woh1y+
	M8iuJ0ikNMHrMeWx4yHnQ98CWxI6du33as0dibEVuYW90u1XN/5aI418lLUKlpSY
	kycjPi7kTEM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F1888A3;
	Thu, 20 Sep 2012 13:45:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E04088A2; Thu, 20 Sep 2012
 13:45:17 -0400 (EDT)
In-Reply-To: <CAOkDyE9hvBz5wYbj+q=oYTz7zWnP2E9dqtKZ-V=6jBW-FomfbQ@mail.gmail.com> (Adam
 Spiers's message of "Thu, 20 Sep 2012 17:57:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0A8B426-034A-11E2-BA2E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206061>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Sep 20, 2012 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Do you want this queued on top of your other series, or as an
>> independent change?
>
> Independent please.

With a sign-off?
