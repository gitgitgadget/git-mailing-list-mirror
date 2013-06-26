From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/5] Reroll patches against v1.8.3.1
Date: Wed, 26 Jun 2013 07:24:54 -0700
Message-ID: <7v38s5ymo9.fsf@alter.siamese.dyndns.org>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
	<cover.1372149305.git.Alex.Crezoff@gmail.com>
	<7vppva2dod.fsf@alter.siamese.dyndns.org>
	<20130626073423.GA23688@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 16:25:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urqed-0004cH-82
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 16:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab3FZOY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 10:24:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab3FZOY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 10:24:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E78C42A5A5;
	Wed, 26 Jun 2013 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/4pTrfKgonGU
	i9xnYL2FkXUt3XM=; b=cO+FtH8J9rcfzafGFgoC5jvIEU9pfd3GX9ANTXiU/ZBB
	955LWFFMgEA1USue26t3cLSkfd482wNj1E/A8yyZcYaoJIC4fBKbTwpN3nBLcRey
	6UFrFXU4MQ3BS1Bpk/6pgosWintaIINTlSscrnz4tSbsRcFkDycSbU4YUD+SBFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PudGNs
	nOCxYZR16fjY1vW1IjljTa0JAQiFA/4GF+JR0lVjI17xIJuJD/WpJwmRRjch3kxg
	C1/6m8uYVn/K2bZPEMBnbRlSYQdwyXIYtzaxTwkCVO2azjmR3gD8SUorni0LLPZ7
	sUE5mrMhRjE1VPuPGq1pCo5g3SNVZuFeDr/qE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF16E2A5A4;
	Wed, 26 Jun 2013 14:24:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD2B32A5A3;
	Wed, 26 Jun 2013 14:24:55 +0000 (UTC)
In-Reply-To: <20130626073423.GA23688@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Wed, 26 Jun 2013 11:37:09 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C833C9E-DE6C-11E2-9D99-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229041>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> On Tue, Jun 25, 2013 at 12:28:02PM -0700, Junio C Hamano wrote:
> ...
> If someone can do the same with latin1, I'd be happy.
> ...
> But today I've taken a look to Cygwin's locales more closely and foun=
d
> out that I've used incorrect encoding name (`iso88595` instead of "ca=
nonic"
> `iso-8859-5` that Cygwin has and "understands")
>
> Nevertheless, as I've already said that is not a Russian locale speci=
fic
> issue.
> The problem in tests for me now is a language (that uses iso-8859-1
> encoding) I do not speak or even write ;)

Many of the people on thee list don't, either, and that is perfectly
OK.

=46or the purpose of the test, "=C3=A1=C3=AB=C3=AE=C3=B5=C3=B9" should =
be sufficient. In a
sense, using such an artificial string would make it even clearer
than a real message that what we are testing, no?
