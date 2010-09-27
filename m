From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
Subject: Re: Encoding problem on OSX?
Date: Mon, 27 Sep 2010 08:18:33 +0300
Message-ID: <AANLkTim=XbrSourufbNGo39_CTnXO8QPVOjt99fJedwE@mail.gmail.com>
References: <20100809234620.GA6418@burratino> <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
 <20100811075503.GD5450@burratino> <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
 <20100811082953.GA16456@burratino> <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com>
 <20100811084443.GF16495@burratino> <AANLkTinS0BeHWNJ0mCtTbVRz=7FBwE0_OTKDfS2gPXdN@mail.gmail.com>
 <AANLkTi=sBNmMoZmqO_-AFNO6bVqtJmXbdXYUf7-bKars@mail.gmail.com>
 <20100811092311.GA16901@burratino> <20100927023122.GA8802@burratino> <9A6F91A4-796B-45F1-B2BD-1367AB5A1679@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard MICHAEL <rmichael@leadformance.com>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 07:19:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0679-0007GD-9s
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 07:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab0I0FSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 01:18:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59365 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab0I0FSy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 01:18:54 -0400
Received: by iwn5 with SMTP id 5so4469112iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 22:18:53 -0700 (PDT)
Received: by 10.231.183.81 with SMTP id cf17mr8639919ibb.32.1285564733520;
 Sun, 26 Sep 2010 22:18:53 -0700 (PDT)
Received: by 10.231.39.75 with HTTP; Sun, 26 Sep 2010 22:18:33 -0700 (PDT)
In-Reply-To: <9A6F91A4-796B-45F1-B2BD-1367AB5A1679@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157300>

On Mon, Sep 27, 2010 at 8:15 AM, Kevin Ballard <kevin@sb.org> wrote:
> On Sep 26, 2010, at 7:31 PM, Jonathan Nieder wrote:
>
>> Hi again,
>>
>> =C4=B0smail D=C3=B6nmez wrote:
>>
>>> Downgrading my sed to v 4.1.5 fixed the issue.
>>
>> This is nicely explained here:
>>
>> https://www.opengroup.org/sophocles/show_mail.tpl?source=3DL&listnam=
e=3Daustin-group-l&id=3D14595
>>
>> It looks to be a Mac OS libc misfeature. =C2=A0Could you two lobby A=
pple to
>> get this fixed? :)
>
> FWIW, /usr/bin/sed on Mac OS X 10.6 doesn't seem to be having a probl=
em. t4201-shortlog.sh passes all tests on my machine.

Yes the problem was with GNU sed on OSX 10.6

Regards,
ismail
