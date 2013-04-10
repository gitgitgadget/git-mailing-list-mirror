From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] glossary: extend "detached HEAD" description
Date: Wed, 10 Apr 2013 12:35:25 -0700
Message-ID: <7vzjx6kwle.fsf@alter.siamese.dyndns.org>
References: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
 <5165623C.703@gmail.com> <7vfvyyo35x.fsf@alter.siamese.dyndns.org>
 <5165AF74.9060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:35:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0nu-0003Tr-0L
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934446Ab3DJTf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 15:35:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab3DJTf2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 15:35:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2E215E08;
	Wed, 10 Apr 2013 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0c/RAMkW9GbM
	35BNUTkBcupYXXk=; b=VDRC3p5tGWZWnrywE4ovGqBex583Eg9SVcfjr7+sa8v5
	6UIHKcDqejhFc4O8nbjBWpgw1Z6geEFLNj/L2x8V9LFvv6OSndboHMAHbBg5FZdT
	EjxMHZRBQoPVkuhFfTT45ivAfddCUm0ezTyDHNajuOv/LsBz38ldLLQkWvkR7SA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mk7U9V
	tLG0jbaNTuJppF154HCF+PeAlBT0NfO25hzVAAF5kX31xrnAS4WsgVVnaz7FH9k2
	+qsrGUtyWJfIXsNHzvF/EBYKrfaTWd21Zl2lks5HwhcXAo4MZ++pxO2kjivGlMKC
	Izm6AedL5uDQcT+Ii+kxgmKTw7zD9O7jWBOcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E47DE15E07;
	Wed, 10 Apr 2013 19:35:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2525F15E05; Wed, 10 Apr
 2013 19:35:27 +0000 (UTC)
In-Reply-To: <5165AF74.9060508@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Wed, 10 Apr 2013 20:29:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBCAA69A-A215-11E2-B597-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220735>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> P.S. From some StackOverflow questions the connection between "(no
> branch)" and detached HEAD is not clear for git newbies...

If _that_ is the problem you are really trying to address, the
output from recent Git already says "(detached from xxxxxx)" or
something, so I suspect there is nothing to fix in the glossary.  We
are exposing the word "detached" more to the UI, so that people who
do not know what it means can come to the glossary.

>>> Should we also add that "git branch" output shows this situation
>>> as "(no branch)"?

I guess "(no branch)" is no longer necessarily what we output from
there, so the updated description for "git branch" needs to be a bit
different from "the command says (no branch) when detached", but I
think it still is a good idea to mention what the user is expected
to see.

Thanks.
