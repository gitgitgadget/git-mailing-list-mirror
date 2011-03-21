From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Is there some env variable like GIT_LANG (like LANG)?
Date: Mon, 21 Mar 2011 21:36:36 +0100
Message-ID: <4D87B6D4.3040601@dirk.my1.cc>
References: <4D879E11.6040609@dirk.my1.cc>	<7vipvcp8e3.fsf@alter.siamese.dyndns.org>	<4D87ABA5.1030609@dirk.my1.cc> <AANLkTikXsYONY5rUSF5138bQ=R4gCopOO8fu=3np+c98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lqP-0006cc-Rb
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab1CUUgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 16:36:42 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:57096 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab1CUUgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:36:41 -0400
Received: from [84.176.60.154] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q1lqA-0001Hi-JX; Mon, 21 Mar 2011 21:36:38 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <AANLkTikXsYONY5rUSF5138bQ=R4gCopOO8fu=3np+c98@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169665>

Am 21.03.2011 21:30 schrieb Lasse Makholm:
> 2011/3/21 Dirk S=FCsserott<newsletter@dirk.my1.cc>:
>> Am 21.03.2011 20:43 schrieb Junio C Hamano:
>>>
>>> Dirk S=FCsserott<newsletter@dirk.my1.cc>    writes:
>>>
>>>> What would you think of it?
>>>
>>> Strongly negative.  I don't want force people to set GIT_LANG HG_LA=
NG
>>> CVS_LANG and 47 different FROTZ_LANG environment variables.
>>>
>>> I would rather just set LANG=3DC LC_ALL=3DC in the terminal I use g=
it in and
>>> leave everything else in whatever locale the rest of the system is =
in.
>>>
>>
>> Ok. Accepted. Was just a question. I see your point.
>
> Alternatively, you might like something like the following in your .b=
ashrc:
>
> function git
> {
>      LANG=3DC command git "$@"
> }
>

Hmm. Looks interesting. I'll try it out. I'm not so shell'ish (more=20
perl'ish) but I expect that to "rename"/"alias" git to the given=20
command. If it works, it's great. Thank you.
