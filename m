From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 7/7] i18n: mark checkout plural warning for translation
Date: Wed, 13 Apr 2011 10:30:35 +0200
Message-ID: <BANLkTimPzYA7oYkUZ3vwefb2HAKEHW-w7w@mail.gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
	<1302464048-21806-8-git-send-email-avarab@gmail.com>
	<7vipukq6m0.fsf@alter.siamese.dyndns.org>
	<BANLkTimjYxz_7v8gyByjKX2Mf9vRzukWGw@mail.gmail.com>
	<7vzknvnq6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 10:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9vTV-0003QB-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 10:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab1DMIah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 04:30:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59441 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab1DMIag convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 04:30:36 -0400
Received: by fxm17 with SMTP id 17so284691fxm.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7PuTMfuhRtOWKbe1wJRIeSRTTmYxH439O1pfWfIRVz4=;
        b=odJJC3qStxHdBrmDNCc/gzWKB0muM9oAq0oAiSlFxWdeIxkknVtiva+5o23pL2xws2
         QHrOiM6jNFEni30T7sR/J+cCcjtsnPinExISZLFhuAZ8MUkv3NXjyeQPyWwPsFfiu0m1
         1bPV82FVjrzM5rilDPzsM7Jang9gmKQaxdMiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jb3P55nbc7FYFwJKfOE5BT6UiHLw2mfWPF428sn+/Pb5TIyUtfJOTDkubh6ZNrvb0g
         TNk6HBuIpZPJaC7tHMX5n3uYdU5ZsGY8uEuiPywHykiFqrz518PmVy1VHjJZ7kOHJc9v
         FXC6ITu3U5Sph22bH+yuc9HlK5ZcX35k4Nrac=
Received: by 10.223.54.219 with SMTP id r27mr743992fag.124.1302683435055; Wed,
 13 Apr 2011 01:30:35 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Wed, 13 Apr 2011 01:30:35 -0700 (PDT)
In-Reply-To: <7vzknvnq6o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171435>

On Tue, Apr 12, 2011 at 22:57, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Warning: you are leav=
ing %d commit behind, "
>>>> ...
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "If you want to k=
eep them by creating a new branch, "
>>>
>>> s/them/it/ as this is a singular case, no?
>>
>> I just used the message as-is, we were using that for the singular b=
efore.
>
> Heh, you cannot claim innocence in this case; it used to be "leaving =
%d
> commit(s) behind, ... if you want _them_", which was consistent with =
the
> earlier use of "commit(s)" ;-).

No, it was:

              "Warning: you are leaving %d commit%s behind, "
               [...]
               lost, ((1 < lost) ? "s" : "")

So it would be "commit" or "commits" depending on the value of the
"lost" variable.

Anyway I could re-submit this or you could fix it up, either is fine by=
 me.
