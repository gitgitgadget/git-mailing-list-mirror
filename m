From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git messes up =?windows-1252?Q?=27=F8=27_character?=
Date: Thu, 22 Jan 2015 10:59:02 +0100
Message-ID: <54C0C9E6.50207@drmicha.warpmail.net>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de> <54BEB7ED.2050103@tronnes.org> <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com> <54BEC75C.3090207@tronnes.org> <CACBZZX5f0ciqmJizYxe+UvKL-g9iDZTca52=9xZP4_qiuEaO3Q@mail.gmail.com> <54BECAE0.70309@tronnes.org> <20150120221802.GJ2350@localhost> <54BED5FF.40107@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?windows-1252?Q?Noralf_Tr=F8nnes?= <notro@tronnes.org>,
	Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 10:59:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEEXk-0007ah-2p
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 10:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbbAVJ7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2015 04:59:08 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52261 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299AbbAVJ7F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 04:59:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7DFC320B20
	for <git@vger.kernel.org>; Thu, 22 Jan 2015 04:59:04 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 22 Jan 2015 04:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ZvDstBax91gukkTTYMTBJl
	3x57w=; b=TmrYkB0nDxaBM2e3zQbka2kweGidCTqCfiCVNvTYsLlcJLweGL1BYB
	l08nD9ZbT6qU1gFVXnPTKTRqFX2U8A28VwZGg5vkICrAlULVnO/M7iTSxm3DCTQY
	O47kzZQAKJIvENDckkm8x+bJp8tAA7vv7TpSNzanGf2r+aHyFVM1k=
X-Sasl-enc: yyBP50Nk4395mRCh+s1S6zAOcDNC7AAVhc6s0uI08aqT 1421920744
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AC18C680106;
	Thu, 22 Jan 2015 04:59:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54BED5FF.40107@tronnes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262812>

Noralf Tr=F8nnes schrieb am 20.01.2015 um 23:26:
> Den 20.01.2015 23:18, skrev Nico Williams:
>> On Tue, Jan 20, 2015 at 10:38:40PM +0100, Noralf Tr=F8nnes wrote:
>>> Yes:
>>> $ echo Noralf Tr=F8nnes | xxd
>>> 0000000: 4e6f 7261 6c66 2054 72f8 6e6e 6573 0a    Noralf Tr.nnes.
>>>
>>> Is there a command I can run that shows that I'm using ISO-8859-1 ?
>>> I need something to google with, my previous search only gave local=
e
>>> stuff, which seems fine.
>> The locale(1) command tells you what your locale is set to, but it
>> doesn't say anything about your input method -- it only tells you wh=
at
>> your shell and commands started from it expect for input and what th=
ey
>> should produce for output.
>>
>> The input method will generally be part of your windowing environmen=
t,
>> for which you'll have to search how to check/configure your OS
>> (sometimes it can be set on a per-window basis, sometimes it's a glo=
bal
>> setting).
>>
>> Even if the windowing environment is set to UTF-8, your terminal
>> emulator might be set to ISO-8859-something, so check the terminal
>> emulator (e.g., rxvt, Terminator, GNOME Terminal, PuTTY, ...).
>=20
> I use putty which was set to ISO-8859-1. Changing this to UTF-8 gave =
me=20
> the correct result:
> $ echo Noralf Tr=F8nnes | xxd
> 0000000: 4e6f 7261 6c66 2054 72c3 b86e 6e65 730a  Noralf Tr..nnes.
>=20
> Thank you all for helping me!
>=20

You can also check the encoding of your config file with

file .git/config

or ":set fileencoding" in vim. ":set fileencoding=3Dutf8" would allow y=
ou
to convert it easily.

(This assumes that the file does not mix encodings.)

Michael
