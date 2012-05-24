From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: no progress messages if !isatty(2).
Date: Thu, 24 May 2012 14:46:41 -0700
Message-ID: <7v62blw8u6.fsf@alter.siamese.dyndns.org>
References: <20120524061000.GA14035@sigill.intra.peff.net>
 <1337839944-4651-1-git-send-email-apenwarr@gmail.com>
 <7vy5ohwhy7.fsf@alter.siamese.dyndns.org>
 <CAHqTa-3QUsW_AP67NWjc-Gu5FZ7xQZyOOM-=zea+vwZeT79=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 23:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXfru-0001xM-Rs
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 23:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006Ab2EXVqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 17:46:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758046Ab2EXVqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 17:46:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FF780E0;
	Thu, 24 May 2012 17:46:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jqOe12ucI333
	6DrHTlfeULgnIh4=; b=bU5HGC8ieibedqPzdIlF5tsYKFPYkv7dQTs+3xEbk4sU
	kOl+fLCx2amhrzj2scGnF4spc+2QVzt5AL2mrwi7JpQw7MbNdeLC3Z6XdwdQkgcz
	Q9h0+UTpdNxpJz7qr8Y3E17DzWCuR3eEdwG+Sw0RcwwumJTvwSABk8UsTmhTVuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u8JpiC
	DidNUIHMjn1MDZYu7zxgg++PYq4cYquWGVsqMHmyI+J0UfripGViH5Jw06APrxIi
	dFIF8TAITtmBbT2e8jBPVjBJz2UYQs83hLiozz6zM+WIluAoN6iqF4a40A6xYbAd
	AZ2N7IvP2MJzN1VTa6F4cYwDYno8c765G6D8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBAA380DB;
	Thu, 24 May 2012 17:46:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 494B080D7; Thu, 24 May 2012
 17:46:43 -0400 (EDT)
In-Reply-To: <CAHqTa-3QUsW_AP67NWjc-Gu5FZ7xQZyOOM-=zea+vwZeT79=0A@mail.gmail.com> (Avery
 Pennarun's message of "Thu, 24 May 2012 14:46:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3BE0D32-A5E9-11E1-8652-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198435>

Avery Pennarun <apenwarr@gmail.com> writes:

>> I'll lift it from your original version of the patch:
>>
>> =C2=A0 =C2=A0If stderr isn't a tty, we shouldn't be printing increme=
ntal progress
>> =C2=A0 =C2=A0messages. =C2=A0In particular, this affected 'git check=
out -f . >&logfile'
>> =C2=A0 =C2=A0unless you provided -q. =C2=A0And git-new-workdir has n=
o way to provide -q.
>
> Do you want me to rephrase the commit message and resend?

No need, unless you want to say something vastly different from the abo=
ve.

Thanks.
