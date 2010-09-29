From: Junio C Hamano <gitster@pobox.com>
Subject: Re: msysGit patches for upstream
Date: Wed, 29 Sep 2010 16:02:18 -0700
Message-ID: <7vzkv0kvb9.fsf@alter.siamese.dyndns.org>
References: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
 <1285798953-15320-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 01:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P15fS-0000Qy-8q
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 01:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab0I2XCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 19:02:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab0I2XCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 19:02:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C206DA06A;
	Wed, 29 Sep 2010 19:02:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vMEXc40EhnGpabVlfF6NGo1vKcU=; b=Y91Mdq
	gf27ScFHYPhXpj3LmjJOhqmk+J5xFosOZ1wxi70TzS+e88KnNsIFhL36T4WdvF2d
	FU5KrSm+Jxz290u1n7vjHmgeSCTNwspsD2INSV3JgKiSCvWo5Vh88OS56AmKVgdg
	2LCDRI0XwKjVxGLFwoDjLXKi3lEtVxxkGHPF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RfxPZ9SW+e6B9gVtZJ5dDsyBZQvTTy5/
	pU67gma7BqAvt3wa85x1Hp3HDGFqWNh2zMG5U68Q5fW5KL+sEukayPuVXQRTbwhT
	1m7hnjSxS7Dy0XzvUhq9/UYhkY4SFrjANJ1J/5lnjCVUW4eggDH5HF2MjNQbO0d+
	O6aaIUE49aw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 370E6DA069;
	Wed, 29 Sep 2010 19:02:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A882DA068; Wed, 29 Sep
 2010 19:02:19 -0400 (EDT)
In-Reply-To: <1285798953-15320-1-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Wed\, 29 Sep 2010 23\:22\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E09C360-CC1D-11DF-8CE3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157619>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> pack-objects.c usage string
>> connect.c use of unchecked git_getpass()
>>
>> Good eyes, but these should not be part of the series but applied to
>> maint.  If possible please send them separately.
>
> Following up on this comment here are the two patches from msysGit.

Thanks.

Since you are forwarding the patch to me, I'll add your Sign-off
(which was in the original series anyway) before applying them.
