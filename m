From: zhifeng hu <zf@ancientrocklab.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 17:29:49 +0800
Message-ID: <F569EBDF-D8B5-47D5-8C2F-DA3A0F6C207E@ancientrocklab.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com> <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com> <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com> <CALUzUxrEvuKuN+v-hJLQd5KoV-fzxVYvg5pj7XoLBVap7mgA=Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
	<vnwildman@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 10:30:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlxvN-00081N-MW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 10:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab3K1JaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 04:30:14 -0500
Received: from imap1.ox.registrar-servers.com ([198.187.29.233]:35568 "EHLO
	imap1.ox.registrar-servers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751271Ab3K1JaM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 04:30:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by oxmail.registrar-servers.com (Postfix) with ESMTP id 787D7200096;
	Thu, 28 Nov 2013 04:30:11 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap1.ox.registrar-servers.com
Received: from oxmail.registrar-servers.com ([127.0.0.1])
	by localhost (imap1.ox.registrar-servers.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id geV4WbVOh0iy; Thu, 28 Nov 2013 04:30:11 -0500 (EST)
Received: from [192.168.1.101] (unknown [119.98.73.69])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by oxmail.registrar-servers.com (Postfix) with ESMTPSA id A611B200093;
	Thu, 28 Nov 2013 04:30:06 -0500 (EST)
In-Reply-To: <CALUzUxrEvuKuN+v-hJLQd5KoV-fzxVYvg5pj7XoLBVap7mgA=Q@mail.gmail.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238487>

Once using git clone =E2=80=94depth or git fetch =E2=80=94depth,
While you want to move backward.
you may face problem

 git fetch --depth=3D105
error: Could not read 483bbf41ca5beb7e38b3b01f21149c56a1154b7a
error: Could not read aacb82de3ff8ae7b0a9e4cfec16c1807b6c315ef
error: Could not read 5a1758710d06ce9ddef754a8ee79408277032d8b
error: Could not read a7d5629fe0580bd3e154206388371f5b8fc832db
error: Could not read 073291c476b4edb4d10bbada1e64b471ba153b6b


zhifeng hu=20



On Nov 28, 2013, at 5:20 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:

> On Thu, Nov 28, 2013 at 4:14 PM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>> On Thu, Nov 28, 2013 at 2:41 PM, zhifeng hu <zf@ancientrocklab.com> =
wrote:
>>> Thanks for reply, But I am developer, I want to clone full reposito=
ry, I need to view code since very early.
>>=20
>> if it works with --depth =3D1, you can incrementally run "fetch
>> --depth=3DN" with N larger and larger.
>=20
> I second Duy Nguyen's and Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n's sugge=
stion to 1) initially
> create a "shallow" clone then 2) incrementally deepen your clone.
>=20
> Zhifeng, in the course of your research into resumable cloning, you
> might have learnt that while it's a really valuable feature, it's als=
o
> a pretty hard problem at the same time. So it's not because git
> doesn't want to have this feature.
>=20
> --=20
> Cheers,
> Ray Chuan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
