From: =?ISO-8859-1?Q?Noralf_Tr=F8nnes?= <notro@tronnes.org>
Subject: Re: Git messes up =?ISO-8859-1?Q?=27=F8=27_character?=
Date: Tue, 20 Jan 2015 23:26:07 +0100
Message-ID: <54BED5FF.40107@tronnes.org>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de> <54BEB7ED.2050103@tronnes.org> <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com> <54BEC75C.3090207@tronnes.org> <CACBZZX5f0ciqmJizYxe+UvKL-g9iDZTca52=9xZP4_qiuEaO3Q@mail.gmail.com> <54BECAE0.70309@tronnes.org> <20150120221802.GJ2350@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:26:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDhFX-0003On-T1
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 23:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbbATW0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 17:26:12 -0500
Received: from asav22.altibox.net ([109.247.116.9]:50317 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbbATW0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 17:26:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by asav22.altibox.net (Postfix) with ESMTP id 274CF20058;
	Tue, 20 Jan 2015 23:26:07 +0100 (CET)
Received: from asav22.altibox.net ([127.0.0.1])
	by localhost (asav22.lysetele.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Vr_i9Moebjbj; Tue, 20 Jan 2015 23:26:06 +0100 (CET)
Received: from [127.0.0.1] (48.81-166-104.customer.lyse.net [81.166.104.48])
	by asav22.altibox.net (Postfix) with ESMTP id 0F20020044;
	Tue, 20 Jan 2015 23:26:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20150120221802.GJ2350@localhost>
X-Antivirus: avast! (VPS 150120-1, 20.01.2015), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262701>

Den 20.01.2015 23:18, skrev Nico Williams:
> On Tue, Jan 20, 2015 at 10:38:40PM +0100, Noralf Tr=F8nnes wrote:
>> Yes:
>> $ echo Noralf Tr=F8nnes | xxd
>> 0000000: 4e6f 7261 6c66 2054 72f8 6e6e 6573 0a    Noralf Tr.nnes.
>>
>> Is there a command I can run that shows that I'm using ISO-8859-1 ?
>> I need something to google with, my previous search only gave locale
>> stuff, which seems fine.
> The locale(1) command tells you what your locale is set to, but it
> doesn't say anything about your input method -- it only tells you wha=
t
> your shell and commands started from it expect for input and what the=
y
> should produce for output.
>
> The input method will generally be part of your windowing environment=
,
> for which you'll have to search how to check/configure your OS
> (sometimes it can be set on a per-window basis, sometimes it's a glob=
al
> setting).
>
> Even if the windowing environment is set to UTF-8, your terminal
> emulator might be set to ISO-8859-something, so check the terminal
> emulator (e.g., rxvt, Terminator, GNOME Terminal, PuTTY, ...).

I use putty which was set to ISO-8859-1. Changing this to UTF-8 gave me=
=20
the correct result:
$ echo Noralf Tr=F8nnes | xxd
0000000: 4e6f 7261 6c66 2054 72c3 b86e 6e65 730a  Noralf Tr..nnes.

Thank you all for helping me!
