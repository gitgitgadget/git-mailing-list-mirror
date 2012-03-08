From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 08 Mar 2012 11:55:14 -0800
Message-ID: <7vpqcmdg0t.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <CACsJy8CYTnrcAX6TNORdg=KAk4_xNupT11Uw8o8gnW6NtQtMCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5jQs-0000om-9j
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab2CHTzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 14:55:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2CHTzR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 14:55:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 700047E51;
	Thu,  8 Mar 2012 14:55:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=POjgJimkzy82
	0iyM/LRhkOYY8vw=; b=aHAtjf3D07cbzrpeQRwFbdIOK6IeLriajvl9qDKV9/Zu
	T9qTuA8ZbRt2QBZ9nMFhZpXq9lyq5MQAJ+i8Hyt9cMybaXONXmg/UqBr36VuXUuG
	xJUZwd/IrjNkhCL/z0Ra/Y9hfxW1AEG8pRAzsfzgiqpL44XcTqy2YisP8o40sjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q47NZI
	CF5myt06a8r2EwRV3mHCbInUW3uTReVU7fkKS4S1JliEh+Qhdsuge68k2ZGdzKnn
	G7jd9lYKYPwHO/fLbMS5pDFeus15jTgG5YOCSlGbgYYapk2SCLrbX9sXEcl1D/L+
	5q8byjKQKsV0caXFeYTgORwJAJhZanqPrTma8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CDCD7E50;
	Thu,  8 Mar 2012 14:55:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ECAF7E4F; Thu,  8 Mar 2012
 14:55:15 -0500 (EST)
In-Reply-To: <CACsJy8CYTnrcAX6TNORdg=KAk4_xNupT11Uw8o8gnW6NtQtMCA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 8 Mar 2012 17:29:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FAB0614-6958-11E1-BC66-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192638>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Mar 8, 2012 at 8:35 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> =C2=A0* "git clone" learned "--single-branch" option to limit clonin=
g to a
>> =C2=A0 single branch (surprise!).
>
> --single-branch also limits fetching tags to minimum, I'm not sure we
> need to mention that.

Yeah, I was of two minds when I wrote it. It is obvious once you
think about it, but spelling it out does not cost much, so let's do
this.

 * "git clone" learned "--single-branch" option to limit cloning to a
   single branch (surprise!); tags that do not point into the history
   of the branch are not fetched.

Thanks.
