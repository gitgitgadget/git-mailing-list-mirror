From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH 0/8] Make a couple of commands builtin
Date: Wed, 14 Jun 2006 00:03:15 +0200
Message-ID: <448F3623.9010005@etek.chalmers.se>
References: <448F1E41.1040607@etek.chalmers.se> <20060614005437.69ff6a62.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, git@vger.kernel.org,
	=?ISO-8859-1?Q?Lukas_Sandstr?= =?ISO-8859-1?Q?=F6m?= 
	<lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Wed Jun 14 00:03:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqGyp-0000kh-Rk
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 00:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWFMWDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 18:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWFMWDU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 18:03:20 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:60820 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932359AbWFMWDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 18:03:20 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout1-sn1.fre.skanova.net (7.2.072.1)
        id 44892B9600122AA6; Wed, 14 Jun 2006 00:03:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060614005437.69ff6a62.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21816>

Timo Hirvonen wrote:
> Lukas Sandstr=F6m <lukass@etek.chalmers.se> wrote:
>=20
>> This patchseries has the ultimate goal of making
>> git-am a builtin.
>>
>> The version of git-am I'm sending out makes quite heavy
>> use of system(), but I think that can be worked around.
>> I just haven't figured out how, yet.
>=20
> I don't think git-stripspace needs to be a built-in.  It doesn't even
> depend on git.  It is just a tiny helper program used by git-am,
> git-applymbox, git-commit and git-tag.  If all these commands are mad=
e
> built-in then git-stripspace becomes useless.
>=20

The reason I made it builtin was to de able to call it easily from git-=
am.

As you say, once all the users are builtin it could be removed, unless =
somone
is using it in their scripts.

/Lukas
