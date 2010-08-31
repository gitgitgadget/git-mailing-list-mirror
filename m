From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 05/17] gettext: make the simple parts of git-init
 localizable
Date: Tue, 31 Aug 2010 09:27:27 -0700
Message-ID: <7vk4n6d9xs.fsf@alter.siamese.dyndns.org>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-6-git-send-email-avarab@gmail.com>
 <20100831150301.GE2315@burratino>
 <AANLkTikd7mc4DjTVaKip_WFqVdezE13ZbL+Vmfqd8yCu@mail.gmail.com>
 <20100831154446.GJ2315@burratino>
 <AANLkTimPndcAu7RTnzpB0LZ1bHpFC5-QxNkPPAkoD5Hc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:27:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTga-0004XS-A3
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0HaQ1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 12:27:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab0HaQ1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:27:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5E41D2FFA;
	Tue, 31 Aug 2010 12:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JYesd3k3wg/+
	MC3dN+0bSXU12cs=; b=WONdV7ILlU54SSTPRqjUIaiVUh8jp+qz+enWfGgGp6/3
	8CPB2VoprnY4RTDqUm5K63A0BN+JaIlJC1b65z7ekwVTYS6hgbp9NV38c1ks+BZM
	B0QuxuWlcPvn5PCXyzjU7Ue+ji/gjoTaQT6p21ZVfYyl6TclTCr6WYJk+vTiH44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fk/ekf
	EDtL9xujfuCNt74E/K498r3YNg5fsQroBQWhq6RlH1eCrgQbTvyhnPBCPp99KDGK
	fyS/eXuq0Lz4x19sA4gsv271RzHzG+4bf3KR69jzb+9sgPf0fkGvW3jIhbHBCeVF
	5OIh+gVem2CxqRege32InhG1Muam1/GW8foI0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9501CD2FF9;
	Tue, 31 Aug 2010 12:27:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC32FD2FF5; Tue, 31 Aug
 2010 12:27:29 -0400 (EDT)
In-Reply-To: <AANLkTimPndcAu7RTnzpB0LZ1bHpFC5-QxNkPPAkoD5Hc@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 31 Aug
 2010 16\:05\:16 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9BC9C9A-B51C-11DF-82DA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154934>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe we should have die_plumbing() and die_porcelain() functions to
> indicate the nature of the message, although we could get the same
> thing with die() and die(_()) once I'm done.

To me, die() vs die(_()) feels like the lessor of two evils ;-).

Thanks.
