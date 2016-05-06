From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Fri, 06 May 2016 13:51:09 -0700
Message-ID: <xmqq8tzm3o76.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<CACBZZX5ssO2EiuxR7wotGowMaPhtioaJVSDpQDUwUkv1rLJJWw@mail.gmail.com>
	<CAFZEwPPkBcdupLktJ=ystnx_1y7Mv+U436Jn9JBUCrvkt+t8tQ@mail.gmail.com>
	<CACBZZX6XThQ9Ns4YMd_jC2jmNHhWg7QgXsn9_Ejy_8itToJQug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aymiS-0002gR-VW
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbcEFUvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 16:51:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758809AbcEFUvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 16:51:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B75B718EB3;
	Fri,  6 May 2016 16:51:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=liK2F6wd8Snc
	C1U5nGLoW8Z07zw=; b=Iml+RQWripR3C6cno/qKR+o0Ag8UoDbkJugmSWNfPdco
	Jj9jU37L/PIwgEcWpp24CPnwB9BAz2Xf2iMBI0SghZ6JWURKtrL9Sh3Pm925cmaF
	j5YtnHmcbMzvyVK1Y8k4vCtyCCQ4LaweunMGjVK03uLook7D4Vr8Vo9gpN0VhOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wDhYsy
	cR/hgpoB9M8k/BpNiHJh9FIuZo2sSUpbxVRzaa51a246BiCc2CY2XPlk1VAsaplW
	zFqqpRoCEXuO28l7ItRfpf5cGWr7q+l5wIF1JkPJPtXlsd00kd0JX6kj2HbU/Emy
	prroNrJNVh0Ua7gqqdLKncETs/7LNuFuCUWVo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE46118EB2;
	Fri,  6 May 2016 16:51:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3500518EAE;
	Fri,  6 May 2016 16:51:11 -0400 (EDT)
In-Reply-To: <CACBZZX6XThQ9Ns4YMd_jC2jmNHhWg7QgXsn9_Ejy_8itToJQug@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 6 May
 2016 21:47:42
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43C02226-13CC-11E6-B63B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293860>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, May 6, 2016 at 6:16 PM, Pranit Bauva <pranit.bauva@gmail.com>=
 wrote:
>> [+cc:git@vger.kernel.org] Because its an interesting fact to be shar=
ed
>> which isn't covered elsewhere.
>>
>> On Fri, May 6, 2016 at 2:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
>> <avarab@gmail.com> wrote:
>>> Sending this privately since it's probably covered elsewhere. With
>>> this, if I set the option will "reword" in git rebase -i show me th=
e
>>> patch?
>>>
>>> If so: awesome.
>>
>> Yes, git rebase -i will show the diff in 'reword' if commit.verbose =
is
>> set to true or a value greater than 0.
>>
>> I dug further in git-rebase--interactive.sh
>> I could find appearances of "git commit --amend" but I was unable to
>> find appearances of "COMMIT_EDITMSG". If COMMIT_EDITMSG was coming
>> into picture, the commit.verbose could not affect it. And that is no=
t
>> the case.
>>
>> I guess this would be a desirable trait for most of the consumers of
>> commit.verbose (like =C3=86var) so there would not be a need to supp=
ress.
>
> Yeah it's great, it's something I've wanted from interactive rebase
> for a while now.

I can see why "commit -v" may be useful during "rebase -i", but we
should also have rebase.verbose and "rebase -v".  I do not want to
make all my commits with -v, and I suspect I want to do "commit -v"
more often during "rebase -i" than regular commit, for example.
