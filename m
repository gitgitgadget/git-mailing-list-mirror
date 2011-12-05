From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Roadmap for 1.7.9
Date: Mon, 05 Dec 2011 14:47:00 -0800
Message-ID: <7vr50ik55n.fsf@alter.siamese.dyndns.org>
References: <7vd3c2lr36.fsf@alter.siamese.dyndns.org>
 <CACBZZX6aC-E4DxaZzzhfGnK8ovBGCq_gNG3hPU7QjfAiNb3WrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXhJo-0007PT-7x
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 23:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1LEWrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 17:47:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab1LEWrC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 17:47:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3486EFB;
	Mon,  5 Dec 2011 17:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0gE1gxuren8F
	W1HFiWlC1us5iSE=; b=GoTmJfIFtDi0nBHeMyFwp+HVwn4EfNEAJ3tDRTqQKTMQ
	9APjDl5OAwlb1TVKAEFRSTuLXx11TN1rQw5BA4iKNeli/6Hb58TsE0DgkCMLlWVD
	qW9KHQh6MrP+IcPPh2uGwKr2o94MACVyKHNo9s1mAfG4WTcwlB40xa3HpMVYmAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZVPMa2
	KURbYU7ey7JeL62LscqmAnMlBm96yitguvGXX6Pdk6sILGb97Hxq/E6MqVh2+A2X
	fmdBpqb7ZRUjyUacg1o8t4tJwurwKrgtZJ3WDo0AQ90d/8yN1w63ZGpatTQ1369x
	uUQvYPsZQky/p8fWx1+xo4OgTMWsZMs0dah+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 027636EFA;
	Mon,  5 Dec 2011 17:47:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D33C6EF9; Mon,  5 Dec 2011
 17:47:01 -0500 (EST)
In-Reply-To: <CACBZZX6aC-E4DxaZzzhfGnK8ovBGCq_gNG3hPU7QjfAiNb3WrA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 5 Dec
 2011 22:24:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BC445AA-1F93-11E1-BB30-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186298>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Dec 5, 2011 at 21:07, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
>> Now, here are the biggies that we would want to try to have in reaso=
nable
>> shape before the next release.
>
> I'd like to get the i18n series into 1.7.9 as well. I think it's read=
y
> as-is but some minor issues are sure to arise.

Surely.

My impression was that the part that can have interactions with the
existing codebase is already in, and it is just the matter of updating
what _() ans Q_() actually do, which can be reverted out quickly if it
turns out to be necessary, and that was why I didn't count it as part o=
f
the "biggies" that make us worry.
