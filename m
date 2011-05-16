From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #04; Sun, 8)
Date: Mon, 16 May 2011 13:19:33 -0700
Message-ID: <7vk4dql7oq.fsf@alter.siamese.dyndns.org>
References: <7v8vugqvy3.fsf@alter.siamese.dyndns.org>
 <BANLkTimz5KpSC04gQkYL+oXJu5JfR8t8nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 22:19:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4Ge-0002P6-Ti
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab1EPUTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 16:19:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab1EPUTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 16:19:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B68635FD6;
	Mon, 16 May 2011 16:21:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o9RKtn4t/IaV
	HfFNTai/7e/ozv0=; b=QmzD05bmp/xoBuzuboaPvzIe3Uil03+oQ+gyQohOaACb
	RvkZUrklsxt2/aCutMZj6Xiows0kWO7B3UXfAhJaKd1Vv3KsL04sE+Mbnj8Wcy4f
	vaQiUvvJkEXlZ7O0HYTJMrYTnRGGAobPJXq6lNFvE2N1RNBePZGRL+HQV+dqOhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YAGIQV
	PBNVve0kvVmf9elbUcGO8/SPdFsL4UgqXSBCXtq5cwfPIgRmuwvSFrTnynjk3Hvi
	p1QRCFXd1r4sJOX1OduZhkpAqFmWE4F9gdE3h1UMvQL7ROfLnY25HRoxXYKBhjN9
	LnVXJfJEakMtQ+fplxndolPuP2WpXGCs2pLeY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 827C45FD3;
	Mon, 16 May 2011 16:21:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 64A7F5FD1; Mon, 16 May 2011
 16:21:42 -0400 (EDT)
In-Reply-To: <BANLkTimz5KpSC04gQkYL+oXJu5JfR8t8nw@mail.gmail.com> (Ciaran's
 message of "Mon, 9 May 2011 09:55:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F48C620-7FFA-11E0-B6A7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173755>

Ciaran <ciaranj@gmail.com> writes:

>> * jn/gitweb-js (2011-04-28) 13 commits
>> =C2=A0- gitweb: Make JavaScript ability to adjust timezones configur=
able
>> =C2=A0- gitweb.js: Add UI for selecting common timezone to display d=
ates
>> =C2=A0- gitweb: JavaScript ability to adjust time based on timezone
>> =C2=A0- gitweb: Unify the way long timestamp is displayed
>> =C2=A0- gitweb: Refactor generating of long dates into format_timest=
amp_html
>> =C2=A0- gitweb.js: Provide getElementsByClassName method (if it not =
exists)
>> =C2=A0- gitweb.js: Introduce code to handle cookies from JavaScript
>> =C2=A0- gitweb.js: Extract and improve datetime handling
>> =C2=A0- gitweb.js: Provide default values for padding in padLeftStr =
and padLeft
>> =C2=A0- gitweb.js: Update and improve comments in JavaScript files
>> =C2=A0- gitweb: Split JavaScript for maintability, combining on buil=
d
>> =C2=A0- Remove gitweb/gitweb.cgi and other legacy targets from main =
Makefile
>> =C2=A0- git-instaweb: Simplify build dependency on gitweb
>
> Sorry if this is dumb, as I'm unsure how Git (the mailing list)
> handles regression tracking, but I saw no mention of this thread:
> http://marc.info/?l=3Dgit&m=3D130445013906259&w=3D2

I did not recall any regression in gitweb JavaScript support topic
reported, so I was puzzled about the above quote.

I am aware of an issue around the merge-recursive area reported by you =
on
May 3rd (Message-ID: <BANLkTimcRbuYzSp+MM-vsvxoWhAS8Jvo8Q@mail.gmail.co=
m>,
$gmane/172617) [*1*]. I had an impression that the guilty party pointed=
 at
by the bisection was already looking into it.

Elijah, any progress on that one?


[Footnote]

*1* This is just my preference but I'd be happier if you gave the
Message-Id of the message; it would be easier to find the thread.  A
reference to marc.info to me means an extra "launch browser only to loo=
k
at it" and tends to be backburnered when I am busy (and I usually am).
