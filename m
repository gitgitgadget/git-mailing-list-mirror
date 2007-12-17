From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 14:12:28 +0100
Message-ID: <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org> <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com> <Pine.LNX.4.64.0712171223210.9446@racer.site> <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com> <Pine.LNX.4.64.0712171253290.9446@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 14:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Fmx-000142-Kh
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 14:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbXLQNNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 08:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbXLQNNT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 08:13:19 -0500
Received: from wincent.com ([72.3.236.74]:58234 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbXLQNNT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 08:13:19 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHDCTp7022361;
	Mon, 17 Dec 2007 07:12:30 -0600
In-Reply-To: <Pine.LNX.4.64.0712171253290.9446@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68562>

El 17/12/2007, a las 13:55, Johannes Schindelin escribi=F3:

> On Mon, 17 Dec 2007, Wincent Colaiuta wrote:
>
>> El 17/12/2007, a las 13:26, Johannes Schindelin escribi?:
>>
>>> I think it is wrong to go out of our way to support "git status -=20
>>> p" as
>>> a synonym to "git -p status".  I simply do not believe that =20
>>> newcomers
>>> are not intelligent enough to understand that "git -p <subcommand>"
>>> means that the output goes into their pager.
>>
>> But the point is, of all the special options, -p is the *only* that
>> can't unambiguously go after the subcommand.
>
> It should not be put after the subcommand.  That's my point.  Exactly
> because it is -- even conceptually -- no subcommand option.
>
> CVS has many shortcomings, but one lesson here is that people had no
> problems with "cvs -z3 update -d -P".  See, the "-z3" is an option =20
> that
> has nothing to do with the subcommand.
>
> Exactly the same situation here.  I never had any problems =20
> explaining why
> "-p" goes before the subcommand here.  Never.

Would be even better if there was nothing to explain and it all just =20
worked, which is what I'm proposing here. As I said, -p is the only =20
special option which clashes with any non-special uses.

But leaving -p aside, will you oppose any patches that make it =20
possible for people to write stuff like:

git init --bare

Personally, I think this is an obvious usability improvement worth =20
striving for. Given that "git --bare init" will continue to work under =
=20
what I'm proposing, I really can't see any worthwhile argument against =
=20
it. Because we're talking about a UI improvement for newcomers at no =20
cost to old timers.

Cheers,
Wincent
