From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 14:57:53 +0100
Message-ID: <ECF98EB9-DE57-4DFF-9F5B-A7FEC3BEB022@wincent.com>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org> <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com> <Pine.LNX.4.64.0712171223210.9446@racer.site> <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com> <Pine.LNX.4.64.0712171253290.9446@racer.site> <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com> <Pine.LNX.4.64.0712171328020.9446@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 14:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4GUN-0007HK-Gk
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 14:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbXLQN6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 08:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbXLQN6M
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 08:58:12 -0500
Received: from wincent.com ([72.3.236.74]:58296 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbXLQN6M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 08:58:12 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHDvsbc023220;
	Mon, 17 Dec 2007 07:57:55 -0600
In-Reply-To: <Pine.LNX.4.64.0712171328020.9446@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68565>

El 17/12/2007, a las 14:30, Johannes Schindelin escribi=F3:

>> But leaving -p aside, will you oppose any patches that make it =20
>> possible
>> for people to write stuff like:
>>
>> git init --bare
>>
>> Personally, I think this is an obvious usability improvement worth
>> striving for. Given that "git --bare init" will continue to work =20
>> under
>> what I'm proposing, I really can't see any worthwhile argument =20
>> against
>> it. Because we're talking about a UI improvement for newcomers at no
>> cost to old timers.
>
> My reasoning is like as for "-p".  "--bare" is not special to =20
> "init".  It
> makes git not guess, but work on the current directory as a bare
> repository.

Yes, I know what --bare does. It seems to me your argument is as =20
follows:

- "git subcommand" is actually "git" (which does setup) followed by =20
"git-subcommand" (which performs an action)[*]

- the newcomer should be taught this, and know which options go =20
between "git" and "subcommand" and which options go after

- even though there is a straightforward way to have "git subcommand =20
specials args" work without breaking compatibility, you oppose it on =20
the grounds that users should know how Git works

- the fact that CVS also has some options that go before the =20
subcommand makes it OK for git to do the same

- even though we could have a better UI that didn't require any of =20
this explanation at all, we should keep the UI we have seeing as it is =
=20
easy to explain

And possibly some combination of these two as well:

- requiring arguments to be inserted between "git" and "subcommand" =20
doesn't undermine the effort to make git appear like a single tool to =20
users

- the effort to move to dashless forms has nothing to do with =20
presenting git as a single tool to users

Well, I basically disagree with you on most of these points; all but =20
the first one(*), really. I think it's fairly clear what both you and =20
I think on this and I'm not very interested in debating it further; I =20
am more interested in hearing other people's points on this to get a =20
feeling for whether there is a consensus (or lack thereof).

Cheers,
Wincent
