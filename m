From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.7.rc3
Date: Mon, 26 Sep 2011 10:49:59 -0700
Message-ID: <7vfwjj42ig.fsf@alter.siamese.dyndns.org>
References: <7vhb42su6f.fsf@alter.siamese.dyndns.org>
 <CACBZZX77ZhdS1cyiYpjJcuvSnJsv15FUumPWeZOcwh_b41c2FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 19:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8FJl-0004Pl-LW
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab1IZRuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 13:50:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab1IZRuF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 13:50:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355634EBE;
	Mon, 26 Sep 2011 13:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pieBTFNX+EU+
	u0nGoYKN97ZlUeE=; b=BKIpBwocnjeOrk6eBs/O99c53xrpHRRItj0G6wbJtOkL
	nI6++WQvOToOpdJmy9JxAqxrMi+DganF6JtHhRuub2IdEH/i8Z89t8JGZ6qIRAV2
	cPzXPsgbUT6ncft0LFss3PYhiyxZvTEOkX1Vycj+En6DWXrClm5zqhBdxnFS3Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dko5QW
	q5+LPITLpgV7DmMzPp3x2Y3PgTIF/+EhoABdbLt6rRLMD82OI1b4fCPkt+VdLQRi
	i2u0yycr/+rDrMG5IMexRn9DkALsEOiRy/EsowF6H2YFGV2YfCx+xBvFO1XeJIH4
	6fgSx0RyooEnjCF2roZWS0D9Mvk4YzrPwlsjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC5A4EBD;
	Mon, 26 Sep 2011 13:50:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F5E14EBC; Mon, 26 Sep 2011
 13:50:01 -0400 (EDT)
In-Reply-To: <CACBZZX77ZhdS1cyiYpjJcuvSnJsv15FUumPWeZOcwh_b41c2FQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 26 Sep
 2011 14:47:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F508E1FC-E867-11E0-980A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182141>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Sep 24, 2011 at 01:41, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> Also the following public repositories all have a copy of the v1.7.7=
-rc3
>> tag and the master branch that the tag points at:
>
> The 1.7.7-rc* series still doesn't compile on older Red Hat machines
> because 4c1be38b4a236403a329187acb70591a7fd92150 hasn't been included
> in it.
>
> Could you please include that in the final 1.7.7? It would be a PITA
> to have to work around that.

I somehow got an impression from an other earlier thread that this only
affect ancient and abandoned releases of some distros.

Will merge. Thanks for prodding.
