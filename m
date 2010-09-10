From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/15] gettextize: git-revert messages using the "me"
 variable
Date: Thu, 09 Sep 2010 17:26:12 -0700
Message-ID: <7vsk1ijvff.fsf@alter.siamese.dyndns.org>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-14-git-send-email-avarab@gmail.com>
 <20100906185023.GE25426@burratino>
 <AANLkTi=8VXBFW7jzUe4EuCd+i221zRUt6LHGBYG8FQya@mail.gmail.com>
 <20100907053936.GS1182@burratino>
 <AANLkTimTG1FbR988c6cQHQsQ4k6__HVVByt5O0g-pe67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 02:26:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtrRr-0006Ua-JR
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 02:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab0IJA03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 20:26:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab0IJA02 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 20:26:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B46CBD4791;
	Thu,  9 Sep 2010 20:26:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=AB4OxSptK75uu36ChnYz0pIwu
	qU=; b=itCzHJ/WKkEhAZO1LFDHcdSA4rbzIREZn4bN5TrkIyoqDCyFwrvpqwy69
	REye1Sr7glTlUlaCTaIlhL/PFDqQPTeD9CB28WuvNda05ASpboSbL8P/Jg7fWgdQ
	ue/igzSuswsWwUh2RAkGKKcZDgRvSbM8d61ZRT1Dq8fy+69Qpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=DHElITa2i9yKfofy2Gi
	f5uX/WWatYrKeINiOBDUaa45dg12ZmzD1hfGbzjBVa3FcrXn0WdMrSzSltEhc1di
	NtfzRcGfCz6Iiw1ADjI7IQmrErOURwQJmfmSKa+CPevGZ9KcnyR6jn36PU3OAdxr
	uzYQ2d+QlCO4/Jpo2fkemihc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54DEBD477A;
	Thu,  9 Sep 2010 20:26:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EC11D4778; Thu,  9 Sep
 2010 20:26:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 09541A64-BC72-11DF-A67C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155916>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 7, 2010 at 05:39, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> On Mon, Sep 6, 2010 at 18:50, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>
>>>> Not good, in my opinion.  The dialogue ought to look like this, I =
think:
>>>>
>>>>  $ git cherry-pick astermay
>>>>  ...
>>>>  fatal: cherry-pick: Unableway otay itewray ewnay indexway ilefay
>> [...]
>>> I don't know if all of the above hold true, e.g. because some
>>> languages will always transliterate things, even proper nouns.
>>>
>>> But as mentioned before the string is probably being used in too ma=
ny
>>> different contexts for it to be useful to them.
>>
>> Hmm, okay.  Do you mean languages like Japanese or something else?  =
At
>> any rate, I guess you are right that this is too complicated for the
>> moment.
>
> The languages here that translate "Wikipedia" differently than
> "Wikipedia" are a pretty good indicator:
>
>     http://meta.wikimedia.org/wiki/User:Waldir/Logos_and_slogans

I don't think so, unless you are translating the git subcommand names.

If your translated git lets/forces you to say

  $  git ckcherry-piay astermay

then that is a different story.  It might be very reasonable to transla=
te
the "fatal:" message to

    alfatay: ckcherry-piay: Unableway otay itewray ewnay indexway ilefa=
y

and it probably becomes a fair comparison with the wikipedia situation,
but otherwise no.
