From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git's tests have depended on Perl since at least 2006
Date: Fri, 13 Aug 2010 22:56:50 +0000
Message-ID: <AANLkTi=FvAZZsxctJ-sXuQxsMgn15BhKooXjO13CVy6U@mail.gmail.com>
References: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
	<7v4oeyjfnw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:57:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok3BJ-0007Wl-4h
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab0HMW4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 18:56:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36248 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab0HMW4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 18:56:50 -0400
Received: by gwj17 with SMTP id 17so174037gwj.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=seiPEnR0Lnax7IIAm5fE6Mb7BmhlrQurMu/kkBBomw0=;
        b=rLftVKU70xHqjV4bNQ/naqKsKKBAPZ+YjNwkSUoZsCSkM7dXBy8zyZGuiJQEnnwJim
         gIcXmkp20ixqb6pIJDHdDniw+VEaxoQCiTrln5gAqD1W2+JvgQ3PoYxLN7IVhm/5riKI
         Nmmotjyjd1RkBLk/NFq0VVVFmbX7mwwfacnyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vGiqr4av/IMFkzt6R8bWAb6mwAUTuZEYs3vNDRYCYxe0AXFn5c6jjq3zswxlIQ8ksV
         GeoY5mhCLez9sXBKzWlp2V2KfDqvG0mpGHok/Qov8jPXYZJB3gdqRp2m14QD8o9qDoJB
         KQDwmIkcCBW+dt1iAj+M23sQwn7hdryqJuYAA=
Received: by 10.231.30.130 with SMTP id u2mr2440935ibc.111.1281740210121; Fri,
 13 Aug 2010 15:56:50 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 15:56:50 -0700 (PDT)
In-Reply-To: <7v4oeyjfnw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153524>

On Fri, Aug 13, 2010 at 22:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This is just an interesting datapoint, but Git's test suite currentl=
y
>> crashes and burns if you don't have a perl in your $PATH, no matter =
if
>> you've compiled with NO_PERL=3DYesPlease or not. This has been the c=
ase
>> since at least 2006, or v1.3.0-rc1~13^2~34.
>
> I'd suggest you not to go overboard on this. =C2=A0NO_PERL=3DYesPleas=
e is
> primarily about the deployment environment. =C2=A0The person who is b=
uilding
> and packaging git may have perl on her development box.

I promise not to go overboard :)

The aim of this and some recent patch serieses has been to improve our
smoker support. I'd like people to be able to run a smoker without a
perl without sending false positives in their smoke reports, that's
all.
