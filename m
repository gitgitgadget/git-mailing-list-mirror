From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Thu, 12 Feb 2015 14:57:01 -0800
Message-ID: <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 23:57:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2h4-0003hZ-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 23:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbbBLW5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2015 17:57:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750805AbbBLW5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 17:57:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F4737CEC;
	Thu, 12 Feb 2015 17:57:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lGnkfS5jbu4s
	W029/bPgAeqQxlQ=; b=WdTfbAm2kRDFhW4eMxRxmSmUARbyJIzLtQzp0dIFINyp
	iEfYV4QXj1zFhkxrHJ/IgsfwopESb1a7YdCgjMgHRGB04WQLGXPKVZnvq76xWOgt
	oTlZLL+XJD2U3vytnXcJtiho50KzVb9dvCg6QeAJfUWNiH58FdoMoFA2bTuiOvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Vg+qqJ
	vDazKRfiONXV5iZAfATMBCN0EgTLqyHjohwAI9BKNUwQKI/TTN0/7wudH7SpihoU
	l9Ie5rMFvy4zlrDAp4nX6euxc/UFB+oDz8PW8XP3u8kzjcVA+k0JZ/xLQHeVNpK8
	qD9Hqnni0XtP/UWU+R/Ub8Ow8JSOSmZUfKfrQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50C4E37CE8;
	Thu, 12 Feb 2015 17:57:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6C8637CE6;
	Thu, 12 Feb 2015 17:57:02 -0500 (EST)
In-Reply-To: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 3 Jan
 2015 16:41:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75605EB4-B30A-11E4-ABA9-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263780>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These patches are on top of what's in 'pu'. They add
> --ignore-other-worktrees and make a note about current submodule
> support status. I don't think submodule support is ready yet even
> with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
> though, so only 01/03 and 02/03 are new.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/261107

With the understanding (perhaps a strongly-worded paragraph in the
release notes) that this is not suitable for submodule users yet,
is this in a good enough shape to go to 'next'?
