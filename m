From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Mon, 30 Aug 2010 10:24:18 -0400
Message-ID: <AANLkTi=GUrnH87faWH8G0tD7_KAynVf_ig0KpQRwnsaE@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5Hh-0006er-O1
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729Ab0H3OYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:24:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36274 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab0H3OYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:24:20 -0400
Received: by bwz11 with SMTP id 11so3715827bwz.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wG02+yrLIWj/o5iLqE5JPQEEyR90vzTgFxzVWJ2S6i8=;
        b=OeK11Rfxw+xMbOqu9y1UMMnSNT5XsrjSNkvkgjVphD8EjMlOnmal6AyLl8gzdxWlTJ
         bqyIloCKEIhaMqDNzMZXD0aXJnbpwCZGOZVyUhBY0qQeUWNA8OvfsbZyAwR7xA3aQU/x
         QX6Mjokw1r8QfcGC++ohwNz4ct+J/txpwB8DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xD4jaCkbXGgIwfGSrBzl3lQWDvjzxqLuPmlqo9C3a+d4M2jFI65EIOJLUaYUTl+vgA
         Yz3gsASQxCtPAMFvU6CGiCW8kSipmLymKXx9pSFCpNHAjWCX6/7MP4ihbEAR+QkiGus+
         BcUJt+eAJF/FZnaKjdgQgIQhPm9SO/DHeNICs=
Received: by 10.204.45.213 with SMTP id g21mr3347602bkf.11.1283178258636; Mon,
 30 Aug 2010 07:24:18 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Mon, 30 Aug 2010 07:24:18 -0700 (PDT)
In-Reply-To: <20100830141602.GF2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154812>

On Mon, Aug 30, 2010 at 10:16 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Chris Patti wrote:
>
>> That's great, thanks! =C2=A0That gets me the file names. =C2=A0Now, =
how do I get
>> to the contents of each file?
>
> Why not "git diff --raw" (or its plumbing equivalent "git diff-tree")=
?
>

That is absolutely *perfect* sir, thank you very much! That gets me
the blobs I can 'git show' as well as the filenames so I can cherry
pick only PHP files to check.

-Chris
(P.S. Is there a canonical 'example Git hooks' location I could
publish this to when it's working? I think there's a dearth of this
kind of example for people out there right now)

--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
