From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Status of kha/experimental
Date: Wed, 10 Oct 2007 09:39:15 +0200
Message-ID: <87tzozxvto.fsf@lysator.liu.se>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
	<20071007213307.GA32210@diana.vm.bytemark.co.uk>
	<b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWAB-0000Pf-M8
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 09:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbXJJHjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 03:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXJJHjS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 03:39:18 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:58424 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXJJHjR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 03:39:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6385E200A1FF;
	Wed, 10 Oct 2007 09:39:16 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 02651-01-74; Wed, 10 Oct 2007 09:39:15 +0200 (CEST)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 5A067200A1E2;
	Wed, 10 Oct 2007 09:39:15 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 2F5ED7B4080; Wed, 10 Oct 2007 09:39:15 +0200 (CEST)
In-Reply-To: <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com> (Catalin Marinas's message of "Tue\, 9 Oct 2007 22\:10\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60474>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 07/10/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> On 2007-10-07 22:18:44 +0100, Catalin Marinas wrote:
>>
>> > How stable is the kha/experimental branch? Since there are more an=
d
>> > more bugs added to the tracking system, I'll have to start looking
>> > at them before a 0.14 release. Is it worth merging the
>> > kha/experimental now or we better wait for after 0.14?
>>
>> The idea is that experimental contains changes that need testing, bu=
t
>> may not yet be ready for your master. (They are generally safe,
>> though; I run StGit from my experimental branch at work, for example=
=2E)
>> When I decide that they are ready, I move them to safe. If there are
>> any patches you feel should be in safe rather than experimental, jus=
t
>> ask. Or you could just take them directly from experimental without
>> asking, of course. :-)
>
> OK. My plan is to merge kha/safe and have a look at what seems safer
> to merge from kha/experimental. Fix bugs (and freeze the current
> features). Release 0.14. Merge kha/experimental entirely post 0.14 an=
d
> test/stabilize it over couple of months. How does this sound?

Sounds like a plan to me.  But we should probably fix the loose ends
in kha/experimental before merging it entirely.

--=20
David K=C3=A5gedal
