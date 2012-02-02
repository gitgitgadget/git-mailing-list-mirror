From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Wed, 01 Feb 2012 20:56:18 -0800
Message-ID: <7vmx91ygst.fsf@alter.siamese.dyndns.org>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
 <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
 <201202020111.33772.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Frederik Schwarzer <schwarzerf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 05:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsoih-0001C1-JY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 05:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab2BBE4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 23:56:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276Ab2BBE4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 23:56:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86C2C65CA;
	Wed,  1 Feb 2012 23:56:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Jt8a8jvRG7RH
	HjA1b9Jl+1UFbgg=; b=F4b3Y7PWNIudj4peGkr5QkzgVEKwIg1x4uaKp6Q2SN5v
	PFuQc0Lxvr2R5M42cE6a8sMGF1UNzrl7Y3aPrC2H8wpOIgpPIbp/DlPdRGZ8xD1V
	21QoT9FJB6x5L8KCWenmNtrBt38rjcBlWG6nYJnqgK6R9SHMyF82LwnD4EMMH7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FNtOXg
	SdzDpajh7z2HKKnUe+deIkiz35dyb+4/Hf65VrrumryPGDBh34j2wSXuC1XLmKyp
	3CyFumllY9Na1dWVqGRWbKrx/Y7ytoHUqBWcChrNoSw1B3d3rd2JoMWxDgxdJI1a
	/yPzAB5KmgOhNACTWi75JO754g8SJFgbN8FuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F98F65C9;
	Wed,  1 Feb 2012 23:56:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0DD065C8; Wed,  1 Feb 2012
 23:56:19 -0500 (EST)
In-Reply-To: <201202020111.33772.schwarzerf@gmail.com> (Frederik Schwarzer's
 message of "Thu, 2 Feb 2012 01:11:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F20873E-4D5A-11E1-8D1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189584>

=46rederik Schwarzer <schwarzerf@gmail.com> writes:

Administrivia:

	Kicked back to the mailing list so that Jiang and =C3=86var have a
        chance to join the discussion.

>> [Footnote]
>>=20
>> *1* Ah, another thing, shouldn't the title be labelled as l10n
>> instead of i18n?
>
> l10n if translations are sent, i18n if patches to improve translation=
=20
> support in the sources are sent.

Yes, that was what I was getting at.

> But maybe a separate mailing list=20
> might be a good idea. So people interested could be subscribed there=20
> without being overwhelmed by the amount of mails in here.

I personally do not think git-l10n warrants a full mailing list dedicat=
ed
to it (but see (4) below).

Earlier I said:

> I haven't decided what to do with this, though.  If we are going to g=
et
> tons of l10n patches[*1*], it may make sense to have a separate clone=
 of
> git.git, with possibly a maintainer other than myself, forked at v1.7=
=2E9
> and updates _only_ files in po/ hierarchy.

I actually was hoping to see somebody to step up and volunteer to be th=
e
l10n coordinator (see git-gui/po/README, which calls this person "the
internationalization coordinator", for the responsibility of this role)=
=2E

I would envision that the workflow would go like this:

 (1) The l10n coordinator makes a fork of "git.git", and start his hist=
ory
     at v1.7.9.  Let's call this the "git-po" repository.

 (2) The l10n coordinator prepares po/git.pot and makes a commit in
     "git-po" repository. It is l10n coordinator's responsibility to
     maintain this file.

 (3) There will be one l10n team for each supported locale. Jiang might
     volunteer to be the team leader for zh_CN.  Each team leader forks
     the git-po repository.  Let's call this the "git-po-zh_CN" reposit=
ory
     (there will hopefully be more, like "git-po-is", "git-po-pt_BR",
     etc.)

 (4) Members of each locale team work to advance their "git-po-$locale"
     history. They make changes ONLY to po/$locale.po file and NOTHING
     ELSE. Specifically, locale teams are NOT expected to touch po/git.=
pot
     or any source files in their "git-po-$locale" repository.

     How the members in a locale team coordinate their work is up to th=
e
     team. A large team might want to have their own mailing list, and =
I
     wouldn't stop it.

 (5) From time to time, each locale team asks the l10n coordinator to p=
ull
     from their history, and the l10n coordinator will pull updated
     translations. Optionally, the locale team may want to clean up the=
ir
     history before asking the l10n coordinator to pull their work.

 (6) From time to time, the l10n coordinator will pull from "git.git" w=
hen
     meaningful number of changes are made to the translatable strings.=
  I
     hope this would happen much less often than once per week, prefera=
bly
     much less frequently. The l10n coordinator updates po/git.pot and
     makes a commit, and notifies the l10n teams.

 (7) The l10n teams will pull from "git-po" to get the updated po/git.p=
ot
     file and will work on updating their "git-po-$locale" repository (=
go
     back to step (4) above).

 (8) From time to time, the l10n coordinator will ask me to pull from
     "git-po" repository.

One possible mechanism to use might be to host all of these at GitHub, =
to
leverage their service for all the "forking" and "requesting pull" abov=
e,
as well as intra-team communication.

And i18n patches that modify the _() markings in the source code, will
only go through "git.git" tree in the normal channel, IOW, this mailing
list.
