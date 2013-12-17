From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Document SubmittingPatches: inconsistency regarding to: and cc: for approved patches
Date: Tue, 17 Dec 2013 10:00:57 -0800
Message-ID: <xmqqob4fmk6e.fsf@gitster.dls.corp.google.com>
References: <CAEsF1LtJBA8gT9nEJv0_4CKRLGL7eWD19ghUGzQ9uWUCmj8X7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Gunnar Strand <gurra.strand@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:01:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsyxB-0008Fn-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257Ab3LQSBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:01:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755081Ab3LQSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:01:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF78659F21;
	Tue, 17 Dec 2013 13:01:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NZjHkFJqUKB+cWMRSCfCqu3mrr8=; b=khYi4g
	T+wx82v9ygxkk2wSHMmUgT3thL4D0+zDy7hy7NwHUzqnMLl8+K77D8YZLolG8X8m
	KNXPFBXChFw0t7/xWnUQIfYygCRE+N4WaA8WHG3Ox/DtFtNMXfDQ+Xhe27n+6q8B
	dBrt/ZYagOdnNi46S4vftP6dTJYORSPAc90z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kFjhCyoatXOtcy5yqply4tizak111Q+m
	MTETvmyffWdtTz3Jtsr/3cKne4/3MtJi2seprt2u7CTtaUI3tc/kv4MYeYA1tzSx
	og56RxShCEVCXD2MsbtKN6F8AUe0Af5W1ihxU3cLU9ecsXb733GEIZVHblkorg+y
	ujZI1iwzlcI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8FB859F20;
	Tue, 17 Dec 2013 13:01:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6EE259F1A;
	Tue, 17 Dec 2013 13:01:01 -0500 (EST)
In-Reply-To: <CAEsF1LtJBA8gT9nEJv0_4CKRLGL7eWD19ghUGzQ9uWUCmj8X7w@mail.gmail.com>
	(Gunnar Strand's message of "Tue, 17 Dec 2013 10:59:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 30AC46C8-6745-11E3-B3B6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239394>

Gunnar Strand <gurra.strand@gmail.com> writes:

> The patch submission document has an inconsistency regarding who should be
> "To" and "Cc" for approved patches:
>
> To maintainer, cc list:
>
> 212 After the list reached a consensus that it is a good idea to apply the
> 213 patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
> 214 list [*2*] for inclusion.
>
>
> To list, cc maintainer:
>
> 339  (4) The list forms consensus that the last round of your patch is
> 340      good.  Send it to the list and cc the maintainer.

Thanks. In the latter, they are swapped.

Perhaps the whole section can be dropped?  Back when the section was
written, the top section did not describe the review iteration and
lines 212-214 you quoted above did not exist, but the top section of
the current document already cover everything in the "ideal patch
flow" section, I think.
