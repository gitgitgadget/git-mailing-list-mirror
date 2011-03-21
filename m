From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Meaning of double + and - in Gitk's diff pane
Date: Mon, 21 Mar 2011 12:49:26 -0700
Message-ID: <7vaagop83d.fsf@alter.siamese.dyndns.org>
References: <4D879B25.9090300@dirk.my1.cc>
 <7vr5a0p8n1.fsf@alter.siamese.dyndns.org> <4D87AAD6.6000704@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:49:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1l6j-0000MT-Ap
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab1CUTth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:49:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196Ab1CUTtg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 15:49:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79E6D4369;
	Mon, 21 Mar 2011 15:51:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BkEMrl5kw8Zm
	d3T2dp2P81alYC8=; b=UnNXq9X39N6RZYf1t9PIID9JukkOHhDphN9P5920BuEG
	HYp9X7AukAhvx25HXJZeoEcbtau20cPu8wKQswaSHzyUY9W/A8cZ2ecWpjLdr8xU
	9g309YW/cS4Ny8dLGCa/yaXfFeH4XmFEZReFz0KIUG47ITjj0RfhRprKSx984vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C832fQ
	3d5wXKwuRNIYKlgg2ukxbVl3y/wAXOm9a6uCbtc032zmgauK3iodyeJmIdeB4uwJ
	x6cEdqVcuVztiDp+uWAdip5SYbk4UVOdWM5buowMUKypRkiBWcI3C5FDIic890Y9
	TstXo5H3DRAsu2WMaygQmILQvvOD4PWNed+LU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 589004368;
	Mon, 21 Mar 2011 15:51:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 220DF4367; Mon, 21 Mar 2011
 15:51:06 -0400 (EDT)
In-Reply-To: <4D87AAD6.6000704@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Mon, 21 Mar 2011 20:45:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92E603E0-53F4-11E0-8B0C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169654>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> Am 21.03.2011 20:37 schrieb Junio C Hamano:
>> Dirk S=C3=BCsserott<newsletter@dirk.my1.cc>  writes:
>>
>>> I regularly use gitk to get an overview. Great tool.
>>> But sometimes it shows me in the diff pane lines preceeded
>>> with two + or - signs or they are colored in blue or black
>>> or printed in bold. I think this is true for merge commits
>>> with conflicts.
>>
>> Look at the bottom summary of this message for a brief summary:
>>
>>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focu=
s=3D15527
>>
>> If you want to know more about how the multi-way diff is condensed, =
you
>> would find this message from Linus in the same thread illuminating:
>>
>>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focu=
s=3D15600
>>
>> (Ignore the bottom part where Linus complains about gitk output---th=
e old
>> implementation in gitk has gone long time ago).
>>
>> And also this one, again from Linus:
>>
>>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focu=
s=3D15491
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Junio, thanks. When I've found the time, I'll probably condense Linus=
'
> explanations and submit a documentation patch. It's not explained
> in the actual git docs, right?

How about checking "git diff"?  The same conclusion should be in there,=
 as
I wrote the implementation, docs and the messages there.
