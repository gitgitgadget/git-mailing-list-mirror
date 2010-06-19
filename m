From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Initialize variable to appease Sun Studio
Date: Fri, 18 Jun 2010 21:52:59 -0700
Message-ID: <7vvd9fwrmc.fsf@alter.siamese.dyndns.org>
References: <e0fbd6edc13d94a097e8e7e3649b9e669f9b4ee3.1268413246.git.trast@student.ethz.ch> <1276558805-26573-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 19 06:53:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPq3U-0004nS-V6
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 06:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab0FSExL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jun 2010 00:53:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0FSExK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jun 2010 00:53:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4470EBDD45;
	Sat, 19 Jun 2010 00:53:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pX3acpgtweQS
	wtooZOHDaEufyM8=; b=GRrhTuQEz2fEpoZKqXw1Mx2LgJaRE1chg7EtT2voPiju
	1I6BV++vAS335gn8EV1jH/RLEWyj49r2cncMSYaIYfhk6a5FURw+JCCgFzH9g36m
	zJNUMm656qAfTcI3OU8gnQ1MqLghpkOhmFdfhE1Yz76lb/kPO4x424tdzZA8KI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sTJ3Br
	G9HHTC1d1FoezEiLak+tYcqqiN3tcKvcjZ8LwDk3rhGCsOHUqgJpbZYpm+Aj6tjC
	O8jNo19MqXiYNp1QLjVLiw++fwe1cVhjjeVprAyCCYNHnj8ROboQ1FvTg29Xo3oB
	1FBWVnwo4YtMUrt+cWlJGbibIaMaZqNBXVciQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E92BDD44;
	Sat, 19 Jun 2010 00:53:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 345CABDD43; Sat, 19 Jun
 2010 00:53:01 -0400 (EDT)
In-Reply-To: <1276558805-26573-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 14 Jun
 2010 23\:40\:05 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C022DD4-7B5E-11DF-BEF8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149375>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Sun Studio 12 Update 1 thinks that *t could be uninitialized,
> ostensibly because it doesn't take rewrite_cmd into account in its
> static analysis.

Hmm, I am wondering if I should apply this or just tell you to fix your
compiler ;-)
