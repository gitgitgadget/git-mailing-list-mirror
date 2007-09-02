From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 16:28:47 -0700
Message-ID: <7vveasode8.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<87hcmcfzo9.fsf@morpheus.local> <87d4x0fzky.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRysb-0004xa-3D
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbXIBX2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 19:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbXIBX2y
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:28:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbXIBX2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 19:28:54 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DFC6012D4C2;
	Sun,  2 Sep 2007 19:29:11 -0400 (EDT)
In-Reply-To: <87d4x0fzky.fsf@morpheus.local> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Mon,
	03 Sep 2007 00:54:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57403>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> GIT v1.5.3 Release Notes
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>
>>> Updates since v1.5.2
>>> --------------------
>>>
>>> * The commit walkers other than http are officially deprecated,
>>>   but still supported for now.
>>
>> As I think I said before, this first bullet point makes no sense to
>> git users.  Only hardcore git developers know what a "commit walker
>> is", and what commit walkers exist (other than html, obviously).  Ho=
w
>
> I'm not trying to make you even more confused. Make that "http",
> please. :-)

Unless you work extremely hard at it, you won't be using the
local and/or ssh walkers.  The entry is really meant for
Porcelain writers (aka plumbing users).

It's a tricky balancing act.  Not everybody is the end user who
is only interested in using Porcelain.  The release note for a
new release somehow needs to mention changes that would affect
only plumbing users as well.
