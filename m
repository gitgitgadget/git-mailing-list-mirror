From: "Fernando Ortiz (e2k)" <eratos2000@gmail.com>
Subject: Re: Git send-email fail on Mac OS X Lion
Date: Sun, 13 Oct 2013 03:52:37 -0500
Message-ID: <AC70CEA8-07D4-4327-9EC1-557BA90C659A@gmail.com>
References: <04374E86-02D8-4E76-A7F5-7DEE34F25C7F@gmail.com> <20131012134711.GG79408@vauxhall.crustytoothpaste.net> <194068D5-0134-48CA-89E0-484CD296BD83@gmail.com> <525A5AA8.5050909@web.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 13 10:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVHPq-0000sr-L5
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 10:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab3JMIwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Oct 2013 04:52:42 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41113 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab3JMIwl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Oct 2013 04:52:41 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so3666995oag.40
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jiLuGp3xyiG0ambdO1bqnbGyhucD0nBGtSpx0iG4qGQ=;
        b=jUWVch8E/FpbNpVdkiL8zswR91r4Xm6C9dF1S/qlm/1uWUUxQCVFQt/h/XNbXfEKa2
         iLQ4wG3EbsUhQzFP5CFld1wD5+9EeGLbOcz+OMPm1eFKjywdlFDYf3v1mW+iUTHV1/4D
         UaeGeHh5lp8WG1B6TS+o/g7B/TvzCQYxtOA7OvBCh32Kl878Y8TcWjJpIbDp0R2aZCYa
         R2uZ9xWGuNsXeA9+NHjsncv5MgM4U/QBbulcDuMImM2VVSG8dDooqBozjAOBcatS4XL1
         Bc4jgES2wjBAJn0Zu2IksRIJ6ZUdr2V0M7aUnJH7Q/xMbVuLA/Dhp8RKeRepYRwH5Nhn
         e5JA==
X-Received: by 10.60.155.166 with SMTP id vx6mr23086658oeb.28.1381654360796;
        Sun, 13 Oct 2013 01:52:40 -0700 (PDT)
Received: from [192.168.2.106] (ip70-180-90-249.no.no.cox.net. [70.180.90.249])
        by mx.google.com with ESMTPSA id d8sm109480786oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 01:52:40 -0700 (PDT)
In-Reply-To: <525A5AA8.5050909@web.de>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236067>


On Oct 13, 2013, at 3:32 AM, Torsten B=F6gershausen wrote:

> (Please, not top-posting)
Sorry about that
>=20
>>> On Oct 12, 2013, at 8:47 AM, "brian m. carlson" <sandals@crustytoot=
hpaste.net> wrote:
>>>=20
>>>> On Fri, Oct 11, 2013 at 11:06:17PM -0500, Fernando Ortiz (e2k) wro=
te:
>>>> I'm getting the following error when I do:
>>>>=20
>>>> git send-email --compose --from Fernando Ortiz <eratos2000@gmail.c=
om> --to fortiz2k@gmail.com --cc fortiz2k@gmail.com 0001-Change-zcat-to=
-gzcat-to-fix-build-restore-steps.patch
>>>>=20
>>>> Net::SSLeay version 1.46 required--this is only version 1.36 at /U=
sers/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/IO/So=
cket/SSL.pm line 17.
>>>=20
>>> Here's your answer: Net::SSLeay is too old for IO::Socket::SSL.  Yo=
u
>>> either need to use cpan or cpanm to install a newer Net::SSLeay, an=
d
>>> then it will work.
>=20
> On 2013-10-12 19.40, Gmail wrote:> Brian,
>>=20
>> I already tried to reinstall with cpan/m using -f -i options.  I eve=
n removed the PERL5LIB location and reinstalled the packages from scrat=
ch to no avail.
>>=20
>> Nando
>>=20
>> Sent from my iPhone
>>=20
> This may be a stupid question:
> Which perl is in your $PATH ?
I was using perlbrew to manage all the perls.  I got so frustrated and =
decided to=20
dump perlbrew and decided to use plenv instead.  I'm not getting the er=
ror anymore,=20
after switching to plenv everything is working now.
> What do you get entering
> type perl
> on the command line ?
> /Torsten
>=20
>=20
