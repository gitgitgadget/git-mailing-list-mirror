From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/25] More flexibility in making shallow clones
Date: Mon, 08 Feb 2016 13:45:13 -0800
Message-ID: <xmqq60xy7u6u.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:45:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aStcY-0004OZ-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbcBHVpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 16:45:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756433AbcBHVpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 16:45:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AFF441659;
	Mon,  8 Feb 2016 16:45:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8UM7UClWJU1I
	zbfhpVU4BHaDnto=; b=HQ1Yhf+CxdRgLoE+Of/JGs/GuJLMi3FDSmULhxrfbNnP
	eT3mLgblqwr+4QM3qjNugSGiWH1NOHe4ctRrJYo5uWdPaXfiMcgk+msNWaDHcN2e
	+NV3h2YKTRwzWRH2NJ2dWjBuJ/AdfFbsgoOlG9HeXKcnCyZ1HNvAGq9j11Fsb8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aCHPai
	3ub+IXzZRiNF1P6GR4erw+Zk62RRLt5AMfYJIHNsxgZnrISQ9A5kNHFL1e40ttiF
	obvdSwIkZu+EiKkAEOF3SoLE+8xsveRdGKfWDbGJVf1lVg8aq7liWLlBQoOsvlim
	gxR1cTu7YRhf2/GR4/TO83hYDVR7pHF6ASSPE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 527D341658;
	Mon,  8 Feb 2016 16:45:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B473B41657;
	Mon,  8 Feb 2016 16:45:14 -0500 (EST)
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CB0AD52-CEAD-11E5-B6D8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285812>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This series brings three new options to shallow clone/fetch, to let
> you specify cut point by time, or by excluding some refs, or to let
> you extend shallow boundary by <N> commits.
>
> The series is now complete. Changes since v1 [1]
>
>  - smart http support
>  - option names --not and --since are changed to --shallow-exclude
>    and --shallow-since
>  - fix the last patch per Eric's comments (the tests were totally
>    broken but I didn't realize)
>
> The meat starts since 14/25. Before that is just cleanups and stuff.
> Happy (shallowly) cloning!

Nicely done.  While I had a few "Huh?" moments, and I still feel
some changes are under-justified, it was a pleasant read overall.

How extensively have you been using this, or is this hot off the
press?
