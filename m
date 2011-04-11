From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] gettext.h: Avoid using a non-standard C construct
Date: Mon, 11 Apr 2011 13:13:00 -0700
Message-ID: <7v1v18wnqr.fsf@alter.siamese.dyndns.org>
References: <4D9E056C.1070906@ramsay1.demon.co.uk>
 <20110407221015.GA20080@elie> <4DA33735.5070402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 11 22:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9NUC-0007Ou-Tr
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 22:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab1DKUNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 16:13:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab1DKUNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 16:13:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 025415FBC;
	Mon, 11 Apr 2011 16:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WPoi0yvHyiTalGy1AbigLXSGLzA=; b=jC48XX
	oYb5vDZUaVcIiX0eYmmmAcW1HghwVuT7MWp1x+WHR8f0h/GEi/zT/1gZHm2F+MqT
	4MpAPKoKwL45KPFgB28nPlqOMT4la/UOFivdY/ZShI+d1voM02bWK2iUwuxwfJyl
	jKp8Zx2w2PTmbLpsRuYjAVXqGHMnSHZT3Urbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nTi7HhIfJ/3d/Fn+HBbnk/tPRHZbgeAO
	d0azUCS0MNYwc9MNqeku4kzuSXJPmV2WIE7iNs23xNxO0j5f1d+7SEsgVk0Ddw/R
	HIyEwdEvkRMA40BM0EPpNkZrd0b8/PO7ytqnFkxsBEyW+pFuGco32GIBZfKyBmAq
	1Mr5Bjd5HOg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A450B5FB5;
	Mon, 11 Apr 2011 16:15:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0EA035FA5; Mon, 11 Apr 2011
 16:14:59 -0400 (EDT)
In-Reply-To: <4DA33735.5070402@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Mon, 11 Apr 2011 18:15:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 647D7936-6478-11E0-BBFA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171353>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> 	Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> 	Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>> 
>
> Sounds good to me. I'll re-roll and use your message verbatim.

Thanks, all.  No need to resend, as I'll be queuing what we got in 'pu'
after amending it.
