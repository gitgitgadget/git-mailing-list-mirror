From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/21] list-files: a user friendly version of ls-files and more
Date: Tue, 27 Jan 2015 12:30:48 -0800
Message-ID: <xmqqegqgkltz.fsf@gitster.dls.corp.google.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
	<1422189476-7518-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 21:30:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGCmm-00015J-Id
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 21:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759865AbbA0Uaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 15:30:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759859AbbA0Uav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 15:30:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E600A3201E;
	Tue, 27 Jan 2015 15:30:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XNQ7WuiXwzff
	sCJYgyTVOJvMwP8=; b=JiWQZ1pIXpLRhRvoQm0vmuiTrrEvEGsNniNtJlb5t+pn
	m2+nBlja/rw0gkZ5z7YxeaLFXzR9nAkReflmHzfQvHtSBiCbJ2rYysigLR8ElzNE
	OSoG4uCv50f6afmLjL8crSVR8EQOYErg4sXd1rriz/fal0FnQBOAm5tjq+f4ZWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qv89P5
	S0/je+mKPCDFWABhCOZV86JRIfHyy+a4aXyjQgkSz1mxUiJlQfq2S6sNIBcebslg
	f9loMbZukj/ztGIX0kWmJAW8RBA+3bV/HY60cZftS8dp3dyh+DHH1CmKmFg+ctyz
	4TGdVhA5IQq0cw8bjAQGWvrsngIiCb5ogSth0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC2633201D;
	Tue, 27 Jan 2015 15:30:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 759F03201A;
	Tue, 27 Jan 2015 15:30:49 -0500 (EST)
In-Reply-To: <1422189476-7518-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 25
 Jan 2015 19:37:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6173F93C-A663-11E4-8AD9-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263088>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +color.list-files::
> +	A boolean to enable/disable color in the output of
> +	linkgit:git-list-files[1]. May be set to `always`, `false` (or
> +	`never`) or `auto` (or `true`), in which case colors are used
> +	only when the output is to a terminal. Defaults to false.

This violates the configuration variable naming rules; perhaps
rename it to color.listFiles or something?
