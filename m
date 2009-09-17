From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Wed, 16 Sep 2009 18:27:18 -0700
Message-ID: <7vk4zyuzrd.fsf@alter.siamese.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <m3fxavvl5k.fsf@localhost.localdomain>
 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
 <20090912103156.GA30385@dpotapov.dyndns.org>
 <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
 <20090912214428.GB30385@dpotapov.dyndns.org>
 <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
 <20090912224335.GC30385@dpotapov.dyndns.org>
 <43d8ce650909121608t2b9c4b9bw44104acceea26e12@mail.gmail.com>
 <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
 <ef38762f0909161748u32ad56bcya3314fe28fd06ffe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 03:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo5me-0002yC-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 03:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbZIQB1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 21:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbZIQB1a
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 21:27:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbZIQB1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 21:27:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50C2E53F25;
	Wed, 16 Sep 2009 21:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cp++sOc6XQZ/I2wVOKC0HadDUu0=; b=mbTkkj
	ZivCdoKhnfLEB6KHlvgO1JlOPH0V5a4q/tYlhvcH+5/s+cOmbCglBi3gXlzPwjcd
	aXk+yii9wB16e7HDvaDlgDdBFkuZjvyQDWN5p3FnPPInaFse9wJgfQHm3nwECqr6
	hSmrxylaI90oe5uniDbhK3QoeAwe4SmvFQJLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nM7/s3YMSZTncj5RPwc3+gUnIfsuBgUK
	piU7dKGrkAbBOU7CUsDBuaodCupUalFArm5lrKeGiPcC/BV4wdjoNh2v0BCVH/Bb
	rkCVoLFWQGiTGSYpY34bSMGb12EhyzRcwpmiySkvxzqGxEcw+vfqEg9mlcyDI8Qb
	eaACBRK7vsg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F6DB53F24;
	Wed, 16 Sep 2009 21:27:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EDC4F53F23; Wed, 16 Sep 2009
 21:27:19 -0400 (EDT)
In-Reply-To: <ef38762f0909161748u32ad56bcya3314fe28fd06ffe@mail.gmail.com>
 (Brendan Miller's message of "Thu\, 17 Sep 2009 09\:48\:32 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 425E5BC0-A329-11DE-93AC-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128701>

Brendan Miller <catphive@catphive.net> writes:

> On Sun, Sep 13, 2009 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Tapsell <johnflux@gmail.com> writes:
>>
>>> Ah, the manpage examples specifically give the --format=tar though.
>>
>> So what?
>
> That looks like a manpage bug. In the version I have 1.6.4 the format
> for archive is given like this:
>
>  git archive --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
>                          [--output=<file>] [--worktree-attributes]
>                          [--remote=<repo> [--exec=<git-upload-archive>]] <tree-i
> sh>
>                          [path...]
>
> So --format isn't marked as optional.

Ahh, that would indeed be a documentation bug.

82d97da (Documentation: git-archive: mark --format as optional in summary,
2009-08-27) fixed it already, so upcoming 1.6.5 should have that fix.

Thanks.
