From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #13; Mon, 30)
Date: Mon, 30 May 2011 23:21:31 -0700
Message-ID: <7v39jvl79w.fsf@alter.siamese.dyndns.org>
References: <7v62osob67.fsf@alter.siamese.dyndns.org>
 <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
 <7vsjrwm4sj.fsf@alter.siamese.dyndns.org> <4DE4857A.70605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 31 08:21:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRIKp-0001u0-ME
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 08:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954Ab1EaGVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 02:21:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab1EaGVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 02:21:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A0895B9E;
	Tue, 31 May 2011 02:23:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMMX/5+N6rsGtgsay543jnAdFcQ=; b=bBuZzT
	4E+KulLgzJx6KM1FN/hUchclRAMpDoPr/KNaIhrrOmm0o3jB/iWa9nuw4tQcbAMF
	VIOzzCh5tQ1nhu4YnZrqVfVTIfGvMq2BWHLVJnhfBj4fr+8vbKxKrjlTtmwTqxXn
	DDUa8AfLgz6BSwqVY6EaqcYgF8fCTgY9ACiBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f5G6Dp1SNpr2gaOObRc9PdlzPnIlfQIr
	RfSWG+pVPNEwPreQrzMMM54m51bIST/ewl9PX1+6GyiA3lBRn1vCfIQeg1asXxH7
	heX5kxXvHulTzN5h8AKdDhh2Ei1h3h7G7swMpqbCGpAJ/FbNFpHJV8pWOAWO/mya
	Nu8774KNjo4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 190425B9C;
	Tue, 31 May 2011 02:23:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 085975B9A; Tue, 31 May 2011
 02:23:41 -0400 (EDT)
In-Reply-To: <4DE4857A.70605@viscovery.net> (Johannes Sixt's message of "Tue,
 31 May 2011 08:06:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A0196F4-8B4E-11E0-A518-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174795>

Johannes Sixt <j.sixt@viscovery.net> writes:

> ... But as far as I am concerned, I do not mind backing out changes
> that break on Windows until a solution is found.
>
> [*] I do include cooking topics where I think that there is a chance that
> they break on Windows.

Very much appreciated. We want more people to help keeping the tip of
"master" stable by running "next", or selected topics in it that may
affect you in the future, like you do. Hearing that "master" is broken
due to recent merge of topic X is, while better than hearing the same
after the tip of "master" is tagged, a bit saddening, as the reason "next"
exists in the first place is exactly to prevent such accidents by catching
buggy topics while they are in "next".

Thanks.
