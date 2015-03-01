From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --shortstat --dirstat: remove duplicate output
Date: Sat, 28 Feb 2015 19:54:24 -0800
Message-ID: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
References: <1425129567-18693-1-git-send-email-marten.kongstad@gmail.com>
	<CALKQrgcozE4y6ZWezvaedQqhATaQCtrxUScq_etJVDdkuG55kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?M=C3=A5rten?= Kongstad <marten.kongstad@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRuxb-0007yr-RV
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 04:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbbCADy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2015 22:54:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526AbbCADy0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 22:54:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D062B3CCBD;
	Sat, 28 Feb 2015 22:54:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MPWCvRtLdDD7
	6sDwLdWdI8ah/nQ=; b=VrXIElXGXqcxNmOT2tc9zkg4grLqsJ72vwjd7PKE/T1v
	3YjYDrZ72Aw8zIX8d+ot9kwG42lX40Femx8++pFcbieUlwlsFiw00ExmPBWo+2qc
	WVe7n1CTkuJTctZxCJDYaf5lJCJRBTxNSUBjBLOkEpgfZcXqf+6llYhJTU+6kic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fGeRYY
	b0Rjkg5qEhBZx9ZCIIq4VNycQcJp0F6PPAPGmk1EShFnDv0fSd1vKjDloLUcjiKy
	GHPUUiY9VRXvcKwMQL8ss6F0jBWU5nB+xobJFtWXrtyuc+UNkvHBJorhICwClo/7
	fAGY8yCddtQRx4TtyjjAWBNHqBUKHII6/v3UI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C945F3CCBB;
	Sat, 28 Feb 2015 22:54:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5304D3CCBA;
	Sat, 28 Feb 2015 22:54:25 -0500 (EST)
In-Reply-To: <CALKQrgcozE4y6ZWezvaedQqhATaQCtrxUScq_etJVDdkuG55kw@mail.gmail.com>
	(Johan Herland's message of "Sat, 28 Feb 2015 15:21:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6F616D0-BFC6-11E4-A4B0-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264548>

Johan Herland <johan@herland.net> writes:

> On Sat, Feb 28, 2015 at 2:19 PM, M=C3=A5rten Kongstad
> <marten.kongstad@gmail.com> wrote:
> [...]
>> Signed-off-by: M=C3=A5rten Kongstad <marten.kongstad@gmail.com>
>
> Acked-by: Johan Herland <johan@herland.net>

Interesting.  So nobody in real life uses --dirstat and --shortstat
together?

I am not very happy with the added tests that hardcode exact numbers
that are shown, as the counting algorithm can be improved.  Can't we
do better?

Thanks.
