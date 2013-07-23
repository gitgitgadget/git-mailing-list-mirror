From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Tue, 23 Jul 2013 11:17:52 -0700
Message-ID: <7vd2q987jj.fsf@alter.siamese.dyndns.org>
References: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
	<7vsiz69qfh.fsf@alter.siamese.dyndns.org>
	<CAPM==H+_rpNojKjJe3-fJSXp0_8ishws=N7BsU7TJpfr2yG31A@mail.gmail.com>
	<7v7ggi9ned.fsf@alter.siamese.dyndns.org>
	<CAPM==HLi29bGXhOWdOg_pRc2Ks7ooXS-q8b05Lr8VnDknzKAoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Yamada Saburo <devil.tamachan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 20:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1h9u-0003td-Na
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 20:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537Ab3GWSR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 14:17:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933204Ab3GWSR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 14:17:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73CA2337E9;
	Tue, 23 Jul 2013 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0lgzY+ESEBGfKjgHOlm2o2zE5Q0=; b=gSomDO
	YWsccJEBCl/NbXW2XID72S6Qo6shau/0iUWC5cykhuMAtcdL3SHvyowXCvx+xWyP
	xp1SNGnHtolmApAjT3AFt8COr5O6rPziSX2Fx/eLpY1cYPrebt8ezeE4h0vvhuSz
	3hByMNiJG4Ebu0u9JKm6R08s/pgXk3MsU7M0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=na1WF1UHrzeqjmgtrlQyIX0FgFw0zOTG
	mRvbY2g5T2eSaoWcxSTsDllWZwPxdG59EAGFD8nFznPjmMEYJEm6L+6fAT1fDixR
	KQDuX+BaQdYIOBhv4i8/y/oYcCOFdj8fbpsn0kyRB7qbRXZMN8cS14rYs310k6Z/
	ccYjZHzuGgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62F1E337E8;
	Tue, 23 Jul 2013 18:17:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0769337E6;
	Tue, 23 Jul 2013 18:17:54 +0000 (UTC)
In-Reply-To: <CAPM==HLi29bGXhOWdOg_pRc2Ks7ooXS-q8b05Lr8VnDknzKAoQ@mail.gmail.com>
	(Yamada Saburo's message of "Tue, 23 Jul 2013 23:40:25 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31E64FA6-F3C4-11E2-9766-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231047>

Yamada Saburo <devil.tamachan@gmail.com> writes:

>>> -#: git-gui.sh:2893
>>> +#: git-gui.sh:2983 git-gui.sh:3115
>>> +msgid "Usage"
>>> +msgstr "使用状況"
>> Is this correct?  I am not familiar with the context this string
>> appears, but shouldn't it be "使い方"?
>
> It is a title of the error box which does not have seeing mostly.
> Therefore, I do not understand.
> However, If you wish, it can correct with you yourself another patch later.

Untranslated "Usage" may be understood many Japanese computer users,
but if that label is to show "How to Use", then "使用状況" (whose
literal back-translation is "Usage Status") is a label that makes
things worse, I think. Between this translation and leaving it
untranslated, we may even be better off with the latter.

As the objective of our discussion is to make git-gui's translated
messages better, I _will_ point out an iffy translation that may
make things worse.  It does not have anything to do with what I
wish.

>>> -#: lib/choose_repository.tcl:490
>>> +#: lib/choose_repository.tcl:489
>>>  msgid "Target Directory:"
>>> -msgstr "先ディレクトリ:"
>>> +msgstr "保存ディレクトリ:"
>> I think this is better translation than the original (the Target is
>> about where the new clone appears), but a few lines above we see
>> "Source Location", which may want to be reworded.  Perhaps
>> クローン元リポジトリ
>> クローン先リポジトリ
>> ???
>
> "保存ディレクトリ"(Save Directory) is better. "先ディレクトリ" is very bad.

I already said the original is bad, no?  Cloning to a new place is
different from "Save", and that is why I found that word "保存"
iffy.

>>In short, the translated text is far more alarming than the original
>>phrasing.
>
> Is free translation impossible?

What do you mean "free translation"?  Apparently you do not mean
"free" as in "free beer", as we are both doing these on our own
time, not as a paid task.

Do you mean "I can do whatever I, Yamada Saburo, wish to do?"

It almost appears to me that your position is that any words, as
long as they are written in Japanese, are better than leaving them
in English, even if they are misleading.  I do not think that helps
our users.

The list discussion is "somebody posts a patch, other people eyeball
and suggest improvements, and they collaborate to reach a good
result".  I am involved in the review of this patch not as the Git
maintainer but as somebody who happens to read Japanese, so as I
already said, what I wish does not matter much---what matters is
that the result does not make things worse than leaving them in the
original, untranslated.

I only commented on points in your patch that looked misleading to
those who only get the translated Japanese, without commenting on
others.
