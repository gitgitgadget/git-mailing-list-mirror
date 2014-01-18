From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Want to do some cleanups in this round of l10n
Date: Sat, 18 Jan 2014 19:59:46 +0800
Message-ID: <CANYiYbG-_S1d+dE03K-q5JOn4So7Ory7R+osz284=JGnd-ZC0A@mail.gmail.com>
References: <CANYiYbFJFaM=RgoSv1H8_av-D4e40c0viEXPBokGRvYNjjFhzg@mail.gmail.com>
	<1390044238.17519.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?KOI8-R?B?QWxleGFuZGVyIFNob3BvdiAo4czFy9PBzsTf0iD7z9DP1yk=?= 
	<lists@kambanaria.org>
X-From: git-owner@vger.kernel.org Sat Jan 18 12:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4UZ6-0000AD-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 12:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbaARL7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jan 2014 06:59:49 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:39069 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbaARL7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 06:59:48 -0500
Received: by mail-wi0-f175.google.com with SMTP id hr1so1714150wib.14
        for <git@vger.kernel.org>; Sat, 18 Jan 2014 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wPiHMkBa/oPHwaj/zJnqjVCZImFPWgXYZ7Z6CLxfghc=;
        b=YsTnGDqP/KPkh/CRRcoT3MOVQGxatvIx1uUtpBFbC1txPrZL/8ae8vaaVeuDUbc615
         jvE3RwvmeW5LSq3XR13TRsMAgdv0QSsWAkCSAwpowwhiyq6eLKpNkI5BsbUFwflbZWkC
         5REs3XZYWoZpjN7jA/WP4voG5+VrN2Hx83uH06tbgI10e+kiWL345z/4f2tFDrrfYlNz
         /jXZhTnWNRWS4I1YZh1RKsqs54f3eM2w0mWdWF3y9T8typRKCbSQHXbtfTYMp3ekxsTq
         yv95Tj8sXxC4q6Bz5PEHSciuSBUzM5eILvVL3cS2uoB0xR5Nm1eqkp6JQU9MX7PHcPNC
         z5bQ==
X-Received: by 10.194.108.198 with SMTP id hm6mr1111255wjb.33.1390046386862;
 Sat, 18 Jan 2014 03:59:46 -0800 (PST)
Received: by 10.217.121.131 with HTTP; Sat, 18 Jan 2014 03:59:46 -0800 (PST)
In-Reply-To: <1390044238.17519.6.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240646>

2014/1/18 Alexander Shopov (=E1=CC=C5=CB=D3=C1=CE=C4=DF=D2 =FB=CF=D0=CF=
=D7) <lists@kambanaria.org>:
> How much of a translation (in Bulgarian) should I do to be included?

=46eel free to send me pull request when you translated some (greater
than zero) in the initial commit, and also update po/TEAMS in this
commit.

> I have no idea how much time do I have before 1.9 is out.

Maybe three weeks left. You can estimate it by checking the date
for history tags, such as v1.8.5-rc0 and v1.8.5-rc3.

    v1.8.5-rc0: Wed Oct 30 12:17:56 2013 -0700
    v1.8.5-rc3: Wed Nov 20 11:27:39 2013 -0800
    v1.8.5: Wed Nov 27 12:14:52 2013 -0800

> I have sent translations of gitk and git gui to this list as inline
> patches, cc-ing the maintainers. Should I prod them again to be
> considered for 1.9?
>

If the reviews all subscribe this list, you can send to this list.
But If not, you can send to the reviewers directly.

> The stats you provide do not add up plus there is nothing about fuzzy
> messages

Yes, fuzz messages are not included. I double checked the history
of da.po and nl.po, and I'm sure there are no further updates since
their maintainers sent me Email like "Hi, add me as the maintainer
for that language, and I will send translations latter..."

Remove them can make the Git package smaller and give
opportunities to other contributors.


--=20
Jiang Xin
