From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Subject: Re[2]: Merge two different repositories (v2.4 + v2.5) into the one (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 17:58:01 +0300
Message-ID: <1208283037.20110111175801@mail.ru>
References: <746745466.20110111134101@mail.ru> <20110111114943.40890@gmx.net> <76067992.20110111153329@mail.ru> <4D2C500F.6070203@op5.se>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Martin_Kr=C3=BCger?= <martin.krueger@gmx.com>,
	<git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jan 11 15:58:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcffm-0001rl-IX
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 15:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab1AKO6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 09:58:05 -0500
Received: from smtp13.mail.ru ([94.100.176.90]:43483 "EHLO smtp13.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab1AKO6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 09:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=KT7djnjf5TRiCZ+5qoZP8kVEp2ROvHW/xdIfGU0Y7bw=;
	b=SE7W0ZQXWI2H+cvQlwZ2Ipj0fKa6x5aHMVHfUEH/wH5D3CranDugVBaMF705Qvta7M5owhUvh6Aeo8ilBV9/HgUlJHgLMwOppKvGoHYMWNonYPgdnrOlM+Byl7mnkqX1;
Received: from [85.140.106.43] (port=48947 helo=ppp85-140-106-43.pppoe.mtu-net.ru)
	by smtp13.mail.ru with asmtp 
	id 1Pcffe-0000E3-00; Tue, 11 Jan 2011 17:58:02 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <4D2C500F.6070203@op5.se>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164951>


AE> On 01/11/2011 01:33 PM, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =
=D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD wrote:
>> Thank you for the answer, but it's not what I want ))
>> Applying patches is the same as rebasing, I guess.
>> But I do not want to change v2.5-repo (let's call it so) that much.
>> I'd like to know is there any method (low-level I suppose, as far as=
 Git
>> manages tree-objects as files) to make v2.4 LAST commit to be the
>> parent of v2.5 FIRST commit?
>>=20

AE> You want grafts. Check them up in the docs. Googling for "git graft=
"
AE> should get you a good starting point.

Yes, you`re right, but unfortunately grafts ('info/grafts' file) cannot=
 be cloned unless
'git filter-branch' is executed, but this command changes all the
"v2.5-repo" which is "equivalent" to 'git rebase' and what I aspire
to avoid.

But Jakub Narebski <jnareb@gmail.com> gave a solution which suits for
me great.

Thank you for your reply
