From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 12:57:06 -0700
Message-ID: <7v1v1pr97x.fsf@alter.siamese.dyndns.org>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> <7vbp0tss6t.fsf@alter.siamese.dyndns.org> <7v7hbhss0g.fsf@alter.siamese.dyndns.org> <4D9226B4.20806@warpmail.net> <7vd3l9rbnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <drmicha@warpmail.net>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:57:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4f2d-0008E5-UA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab1C2T5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:57:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1C2T5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:57:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C85F94CDA;
	Tue, 29 Mar 2011 15:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RbvX9ekcXZcDXOXk1238mcCfe7s=; b=D3l6MA
	trovJQ7RMpe7UV0e3Gbw6hDwEnM5BoARXqKHjMnP2MmRaUb1MsMqAmSHdVXl5F3M
	TTuy52TRugs3iQBnVmUuDppdRCUc2L3f/JByTle1oPm8w4iqOP5QNbnD/WnpicMd
	Jd2E783p+z9m8Cdj3v9SjLedxVkoAMmQssYSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ez2k0ibIaWdFMSSgX9vbgfQzb+7/JSTl
	3+QW+TDQ3N3qQet4Hqdz493jvZgZWPUTWU+k/CPqBsAprKorNdloQ91FiGxWe3jW
	oaDt6kci7i9lp/n41dQ/JwkunOQ73KoDDc9MdqfM+lZCavstZyyyLNHZQwaEtDKE
	Q81a3/b6e0U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95EB94CD5;
	Tue, 29 Mar 2011 15:59:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4297D4CD4; Tue, 29 Mar 2011
 15:58:56 -0400 (EDT)
In-Reply-To: <7vd3l9rbnq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Mar 2011 12:04:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDE35A08-5A3E-11E0-A708-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170314>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <drmicha@warpmail.net> writes:
>
>>>> Yeah, it utterly is broken.  Why not fix it before people start making
>>>> serious use of notes?
>>
>> You seriously ask why? Because I've banged my head way to often by
>> suggesting behavior changes!
>
> Change of a behaviour that nobody had chance to have seriously used for
> only 6 weeks or so?  I'd call that a fair game.

Oops, sorry I misread the timestamp.  It has been one year and 6 weeks.
Hmm, but still -C/-c is wrong.

I am very strongly tempted to fix the semantics, though.
