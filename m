From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: folder naming bug?
Date: Tue, 03 Feb 2015 09:34:02 +0100
Message-ID: <54D087FA.8030707@web.de>
References: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io> <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com> <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Kevin Coleman <kevin.coleman@sparkstart.io>,
	Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:34:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIYwX-00075R-27
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 09:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbbBCIef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2015 03:34:35 -0500
Received: from mout.web.de ([212.227.15.3]:51193 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148AbbBCIef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 03:34:35 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MEER6-1YPCmb3i6i-00FTHn; Tue, 03 Feb 2015 09:34:30
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io>
X-Provags-ID: V03:K0:ZzZr7DO6xO0imGG0I1/pwTSC8qGM0BSODO9qeiPa/XIx5O98iJe
 hwQW5M06Guc2QlYS7fu+9IVwwG5m8AMjxtiUnlRx5vH7z/tVjv7GxBr+kFjXp74/9z6tEQH
 aNcYOSYIjOtRcTFv77qb6u7BXkrLOlC5ynTo/AIiY2jjZWTfIDsv/VxcF3dHYKUw4UU4072
 ceveD3DpWuh4OecqIgoVA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263310>


On 02/03/2015 05:52 AM, Kevin Coleman wrote:
> =3D=3D=3D=3D
> Yes, I am on a Mac.  I just tried that, but I don=E2=80=99t think tha=
t completely fixed it.  As you can see it tracks =E2=80=9Cfoo/bar.md=E2=
=80=9D and then it tracks =E2=80=9CFoo/bar.md=E2=80=9D.  It still track=
s both =E2=80=9Cfoo=E2=80=9D and =E2=80=9CFoo=E2=80=9D even tho only =E2=
=80=9CFoo=E2=80=9D exists in my dir after the rename.
You asked Git to track Foo/bar.md and the file system says "yes, it's h=
ere"
When you rename Foo/ into foo/, the file system still says "Foo/bar.md"=
=20
is here.
You need to tell git about the rename :
git mv Foo/bar.md foo/bar.md

Why does anybody think that setting "core.ignorecase false" will=20
convince the file system
to become case insensitive ?
