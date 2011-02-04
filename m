From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el: does not show one-line summary in echo area
Date: Fri, 04 Feb 2011 11:15:40 +0100
Message-ID: <87r5bom7g3.fsf@krank.kagedal.org>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <20110204014315.GB28525@elie>
	<87tygkm8h7.fsf@krank.kagedal.org>
	<201102041103.10770.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergei Organov <osv@javad.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Kevin Ryde <user42@zip.com.au>,
	Martin Nordholts <enselic@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Xavier Maillard <zedek@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 11:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlIhi-00077O-BC
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 11:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab1BDKPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 05:15:46 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51336 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab1BDKPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 05:15:45 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 668EF4000A;
	Fri,  4 Feb 2011 11:15:44 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 582BF4000C; Fri,  4 Feb 2011 11:15:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4E5B54000A;
	Fri,  4 Feb 2011 11:15:43 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 05D8A61403; Fri,  4 Feb 2011 11:15:40 +0100 (CET)
In-Reply-To: <201102041103.10770.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 4 Feb 2011 11:03:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166032>

Jakub Narebski <jnareb@gmail.com> writes:

> Dnia pi=C4=85tek 4. lutego 2011 10:53, David K=C3=A5gedal napisa=C5=82=
:
>
>> 3) Showing when you move to a different blame chunk, by showing a
>>    one-line summary in the echo area.
>
> There is even some prior art for this to borrow from, namely cperl-mo=
de
> shows information about syntax at given point in echo area (minibuffe=
r
> area) after some delay.  Just FYI.

Sure, there are a number of those (eldoc comes to mind). I think the
hardest part is figuring out what to show. A 40-charater hash is
probably not very useful. The problem is that the committer information=
,
date, and commit message first line takes up a lot of space. But we can
of course let the echo area grow to two lines, or even three.

I don't think I'll have time to cook something up right now, though.

--=20
David K=C3=A5gedal
