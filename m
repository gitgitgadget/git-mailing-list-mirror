From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Can show relative date of the commit with future
 timestamp
Date: Mon, 20 Aug 2012 15:51:04 -0700
Message-ID: <7vsjbhgotj.fsf@alter.siamese.dyndns.org>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
 <7vy5myqftw.fsf@alter.siamese.dyndns.org>
 <CA+P7oHuCbeJ5shfL5OVhSypgygzmQwn-RGPD8UvFUFuqnoV9fA@mail.gmail.com>
 <CA+P7oHtGsBoRGsUzg4qqm7sZJ=+1Jh06Gmj1uw+k0-S9Gk+DXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jundong Xue <tomxue0126@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3aoV-0006yr-EY
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736Ab2HTWvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 18:51:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727Ab2HTWvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 18:51:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2449303;
	Mon, 20 Aug 2012 18:51:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=yy3iAbmLZkrIMVRC7tpof/Jod
	SQ=; b=OtEucpj8Wl8Oaowz86xVaLKC1P2IAKqt2/vHXTsU3D9JcWGhLZzhEuOl4
	RyzG38xnQZtgJlSktrq5U9nCgDK3WeWZkTkWi+KdMF+OUpaDzpxQyjCmTUO7/G9y
	RNxyU6S896VvVDjygCqFinUJ9G47MNaT63Ko5CXwVslnRq8n9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SDD4JOqhbTP8rIjzu09
	ffxyNdt/8z3bIHReM5SetXLz7rPRO5T416Ej+9VdkmAKFLPT/Fs/UCN5u2B0BusH
	Q1VLYOii9hx3NifUHfeYfJAwug/b4s/FvXlsGN+fU/9c5xThto3YGNttbkr8V38B
	e5ciDThAyy8Yvxjm/Qac+v84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27EBC9302;
	Mon, 20 Aug 2012 18:51:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96A089301; Mon, 20 Aug 2012
 18:51:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8638366E-EB19-11E1-A7D8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203904>

Jundong Xue <tomxue0126@gmail.com> writes:

> tomxue@ubuntu:~/mycode/life$ git todo
> * d768da9 - (in the future: 3 hours later) Meeting with vendor =E2=80=
=94 Tom
> Xue (HEAD, master)
> * 5fcd556 - (in the future: 12 days later) Take my personal holiday =E2=
=80=94 Tom Xue
> * 9dd280b - (in the future: 11 months later) =E7=AB=AF=E5=8D=88=E8=8A=
=82 =E2=80=94 Tom Xue
> * 4680099 - (in the future: 9 months later) =E6=B8=85=E6=98=8E=E8=8A=82=
 =E2=80=94 Tom Xue
> * 59d5266 - (in the future: 8 months later) =E5=85=83=E5=AE=B5=E8=8A=82=
 =E2=80=94 Tom Xue
> * b5308da - (in the future: 7 months later) =E9=99=A4=E5=A4=95 =E2=80=
=94 Tom Xue
> ...

I was re-reading the backlog and after looking at it again, I do not
think what the patch tries to do is a bad thing.  There are changes
I want to see _how_ it is done, though.

Especially, the duplication of the exact same logic in the future
and in the past is an unmaintainable mess.

I have queued a replacement in 'pu'.
