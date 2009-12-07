From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el: what is format-spec?
Date: Mon, 07 Dec 2009 10:05:04 +0100
Message-ID: <87638jjgsf.fsf@lysator.liu.se>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
	<87einafojx.fsf@osv.gnss.ru> <87d42s3pv2.fsf@lysator.liu.se>
	<87k4wzdvuk.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 10:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHZip-0004dc-3L
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 10:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759273AbZLGJRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 04:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759266AbZLGJRQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 04:17:16 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:41638 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759268AbZLGJRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 04:17:08 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2A8E740098;
	Mon,  7 Dec 2009 10:16:08 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 1C29B4009A; Mon,  7 Dec 2009 10:16:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C392540098;
	Mon,  7 Dec 2009 10:16:07 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id B9DAE60E6B; Mon,  7 Dec 2009 10:05:10 +0100 (CET)
In-Reply-To: <87k4wzdvuk.fsf@osv.gnss.ru> (Sergei Organov's message of "Mon,
	07 Dec 2009 11:36:19 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134727>

Sergei Organov <osv@javad.com> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Sergei Organov <osv@javad.com> writes:
>>
>>> Then there should be (require 'format-spec) in git-blame.el, right?=
 Due
>>> to:
>>
>> Of course. I must have missed that since I already had it loaded.
>>
>>> Now, I've evaluated (require 'format-spec) in my Emacs 22 (yes, 22,=
 not
>>> 23), and now git-blame almost works there. The problem I see is tha=
t it
>>> doesn't output anything in the echo area. It color-codes the buffer=
, it
>>> does show correct pop-up when mouse is over a region, but it doesn'=
t
>>> print anything in the echo area when I move cursor through the regi=
ons.
>>> Any idea how to debug/fix this?
>>
>> Well, it appears I removed the output to the echo area. I didn't thi=
nk
>> it worked very well, and the new output format mostly replaces it by
>> showing the hash.
>>
>> There are also technical reasons for removing it (it couldn't be
>> implemented very cleanly).
>
> I didn't know you deliberately removed it, -- I thought it's some
> Emacs22 - related problem. I have no problem then, except that I don'=
t
> know how to get the hash into my kill-ring or X selection.
>
> While we are at it, why is git-blame-identify interactive and how is =
it
> useful?

I think I need to go over this file with a fine-tooth coam to remove or
fix bitrot. This command seems to try to show the hash in the echo area=
,
but probably doesn't work. New and better commands should be deviced.

I'll try to find some time to work on this soon.

Thanks a lot for the feedback.

--=20
David K=C3=A5gedal
