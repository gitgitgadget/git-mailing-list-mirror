From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 13/15] gettextize: git-revert messages using the "me" variable
Date: Tue, 7 Sep 2010 08:51:44 +0000
Message-ID: <AANLkTimTG1FbR988c6cQHQsQ4k6__HVVByt5O0g-pe67@mail.gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
	<1283775704-29440-14-git-send-email-avarab@gmail.com>
	<20100906185023.GE25426@burratino>
	<AANLkTi=8VXBFW7jzUe4EuCd+i221zRUt6LHGBYG8FQya@mail.gmail.com>
	<20100907053936.GS1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 10:51:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OstuA-0005dX-N8
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 10:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab0IGIvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 04:51:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60442 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0IGIvp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 04:51:45 -0400
Received: by iwn5 with SMTP id 5so5128804iwn.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bYfaBW6HDqxe37RH8Jfh4ayuEnUHfZfi2Dur5SsGq+s=;
        b=MW4/alBqYxji17B6gKFHnHUQNuXkIQ53WQzIo+D5zrpe4pQ+EG4YirzdmfBC8u2Iue
         PfxwxxMk20R97NS2QTtjS5AqPiM7OuFoCgO/efX7Fh7sGRWMS9gejcSAO9Hu4wL6D0Zc
         AyB01Zs1uxBdbp5slBQ4A3LpESVO/Ae0Pyc8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C95z2k7vKEoa3ebCxfYNxXmzqwQ5/uSa+Tg17E4MIVFAKLQ+mzApQFfT6ws6rtx3mu
         tDYeALO8aQnm+A/T3i8aTc+uaU+VTlELkDO6thpcE6UvX9W+S61L96VkE3i2KKY8r/nn
         UhAInwdnKO9SveEllImLTUDJ44eSv1TAUssy4=
Received: by 10.231.171.18 with SMTP id f18mr7718516ibz.9.1283849504775; Tue,
 07 Sep 2010 01:51:44 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 7 Sep 2010 01:51:44 -0700 (PDT)
In-Reply-To: <20100907053936.GS1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155689>

On Tue, Sep 7, 2010 at 05:39, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Sep 6, 2010 at 18:50, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>>> Not good, in my opinion. =C2=A0The dialogue ought to look like this=
, I think:
>>>
>>> =C2=A0$ git cherry-pick astermay
>>> =C2=A0...
>>> =C2=A0fatal: cherry-pick: Unableway otay itewray ewnay indexway ile=
fay
> [...]
>> I don't know if all of the above hold true, e.g. because some
>> languages will always transliterate things, even proper nouns.
>>
>> But as mentioned before the string is probably being used in too man=
y
>> different contexts for it to be useful to them.
>
> Hmm, okay. =C2=A0Do you mean languages like Japanese or something els=
e? =C2=A0At
> any rate, I guess you are right that this is too complicated for the
> moment.

The languages here that translate "Wikipedia" differently than
"Wikipedia" are a pretty good indicator:

    http://meta.wikimedia.org/wiki/User:Waldir/Logos_and_slogans
