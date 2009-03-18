From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch and pull
Date: Wed, 18 Mar 2009 02:37:30 -0700
Message-ID: <7v1vsvi339.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
 <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com>
 <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com>
 <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com>
 <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com>
 <20090318063103.6117@nanako3.lavabit.com>
 <20090318085849.GA8118@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjsFI-0007Dt-F3
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 10:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbZCRJho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbZCRJhn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 05:37:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829AbZCRJhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 05:37:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E08E9A297D;
	Wed, 18 Mar 2009 05:37:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2FB24A297C; Wed,
 18 Mar 2009 05:37:32 -0400 (EDT)
In-Reply-To: <20090318085849.GA8118@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 18 Mar 2009 09:58:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B90485A-13A0-11DE-A84C-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113602>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> 1) You do "git pull git://host/repo.git" or similar, i.e. you don't u=
se
> a remote. Because then, no refspec is given to fetch, and it defaults=
 to
> fetching HEAD.
> ...
> 1) probably isn't that common for most users, and even if, it's not
> one of the commands given as examples to which the paragraph applies.

I think "a maintainer responds to a pull request" is the only case that
happens often in practice for a fetch+merge of HEAD from a remote
repository.

Even in that case, we strongly encourage people to say not just "which
repository location" but also "which branch", i.e.

	Linus, please pull from:

		git://git.or.cz/alt-git.git for-linus

	to obtain the following commits.

When Linus cuts and pastes that to his shell, the command will become:

	$ git pull git://git.or.cz/alt-git.git for-linus

and HEAD is not involved in such a use case.
