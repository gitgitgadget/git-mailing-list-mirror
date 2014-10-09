From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] completion: ignore chpwd_functions when cding on zsh
Date: Thu, 09 Oct 2014 11:10:44 -0700
Message-ID: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
References: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
	<1412804988-56858-2-git-send-email-bt@brandonturner.net>
	<loom.20141009T093007-811@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Turner <bt@brandonturner.net>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 20:10:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcIAt-0008S8-EM
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 20:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbaJISKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 14:10:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751026AbaJISKr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 14:10:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78839137E1;
	Thu,  9 Oct 2014 14:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cFlwVAa0z2yG
	byN7II4qPayDJ7Y=; b=Pt7t0uWG9HEbDP4qQUtGRkIkjy3MkWddNIxOwXvlPpe4
	jLD/rInjx6tmCHRzPlHyLVo5w7ZWVdzlxKqBrLWCdEcQJ+dhI1wvuTxwJMdyJzxT
	BlrCqRdn7lvRFrbqQCnVamnPrOKR0hNnwolrujRmdX2mZvmELyPBQyKZoqVIAgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bXIkQ6
	BPl9t0iCzrwkpGMc6xGtqo19jH1+rSRxAEgUpAIhYVoEgATiDTdbYhJz3q0VmtGu
	AdZdeySPu5rs7QmNWUUzixi9ArZwhcW7hAW6uspr7L/dvrkFlNJGoCQ/BO/V4k58
	qUKDA/ezg2mcJENHZKpb0rLddobbZghCIdAt8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70D10137E0;
	Thu,  9 Oct 2014 14:10:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6946137DD;
	Thu,  9 Oct 2014 14:10:45 -0400 (EDT)
In-Reply-To: <loom.20141009T093007-811@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Thu, 9 Oct 2014 07:34:30 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 971D8286-4FDF-11E4-8CCB-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Brandon Turner <bt <at> brandonturner.net> writes:
>
>>=20
>> Software, such as RVM (ruby version manager), may set chpwd function=
s
>> that result in an endless loop when cding.  chpwd functions should b=
e
>> ignored.
>
> Now that it has moved to the zsh-specific script you can achieve this=
 more
> simply by using cd -q.

;-)

Is the way we defeat CDPATH for POSIX shells sufficient, or does it
also need to be customized for zsh?
