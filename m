From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 15:08:39 -0800
Message-ID: <7v38xkvrbc.fsf@alter.siamese.dyndns.org>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
 <20130128205834.GC7759@google.com> <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
 <20130128221026.GE7759@google.com> <7v7gmxuekl.fsf@alter.siamese.dyndns.org>
 <CAJjU7bQtgaV1XBeeGnuwtz8m3bDtmRYxQE-QasWkoGHNb_NPjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?iso-2022-jp?B?GyRCJyEnXydVJ2InVidbGyhCIBskQiciJ1EnYidRJ18nYCdTGyhC?= 
	<admin@andrej-andb.ru>
X-From: git-owner@vger.kernel.org Tue Jan 29 00:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzxp3-00082s-3N
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 00:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab3A1XIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 18:08:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab3A1XIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 18:08:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E83E4C083;
	Mon, 28 Jan 2013 18:08:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d43g+Eku6LAAnwU3ra97/xAy+G0=; b=shuYsk
	BTg4fkjiOWx8+Dlrr/XrJj/ahRvgD57A3oNyfX7PhkNaP1iJfKtVKc1DrDHaHcwU
	TvKTCfqaZTj/ZLhSCO+jQCnLYEZ0xYpNGjSylKOHAyMu1FptAj6AZvCUstBiGJV+
	1qDJh2KfuylvSCfjLsXXqG3dT1n9xE9k4PCMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w2Sv+vKeizfGEzIiIwGJpqugkpsVgjDj
	fG2lOfanOGsbcjjuBML8upumMsE74v07GiBv10FvApWfn1+elTHo+3C4PZYIILhI
	W9sg8NPDcslGv0fLmwIwnZws1MoTIM1OQtfLyfYaM/yXiSWK03gsJVqLViwa7VXY
	MZNZ9UBsyjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCF1CC082;
	Mon, 28 Jan 2013 18:08:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 665B3C081; Mon, 28 Jan 2013
 18:08:41 -0500 (EST)
In-Reply-To: <CAJjU7bQtgaV1XBeeGnuwtz8m3bDtmRYxQE-QasWkoGHNb_NPjQ@mail.gmail.com>
 (=?iso-2022-jp?B?IhskQichJ18nVSdiJ1YnWxsoQiAbJEInIidRJ2InUSdfJ2AnUxsoQiIn?=
 =?iso-2022-jp?B?cw==?= message of "Tue, 29 Jan 2013 05:33:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A806E1D2-699F-11E2-820A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214885>

Андрей Баранов  <admin@andrej-andb.ru> writes:

> Or maybe option like:
> /etc/gitweb.conf:
> $feature{'ssl'}{'default'} = ['allways']; ['auto']; ['none'];
>
> but it's hard for me :) i don't know perl

The effect is the same and your original patch is shorter and
cleaner to see what is going on; as far as the patch text is
concerned, the original one is just fine.

Except that we wanted a bit more stuff before "---" line.  How about
something like this?

        Subject: [PATCH] gitweb: refer to picon/gravatar images over the same scheme

        The images from picon and gravatar are always used over
        http://, and browsers give mixed contents warning when
        gitweb is served over https://.

        Just drop the scheme: part from the URL, so that these
        external sites are accessed over https:// in such a case.

        Signed-off-by: Your Name <your@addre.ss>
        ---
         gitweb/gitweb.perl | 4 ++--
         1 file changed, 2 insertions(+), 2 deletions(-)

        diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
	...
