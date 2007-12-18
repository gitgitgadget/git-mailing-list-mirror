From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 00/17] Series short description
Date: Tue, 18 Dec 2007 10:20:04 +0100
Message-ID: <871w9kmkaj.fsf@lysator.liu.se>
References: <20071214105238.18066.23281.stgit@krank>
	<b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	<20071217224812.GA6342@diana.vm.bytemark.co.uk>
	<b0943d9e0712180111l3294e1adj60b5271b9820c60c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YcU-0005VO-DR
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbXLRJTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 04:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbXLRJTq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:19:46 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:54995 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbXLRJTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 04:19:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 479E1200A244;
	Tue, 18 Dec 2007 10:19:44 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05925-01-40; Tue, 18 Dec 2007 10:19:43 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 8F2D7200A240;
	Tue, 18 Dec 2007 10:19:43 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 8A68C7B4077; Tue, 18 Dec 2007 10:20:04 +0100 (CET)
In-Reply-To: <b0943d9e0712180111l3294e1adj60b5271b9820c60c@mail.gmail.com> (Catalin Marinas's message of "Tue\, 18 Dec 2007 09\:11\:00 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68714>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 17/12/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> On 2007-12-17 11:09:06 +0000, Catalin Marinas wrote:
>>
>> > On 14/12/2007, David K=C3=A5gedal <davidk@lysator.liu.se> wrote:
>> >
>> > > The following series an emacs interface to stgit patch stacks. I=
t
>> > > shows a buffer with the the output of "stg series" and allows yo=
u
>> > > to do some common operations on it, such as push/pop,
>> > > commit/uncommit, edit, rename, repair, and coalesce.
>> >
>> > That's really cool stuff! Thanks.
>>
>> Yes, incredibly useful.
>
> Other useful commands would be support for 'patches' and a local
> diff/status (and maybe a menu).

I have some ideas for some way of showing the current status, but
nothing is implemented yet. For some of the more complex cases, I'd
like to refer to git.el, although I think that needs some
improvements.

I don't think I ever used the 'patches' command, so I'm not sure what
the best way to implement it would be.

And my emacs has no menu, so I'm probably not the best person to adda
menu, either :-)

--=20
David K=C3=A5gedal
