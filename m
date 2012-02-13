From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove Git's support for smoke testing
Date: Mon, 13 Feb 2012 02:32:55 -0800
Message-ID: <7vty2vf2g8.fsf@alter.siamese.dyndns.org>
References: <1324660098-26666-1-git-send-email-avarab@gmail.com>
 <CACBZZX7pDYFqSUjqDjjEFZBaTsoN9oa9vy5Cq4CckP2nZSSRyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 11:33:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwtDT-0000NG-En
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 11:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab2BMKc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 05:32:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab2BMKc6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 05:32:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9989D76F7;
	Mon, 13 Feb 2012 05:32:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gtib/DLQkdIi
	qPMArXhjCAPttPE=; b=qIgBVOKlOB3jJY6PvW11TcVcizb9PlO3AWM+JmWCbeh4
	4lCTrNK85c/Po2z2/MKBWd6RucD9yvBesr+DhCMjglwHc51wkQFhL92M2IQID0Xg
	ANhm9B9/PeWn9bjUGkpRsjxL1Zq8C1srwtdV8SHYalzqXNiYYNU1IWjQVkQhfUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GucF9J
	Bu28KNFl30P1+dFAnl9l9cJzBA9QKdn6SvjT3Q4Rr5eueCu2nYvRib1hDjTZZ/Vv
	rs+yHGPx8dvTizYEEFji/JKeXBkm125tmOQiJ3VrH85W63O8ffBurF+eucrFgAkM
	ptFYsgfu7909MXGtcG1zfgRm8x/hOEPKOh1Ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 913FB76F6;
	Mon, 13 Feb 2012 05:32:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2921A76F5; Mon, 13 Feb 2012
 05:32:57 -0500 (EST)
In-Reply-To: <CACBZZX7pDYFqSUjqDjjEFZBaTsoN9oa9vy5Cq4CckP2nZSSRyw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 12 Feb
 2012 01:09:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 182B2292-562E-11E1-A198-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190624>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Dec 23, 2011 at 18:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> I'm no longer running the Git smoke testing service at
>> smoke.git.nix.is due to Smolder being a fragile piece of software no=
t
>> having time to follow through on making it easy for third parties to
>> run and submit their own smoke tests.
>
> Junio, could you please apply this? The current release's t/README
> file is pointing to a service I'm not running anymore.

Will apply these three directly to maint (they all look sane, safe and =
do
not add any new features).

 [PATCH] Makefile: Change the default compiler from "gcc" to "cc"
 [PATCH] Remove Git's support for smoke testing
 [PATCH] t: use sane_unset instead of unset

Thanks.
