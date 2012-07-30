From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New git.pot is generated for the upcoming git v1.7.12
Date: Mon, 30 Jul 2012 14:18:20 -0700
Message-ID: <7vvch5osmb.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFLy4s3q1Tn9FD1ASLwY1=AND_ePqhHpC_X_nvb1iLoCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	David =?utf-8?B?SHJiw6HEjQ==?= <david@hrbac.cz>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:18:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvxMS-0006pk-Da
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 23:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab2G3VSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 17:18:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754793Ab2G3VSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 17:18:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD52492C4;
	Mon, 30 Jul 2012 17:18:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1eAwIAJApiyz8cJcbNPmkuyu24=; b=CDKTo1
	B7H3/PLTY5iTe+vjd58B1ftLzxwxPxAkKCVL4F+zTMvpLNt4XGGQWqN05DlD5PcL
	tTEiYhWAzrWYQI+1AsjLxoBv6rX9pMd/nfIdNp0p0f0VX87ByQlPlRdKlOi9AMbw
	DOWojzkihsdofWQIYWq6R3souNv4a5cWo1mNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=joh5hIN6Xuimt3gQ1mXNa6wfwoqNLVDF
	XgB4jIcJCEslYc2+VOVz6AhCCUobS6swS8GIzyBlSKA+Sf0OE/AwXdmvvOveIfUg
	0uea0GxwwW+AadeKuS+I6/2BPX86mapWp03EMqM+x4uXsi2B/zL/pHw9rj76K4aq
	J8s3Rb2mL4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C541E92C2;
	Mon, 30 Jul 2012 17:18:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24A0892C0; Mon, 30 Jul 2012
 17:18:22 -0400 (EDT)
In-Reply-To: <CANYiYbFLy4s3q1Tn9FD1ASLwY1=AND_ePqhHpC_X_nvb1iLoCA@mail.gmail.com> (Jiang
 Xin's message of "Mon, 30 Jul 2012 11:10:24 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1778D64A-DA8C-11E1-BCE2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202617>

Jiang Xin <worldhello.net@gmail.com> writes:

> L10n teams:
>
> New "git.pot" is generated from git v1.7.12-rc0. L10n teams can get it
> from the usual place and start translation.
>
>  * https://github.com/git-l10n/git-po/commits/master
>
> This update is quite small:
>
>     l10n: Update git.pot (4 new, 3 removed messages)
>
>     Generate po/git.pot from v1.7.12-rc0-54-g9e211, and there are 4 new,
>     3 removed l10n messages.
>
>      * 4 new messages are added at lines:
>        1254, 1264, 1459, 1523
>
>      * 3 old messages are deleted from the previous version at lines:
>        1254, 1273, 2854
>
> I am not sure whether Junio would like to merge new new i18n commits
> to the upcoming 1.7.12, but I bet there would be more i18n/l10n works
> in the future. (I would contribute more i18n update since I begin to
> update my book on Git in Chinese, any untranslated output would be fixed.)

I was of mixed mind regarding the script i18n, given the series came
fairly late in the cycle.

I'll merge two topics (jx/i18n-1.7.11 and nd/maint-i18n-diffstat)
immediately after 1.7.12-rc1 I am cutting today, so we would need
another round of work from the translators.

Thanks.
