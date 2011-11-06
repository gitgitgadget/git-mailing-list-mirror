From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1] gc --auto: warn gc will soon run, give users a
 chance to run manually
Date: Sat, 05 Nov 2011 17:19:25 -0700
Message-ID: <7vaa8a85ma.fsf@alter.siamese.dyndns.org>
References: <1320489212-524-1-git-send-email-pclouds@gmail.com>
 <20111105154411.079F69004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fernando Vezzosi <buccia@repnz.net>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqST-0004WI-25
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1KFAT2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 20:19:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab1KFAT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 20:19:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3946E54A3;
	Sat,  5 Nov 2011 20:19:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FUgqDKPJ7MW6
	4abOtwPeK2oxl0I=; b=ZqItozzQ9mTmth7gWVcecGF7F2AS5aVs2TzdubUpPs8r
	oYPcHcbQBlDsefVGPq9zT1UU7++Emr/oxCzHWZMsSsHSPbGgLaQDQ85cTbDxXqMu
	eaIsPCHULWyPDgx7OGwnbz0i0ITzFQhPAHk4bsCCu96gsNyut+Q9yVShAtVsu4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xtKWMV
	WTYQmd+nT0aya9fr8ct05X21pFhoyN2IFVRPsHFP2zboY7HiVhNOHJdcOQnwBf+H
	UkHQBE3vTrbuKlP7RU/ChL0rzVTLk0kx74Q/cNo2Lr/9OLtqayENLEmOJsXs9ydq
	2UQrYoj/jDKfnz0sRZ8h2WY1PhX50qpUqX/Q8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D70954A2;
	Sat,  5 Nov 2011 20:19:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87EEB54A1; Sat,  5 Nov 2011
 20:19:26 -0400 (EDT)
In-Reply-To: <20111105154411.079F69004A@inscatolati.net> (Fernando Vezzosi's
 message of "Sat, 5 Nov 2011 17:33:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC7037D2-080C-11E1-9155-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184885>

=46ernando Vezzosi <buccia@repnz.net> writes:

> Signed-off-by: Fernando Vezzosi <buccia@repnz.net>
> ---
>
> Rebased Nguy=E1=BB=85n's patch on top of mine.

You don't have to do this.
