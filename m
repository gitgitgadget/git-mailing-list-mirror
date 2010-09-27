From: Kevin Ballard <kevin@sb.org>
Subject: Re: Encoding problem on OSX?
Date: Sun, 26 Sep 2010 22:15:58 -0700
Message-ID: <9A6F91A4-796B-45F1-B2BD-1367AB5A1679@sb.org>
References: <20100809234620.GA6418@burratino> <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com> <20100811075503.GD5450@burratino> <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com> <20100811082953.GA16456@burratino> <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com> <20100811084443.GF16495@burratino> <AANLkTinS0BeHWNJ0mCtTbVRz=7FBwE0_OTKDfS2gPXdN@mail.gmail.com> <AANLkTi=sBNmMoZmqO_-AFNO6bVqtJmXbdXYUf7-bKars@mail.gmail.com> <20100811092311.GA16901@burratino> <20100927023122.GA8802@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C4=B0smail_D=C3=B6nmez?= <ismail@namtrac.org>,
	Richard MICHAEL <rmichael@leadformance.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 07:16:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P064R-0006jQ-I3
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 07:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab0I0FQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 01:16:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53891 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab0I0FQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 01:16:05 -0400
Received: by pwj6 with SMTP id 6so1075544pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 22:16:04 -0700 (PDT)
Received: by 10.114.15.18 with SMTP id 18mr7752880wao.182.1285564563926;
        Sun, 26 Sep 2010 22:16:03 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id c24sm9752358wam.19.2010.09.26.22.15.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 22:15:59 -0700 (PDT)
In-Reply-To: <20100927023122.GA8802@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157299>

On Sep 26, 2010, at 7:31 PM, Jonathan Nieder wrote:

> Hi again,
>=20
> =C4=B0smail D=C3=B6nmez wrote:
>=20
>> Downgrading my sed to v 4.1.5 fixed the issue.
>=20
> This is nicely explained here:
>=20
> https://www.opengroup.org/sophocles/show_mail.tpl?source=3DL&listname=
=3Daustin-group-l&id=3D14595
>=20
> It looks to be a Mac OS libc misfeature.  Could you two lobby Apple t=
o
> get this fixed? :)

=46WIW, /usr/bin/sed on Mac OS X 10.6 doesn't seem to be having a probl=
em. t4201-shortlog.sh passes all tests on my machine.

-Kevin Ballard