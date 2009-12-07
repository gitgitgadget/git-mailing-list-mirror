From: Sergei Organov <osv@javad.com>
Subject: Re: git-blame.el: what is format-spec?
Date: Mon, 07 Dec 2009 11:36:19 +0300
Message-ID: <87k4wzdvuk.fsf@osv.gnss.ru>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
	<87einafojx.fsf@osv.gnss.ru> <87d42s3pv2.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Dec 07 09:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHZ5B-000657-E0
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 09:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759176AbZLGIgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 03:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759120AbZLGIgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 03:36:16 -0500
Received: from javad.com ([205.178.136.214]:45327 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759069AbZLGIgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 03:36:14 -0500
Received: (qmail 15664 invoked from network); 7 Dec 2009 08:36:21 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 7 Dec 2009 08:36:21 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1NHZ4t-0006l8-K2; Mon, 07 Dec 2009 11:36:19 +0300
In-Reply-To: <87d42s3pv2.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Sun\, 06 Dec 2009 19\:43\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134725>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Then there should be (require 'format-spec) in git-blame.el, right? =
Due
>> to:
>
> Of course. I must have missed that since I already had it loaded.
>
>> Now, I've evaluated (require 'format-spec) in my Emacs 22 (yes, 22, =
not
>> 23), and now git-blame almost works there. The problem I see is that=
 it
>> doesn't output anything in the echo area. It color-codes the buffer,=
 it
>> does show correct pop-up when mouse is over a region, but it doesn't
>> print anything in the echo area when I move cursor through the regio=
ns.
>> Any idea how to debug/fix this?
>
> Well, it appears I removed the output to the echo area. I didn't thin=
k
> it worked very well, and the new output format mostly replaces it by
> showing the hash.
>
> There are also technical reasons for removing it (it couldn't be
> implemented very cleanly).

I didn't know you deliberately removed it, -- I thought it's some
Emacs22 - related problem. I have no problem then, except that I don't
know how to get the hash into my kill-ring or X selection.

While we are at it, why is git-blame-identify interactive and how is it
useful?

>
> It would of course be possible to restore the old way, but I think it
> would be good to ask ourselves what we really would like to see? Some
> ideas:
>
> * A keybinding to show the commit introducing the current line,
>   including diff and all.
>
> * A keybinding to show the commit message in the echo areia.

=46or me, these 2 would be more than enough, I think.

-- Sergei.
