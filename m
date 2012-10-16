From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge option suggestion (dictator, humble)
Date: Tue, 16 Oct 2012 10:23:04 -0700
Message-ID: <7vpq4is553.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6TYEstro0J5jFJc1sZMoLC9gkHWrZdu4Y=hz-+kKkqXTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOArR-0002X8-3e
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab2JPRXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 13:23:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135Ab2JPRXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:23:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C4C093EC;
	Tue, 16 Oct 2012 13:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dxQgG3wusE73
	DxMDzhGkcq06KCs=; b=dwpyrtHvjl3YJiJr0x1PY7ruZOW3z8Nf1/QdNFKqoAOw
	tA+UjvJZFkKDTOveFEzYv8eKa/PSlOt243Sbqk4DO8uvr6QT2s2K2Amb8TUwvmD+
	b6pRc7jczeuho4pX11F1V4+hSHMElFWzNwiRZOg8W1hA365EUTlcvwoFeC4+ZLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wv+rjY
	4FlWPnMATAII999rtjK09zzxpisd8ogAkydgJkyfw0UtsLv+4Y05Q3wdv+Ck8kYS
	D4OW5yc1uubLGPHJE5FaI75IV10AveLUdd6Nj98hFSigM59giyWCuCf687tOKws/
	JwUSb2893tfJNXtvu883fPVV+K2/X+Yp0Q8Pw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0793C93EA;
	Tue, 16 Oct 2012 13:23:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C34293E5; Tue, 16 Oct 2012
 13:23:06 -0400 (EDT)
In-Reply-To: <CAHtLG6TYEstro0J5jFJc1sZMoLC9gkHWrZdu4Y=hz-+kKkqXTQ@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Tue, 16 Oct 2012 23:52:09
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25E67C16-17B6-11E2-95C7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207854>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> I would like to suggest 2 merge options
> --dictator   use all my changes
> --humble   use all their changes
>
> These allows to produce a fast-forward commit, without resolving any =
conflicts.
> Sometimes, someone did something completely wrong, so the commit need=
s
> to be ignored.

> I cannot tell everyone in the world to run git fetch followed by git
> reset --hard.

Then you cannot tell them to use "pull --humble" either, can you?

Not seeing any merit in the proposal (yet).
