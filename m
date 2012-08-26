From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch -v: align even when the first column is in UTF-8
Date: Sun, 26 Aug 2012 11:28:54 -0700
Message-ID: <7vd32dv76h.fsf@alter.siamese.dyndns.org>
References: <1345817872-7943-1-git-send-email-pclouds@gmail.com>
 <CABPQNSYabHGzmEfukt1PzT=j3qa99fScDHRZqLZvLNv9cJKXag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 26 20:29:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ha3-0006Yv-9C
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab2HZS25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Aug 2012 14:28:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325Ab2HZS24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2012 14:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B99D8D90;
	Sun, 26 Aug 2012 14:28:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qScovq9F0cDa
	glHpazeXhv34liQ=; b=Z9ec+ZIrcwbkdzcR70g1+iYeeJ+KQxW+BJ+ti1ivsoRD
	ZC3uVijKFbaxqbJpXzsnb4l9Of29flMHmQFjni1mxb0ARZRnKulteedhCtFwe/7/
	s2N3Yu8KKO/9hpEAZ1Gc87FwT2JLHw+W00nbedt1Ew3lfUG8RZFU3yzVNTWJwxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YTTDCT
	ptc+fCr5QdGquL4DMRZ6uTD4IoUtbLrMjFvtP9oJOtAmWgZi2Lza5kHV4hK80Aqe
	8+BMH1AtKEtNrnPs9opPqPBLs3fWK3EJyIuN443JiWGrt/Zg2eB3cnD7wB7ZgyW4
	2I9tbnWnDYvfMKKNRM9Rzj9RpziYNyCyLQqqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58C4D8D8F;
	Sun, 26 Aug 2012 14:28:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5D508D8E; Sun, 26 Aug 2012
 14:28:55 -0400 (EDT)
In-Reply-To: <CABPQNSYabHGzmEfukt1PzT=j3qa99fScDHRZqLZvLNv9cJKXag@mail.gmail.com> (Erik
 Faye-Lund's message of "Sat, 25 Aug 2012 12:48:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4FEE06C-EFAB-11E1-83D3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204306>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, Aug 24, 2012 at 4:17 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>  1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 5 =
=C4=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 3 b=E1=BB=8B x=C3=B3a(-)
>
> Huh?

Perhaps format-patch should always use C locale.
