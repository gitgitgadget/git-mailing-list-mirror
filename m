From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 14:40:33 -0700
Message-ID: <7vvcxajpda.fsf@alter.siamese.dyndns.org>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
 <7vboz2l6h1.fsf@alter.siamese.dyndns.org>
 <7v62pal5v7.fsf@alter.siamese.dyndns.org>
 <BANLkTimuA6-jLAUAMuhVf6FfJ2eNp8ROZw@mail.gmail.com>
 <20110516212641.GB15150@elie>
 <BANLkTi=FLWFzMFG5DgQiaN9kYW3pozJ6HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5X5-0003ja-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 23:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab1EPVkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 17:40:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab1EPVkr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 17:40:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 798B44ABE;
	Mon, 16 May 2011 17:42:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yFkr1nwMF78/
	wEn31LrggWFRGrU=; b=nyJw3gl3i85pAWsKnSaLan5FbxmrbwiBplTl2QAL+GDo
	1p3xTZozVyOb5i+qmiCw8VY+sJC/8ssqcjiWGV0ji4hLa2JwptR90KbZjwT3tnp7
	FTsWByLpLx0MhDnoh0Av8lRV3psvu8vpqk5jAfWfv3eBwJhgDL/2vpCh/A0jBWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=At77sS
	9yFbWJPHfTK4++khY/a9BnVaH8awzEqiInhF7W7rprmNQm+4qXeveKy/3KFuP4zI
	9b/gZvwodesYaqG6RlT5FHzu43X6QzNM47nOE7+Bl6EX78314b9Y+kkfMmdQ1Cey
	GbXpZ3U5sK09Kh5A4jr65i2U+/EQ6nGSp2cmI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 349444ABB;
	Mon, 16 May 2011 17:42:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A76A4AB8; Mon, 16 May 2011
 17:42:42 -0400 (EDT)
In-Reply-To: <BANLkTi=FLWFzMFG5DgQiaN9kYW3pozJ6HQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 16 May
 2011 23:32:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71A71C36-8005-11E0-8484-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173765>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, May 16, 2011 at 23:26, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> That would require us to start extracting strings from all "say"
>>> functions. The reason we have only "gettext" and "eval_gettext" is =
so
>>> xgettext can extract them.
>>
>> Isn't that what the xgettext -k parameter is for?
>
> I'm not saying we can't use xgettext to extract these things. I'm
> saying I don't think it's a good idea.
>
>     $ git --no-pager grep say git-submodule.sh
>     git-submodule.sh:                       say "$(eval_gettext
> "Entering '\$prefix\$path'")"

Oh, I didn't mean to say "we _must_ call that _say_".

The discussion suggested to me that we may want two variants, one that
takes an incomplete single line and outputs a single complete line, and
the other that takes whatever the caller gives and outputs the translat=
ed
lines without further butchering the tail end.  I missed that Jonathan
already mentioned gettext_nl and that is fine as well, but if we use a
function other than gettext I thought it would be better to use short a=
nd
sweet name for common cases.
