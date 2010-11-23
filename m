From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 19:40:57 +0700
Message-ID: <AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VGFyZWsgWmlhZMOp?= <ziade.tarek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 13:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsC2-0001Ey-SQ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0KWMlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 07:41:32 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63383 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0KWMla convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 07:41:30 -0500
Received: by wwa36 with SMTP id 36so8630994wwa.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=km1iPuiT6MgeSgEZRczhkj7+7YPyuLOTiqWJi4UBKSw=;
        b=kkTb4SuYx0pBrMLp1CiNghcOFGRXyF4dotHVQ9Wk5NxedZvGffWnkU8KIlTn+BkCfO
         hoJEnNbk3eFkWnubnud1ntAwhGOXNazjiVtWAxI7QHRfyLCfxxdoe1tSpMWf/598cB58
         kAqbYMxMeipP5388zLUrk6dOeb/UgpJEi49uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WzZwZwTA4VNIboDsCpq1LXik/THKpkQ9YIUmb+/m5ByZM8YUm8fCR59kgGaQpMece6
         bdtrd5LZESYXeb2jeCi47/Dc8t21kFhyEYnq+nDC21+/2KU+Q4s1GqrUSdDyj7agcV41
         WcrkhYxz/YpucFNAtGFol/YWiEo86CANlBhDo=
Received: by 10.216.47.19 with SMTP id s19mr920837web.56.1290516087859; Tue,
 23 Nov 2010 04:41:27 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 23 Nov 2010 04:40:57 -0800 (PST)
In-Reply-To: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161950>

On Tue, Nov 23, 2010 at 7:23 PM, Tarek Ziad=C3=A9 <ziade.tarek@gmail.co=
m> wrote:
> Hello,
>
> I am new to Git and I tried to run "git st"
>
> I have found one small bug: "status" is not listed in the help screen
> Git displays in that case.
>
> $ git st
> git: 'st' is not a git command. See 'git --help'.
>
> Did you mean one of these?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reset
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stage
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stash

It's heuristics, based on the assumption that you mistype a command by
a letter or two. It gives helpful suggestions most of the time, but
you can't expect it to be always right, especially when "st" is not a
mistyping. "git --help" does show "status" though so I guess it's ok.
--=20
Duy
