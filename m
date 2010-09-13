From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] git-reset.txt: reset --soft is not a no-op
Date: Mon, 13 Sep 2010 16:19:57 -0700
Message-ID: <7v39tdb59e.fsf@alter.siamese.dyndns.org>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
 <f30121dda2c44d2a87f2d2bf651d6a0adfa8c955.1284365021.git.git@drmicha.warpmail.net> <AANLkTin1Ht+2Q4v5pyt8p11VmQ275C41rJLMLLuLkEfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 01:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvIJu-00029G-FI
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 01:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab0IMXUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 19:20:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab0IMXUK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 19:20:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 461FFD6432;
	Mon, 13 Sep 2010 19:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DH4utp40pImM
	Gxt+6HOysGgN77I=; b=ddLbfZ7xWQ74jgshwbGbgFBhyq0jhq7W8UM2nLG5uUfV
	8vF5U4pvrBgBAveRJRIUQPQqrdkLUoDo9eGXQkUT9Q1fIXnypKcMI1pT3rqkaUIg
	DK3rusKxjVnOqkxiGv91lr5oEpWziIE2QH0aRcngXdjokvC1NXA1+UFf+j1cSZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jwat3q
	81G3L8iGQaAxyO3Ry+FccQJBZ3BBcxdAFFS2IWvQnQNRK/GkDDc375jHzr05n8Dp
	kENVyg8qxbXsCaa2X2bVrTT984e3gL4pILSl8vQe+6+dZvbg/ZW4SOMLx4OuWuLp
	tHtibZxnKWNbepuq5Kd4MyNeQ2xoLwNzqJ9pQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3663D6430;
	Mon, 13 Sep 2010 19:20:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA1C7D642C; Mon, 13 Sep
 2010 19:19:58 -0400 (EDT)
In-Reply-To: <AANLkTin1Ht+2Q4v5pyt8p11VmQ275C41rJLMLLuLkEfA@mail.gmail.com>
 (Jay Soffian's message of "Mon\, 13 Sep 2010 18\:13\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70CF044C-BF8D-11DF-BB0A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156151>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Sep 13, 2010 at 4:06 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Make it clearer that git reset --soft actually does something (chang=
ing
>> HEAD). While it is meantioned in the previous paragraph already it c=
an
>> be easily overlooked otherwise.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> =C2=A0Documentation/git-reset.txt | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.t=
xt
>> index 8fb871c..65f5d07 100644
>> --- a/Documentation/git-reset.txt
>> +++ b/Documentation/git-reset.txt
>> @@ -43,7 +43,8 @@ linkgit:git-add[1]).
>> =C2=A0--
>> =C2=A0--soft::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Does not touch the index file nor the wor=
king tree at all, but
>> - =C2=A0 =C2=A0 =C2=A0 requires them to be in a good order. This lea=
ves all your changed
>> + =C2=A0 =C2=A0 =C2=A0 requires them to be in good order (and sets t=
he head to <commit>,
>> + =C2=A0 =C2=A0 =C2=A0 just like all modes do). This leaves all your=
 changed
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0files "Changes to be committed", as 'git =
status' would
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0put it.
>
> What does "requires them to be in good order" mean anyway?

Good point.  I don't think it means anything now; for that matter I do =
not
think it meant anything even back when that sentence was added in f6754=
5e
(Docs for git-reset-script., 2005-09-07).  A soft reset doesn't even lo=
ok
at the index nor the working tree, so there is no good nor bad order
there.

Just remove it.
