From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: move rev-list option -<n> from git-log.txt to
 rev-list-options.txt
Date: Fri, 07 Sep 2012 10:14:52 -0700
Message-ID: <7vwr05yctv.fsf@alter.siamese.dyndns.org>
References: <1346941683-24832-1-git-send-email-pclouds@gmail.com>
 <5049B54F.7020301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:15:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA291-0008C3-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2IGRO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 13:14:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410Ab2IGROy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 13:14:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397047B17;
	Fri,  7 Sep 2012 13:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VRl2aRgFSJjv
	Wn+CU9If0Ahu+s8=; b=hftlGJ7SzAcoLt8DshQBRiiQekiPCK6FwI4LzjloIzZW
	OdDQgY17eYigsG+pQYAB8BLdkIhQYICXvbjOhElSiX3yAzIFOw64LgB1EtqMFwXa
	lvH3+z7yjI9KlAMw0R9W/S4OWr+7eZ3snQN89zCjBOf5FVdrwr1KdY2boOzFxpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vkA4cd
	j5Sn/qUd4ulB3Jb7ddnP5xi9x8G34eFCZMBF1RQU49XhMQEPbayJUVBYIPEdUFt2
	KBauFUKaMcGxN/yzp33Nryu06Oqay9KLvT4wGyvBiQ1gOhldfpYYDS1keEocIgIa
	ey6uMSONFgZY+Ax7j7/AsZ3SsihekD4I7OUSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270087B16;
	Fri,  7 Sep 2012 13:14:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 992197B15; Fri,  7 Sep 2012
 13:14:53 -0400 (EDT)
In-Reply-To: <5049B54F.7020301@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 07 Sep 2012 10:50:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A3476CA-F90F-11E1-BBF8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204979>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 06.09.2=
012 16:28:
>> rev-list-options.txt is included in git-rev-list.txt. This makes sur=
e
>> rev-list man page also shows that, and at one place, together with
>> equivalent options -n and --max-count.
>>=20
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Documentation/git-log.txt          | 6 ++----
>>  Documentation/rev-list-options.txt | 3 ++-
>>  2 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 4 =
=C4=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 5 b=E1=BB=8B x=C3=B3a(-)
>
> That is one reason why "core.local=3DC" (repo specific) and "git -c
> core.locale=3DC" (can be used in an alias) would be useful ;)

Or "LC_ALL=3DC LANG=3DC git format-patch ...".

It does not bother me (even though I do not read Vietnamese), but
this has been brought up a few times, and we may want to revert the
i18n of the diffstat summary.  It does not seem to add much value to
the system but annoys people.  After all, the "upstream" diffstat
does not localizes this string (I just checked diffstat-1.55 with
Jan 2012 timestamp).
