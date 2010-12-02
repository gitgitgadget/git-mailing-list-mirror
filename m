From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 18:30:03 +0100
Message-ID: <AANLkTim7kTYJwnMdOD10D1o11xH7yuZXz1ZvabFL9ujE@mail.gmail.com>
References: <20101202114003.GA26070@raven.wolf.lan>
	<AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
	<20101202161955.GB3962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POCz0-0005Cx-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466Ab0LBRaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 12:30:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61748 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0LBRaE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 12:30:04 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so1359307fxm.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 09:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AcAHFCnvdWniOAITs0LOVYFBxiCxMfxUqpBjY1/WYk0=;
        b=or8aasFXn9Mldn+1UmNw3UV/d7lmG36u8I+heXpFRjtcfRSv/w41YheNwciXUASLPC
         k0ntrHllQcdUPORwsiVHutBJq1Dbq3obWcxPi9ZFd5+4Kqc5pOoq5JleCRF+cTvSpCTA
         11vzn/Bw+8bAJdmZvwUarU34tMhSSlKGnceMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kQCqGcVsAtZiMiTMSxiPTepXw1lOQ0b6EUYmWztOLZAb9JBwxrD2pTO7kpIIWAXgvo
         /mxCfK+OYR2KMD7xRyIK+dxP3q11E34G83PDetXD1IHMFpOUVlGJ6IS58JUNtUMUSZ4S
         R5T5L65Eyivg65QESTazadgfa+yZ7TNys+z/M=
Received: by 10.223.74.15 with SMTP id s15mr884482faj.28.1291311003445; Thu,
 02 Dec 2010 09:30:03 -0800 (PST)
Received: by 10.223.74.207 with HTTP; Thu, 2 Dec 2010 09:30:03 -0800 (PST)
In-Reply-To: <20101202161955.GB3962@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162712>

On Thu, Dec 2, 2010 at 17:19, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
>
>>> I am trying to use perl's Git.pm module, but for some reason, it ke=
eps
>>> bailing out:
>>
>> Why are you using it? It's for internal use only.
>
> Where do you get that from? =C2=A0(Not sure whether it's true, just c=
urious.)

It, like our internal C is subject to change at any time. It's not
intended for external use.

>> Couldn't you use one of the Perl Git wrappers on the CPAN?
>
> This is still a reasonable suggestion, certainly.

Yes, it really is much better to use the CPAN modules that wrap
Git. We might even want to use them ourselves someday.
