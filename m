From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Thu, 03 Mar 2011 11:42:09 +0900
Message-ID: <buo4o7kc4ce.fsf@dhlpc061.dev.necel.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
 <4D6CD593.2090705@drmicha.warpmail.net>
 <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
 <4D6CDF20.3020701@drmicha.warpmail.net>
 <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
 <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
 <4D6D0A51.9030701@drmicha.warpmail.net>
 <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com>
 <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com>
 <4D6E4246.5080407@drmicha.warpmail.net>
 <7vhbblcvl7.fsf@alter.siamese.dyndns.org>
 <4D6E7EF0.5040106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 03:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuyUd-0005Lv-OC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 03:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248Ab1CCCmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 21:42:14 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:50078 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab1CCCmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 21:42:13 -0500
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHG008C8NICMX10@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Thu, 03 Mar 2011 11:42:12 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHG003W2NICLPE0@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Thu, 03 Mar 2011 11:42:12 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
	id 77FD318079; Thu, 03 Mar 2011 11:42:11 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
	by relmlac3.idc.renesas.com (Postfix) with ESMTP id 01ADB18096; Thu,
 03 Mar 2011 11:42:11 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac3.idc.renesas.com with ESMTP id MAF01573; Thu,
 03 Mar 2011 11:42:10 +0900
X-IronPort-AV: E=Sophos;i="4.62,256,1297004400";   d="scan'208";a="14480956"
Received: from unknown (HELO relay31.aps.necel.com) ([10.29.19.54])
 by relmlii1.idc.renesas.com with ESMTP; Thu, 03 Mar 2011 11:42:10 +0900
Received: from relay31.aps.necel.com ([10.29.19.54] [10.29.19.54])
 by relay31.aps.necel.com with ESMTP; Thu, 03 Mar 2011 11:42:10 +0900
Received: from dhlpc061 ([10.114.97.66] [10.114.97.66])
 by relay31.aps.necel.com with ESMTP; Thu, 03 Mar 2011 11:42:10 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id E0BFC52E1D6; Thu,
 03 Mar 2011 11:42:09 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4D6E7EF0.5040106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168368>

Michael J Gruber <git@drmicha.warpmail.net> writes:
>>  Would this ':'
>> trick affect that argument?  If a command is relative to the cwd with no
>> pathspec, you can now give a single ':' to affect the whole tree.
>
> In my view yes. I would even say: If we don't change every single
> command to repo-wide default there is no need to change (and break
> things) if we have an easy one-character way of saying "repo-wide".

... except, of course that the current state is still confusingly
inconsistent.  Even if ":" is available, and even if somebody knows
about it, they won't use it unless they know they have to because people
are lazy, particularly when typing at the command-line.

There will _still_ be tons of times when people don't realize they're in
a subdirectory, and so need ":", or don't realize that command X doesn't
follow the majority of commands in using the "no args = root relative"
behavior.  So the current state of things is still somewhat dangerous
for users.

Something like ":" would be a great feature for scripting though.

-Miles

-- 
Discriminate, v.i. To note the particulars in which one person or thing is,
if possible, more objectionable than another.
