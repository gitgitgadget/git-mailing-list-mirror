From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 10:41:49 +0100
Message-ID: <87bq8nkoma.fsf@lysator.liu.se>
References: <20071214105238.18066.23281.stgit@krank>
	<b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	<20071217224812.GA6342@diana.vm.bytemark.co.uk>
	<20071218052115.GA13422@diana.vm.bytemark.co.uk>
	<b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
	<m3hcigot3h.fsf@roke.D-201>
	<b0943d9e0712180852y62c5bea2x61463b235b26ca04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Jakub Narebski <jnareb@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4vR3-000638-OB
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbXLSJlb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 04:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbXLSJlb
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:41:31 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:39209 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbXLSJla convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 04:41:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id AD539200A1F8;
	Wed, 19 Dec 2007 10:41:28 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 04528-01-18; Wed, 19 Dec 2007 10:41:28 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2597C200A22F;
	Wed, 19 Dec 2007 10:41:28 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 91ADC7B4077; Wed, 19 Dec 2007 10:41:49 +0100 (CET)
In-Reply-To: <b0943d9e0712180852y62c5bea2x61463b235b26ca04@mail.gmail.com> (Catalin Marinas's message of "Tue\, 18 Dec 2007 16\:52\:18 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68876>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 18/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>>
>> > Thanks again for maintaining these branches.
>> >
>> > On 18/12/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> > >   git://repo.or.cz/stgit/kha.git safe
>>
>> > >       Remove "stg resolved"
>> >
>> > I'd like to keep this command. git-mergetool doesn't support the t=
ool
>> > I use (emacs + ediff and more stgit-specific file extensions like
>> > current, patch etc.). I also don't find 'git add' to be meaningful=
 for
>> > marking a conflict as solved.
>>
>> I also would like to have this command kept (and shown in 'stg help'=
!).
>> Contrary to 'git add' it can check and add to index / update index
>> only for files with conflict; we have -r (ancestor|current|patched)
>> to choose one side, and we could add --check to check if there are
>> no conflict markers with files (useful with -a/--all).
>
> I'd also like to re-add the stgit.keeporig option and additional
> functionality so that the *.{ancestor,current,patched} can be left in
> the working tree. Some people might use them when manually fixing
> conflicts (I have a look at them from time to time when the emacs +
> ediff shows a hard to understand conflict).

Since all the information is in git, it is of course easy to recreate
it. But the important question to ask is: how do you use these extra
files? git.el provides a way to diff against both parent versions, and
maybe that is actually what you need.

I don't mind that you want these files, but they are mostly clutter to
me.

--=20
David K=C3=A5gedal
