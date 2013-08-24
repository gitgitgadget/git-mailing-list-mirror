From: =?UTF-8?B?0K/QvdGH0LDRgNGD0Log0JDQu9C10LrRgdCw0L3QtNGA?= 
	<alex@itvault.info>
Subject: Re: How to set tab size for hunks in =?UTF-8?B?4oCcZ2l0IGFkZCAtcA==?=
 =?UTF-8?B?4oCdPw==?=
Date: Sat, 24 Aug 2013 13:53:18 +0400
Message-ID: <5218828E.2020000@itvault.info>
References: <52179BAB.3040505@itvault.info> <CALWbr2xvMtXddpnkVs8TkSiaLcmpJGY7_hUTa3r_1X1SgDyhng@mail.gmail.com>
Reply-To: alex@itvault.info
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 11:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDAXG-0001m8-TR
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 11:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab3HXJxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Aug 2013 05:53:25 -0400
Received: from host-46-137.data-centre.net ([213.248.46.137]:14435 "EHLO
	itvault.info" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755036Ab3HXJxY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 05:53:24 -0400
Received: from localhost (localhost.itvault.info [127.0.0.1])
	by itvault.info (Postfix) with ESMTP id 5F3161DBCDF;
	Sat, 24 Aug 2013 13:53:20 +0400 (MSK)
X-Virus-Scanned: amavisd-new at itvault.info
Received: from itvault.info ([127.0.0.1])
	by localhost (xhost.itvault.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V10m5TjUsCDw; Sat, 24 Aug 2013 13:53:19 +0400 (MSK)
Received: from [192.168.1.2] (ppp91-76-236-97.pppoe.mtu-net.ru [91.76.236.97])
	by itvault.info (Postfix) with ESMTPSA id 56E5F1DBCDB;
	Sat, 24 Aug 2013 13:53:19 +0400 (MSK)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130704 Icedove/17.0.7
In-Reply-To: <CALWbr2xvMtXddpnkVs8TkSiaLcmpJGY7_hUTa3r_1X1SgDyhng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232882>

Thanks a lot!

That solution worked for me:
env TERM=3Dlinux setterm -regtabs 4

Best regards,
Alexander Yancharuk
alex@itvault.info <mailto:alex@itvault.info>
On 23.08.2013 22:19, Antoine Pelisse wrote:
> On Fri, Aug 23, 2013 at 7:28 PM, =D0=AF=D0=BD=D1=87=D0=B0=D1=80=D1=83=
=D0=BA =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 <alex@itv=
ault.info> wrote:
>> But those settings seems does not affect on |git add -p|. How to set=
 tab
>> size for hunks in *git add -p* command?
> That's because "git add -p" doesn't go through less/pager.
> You can certainly change the tabs size for your terminal with "tabs -=
4" though.
