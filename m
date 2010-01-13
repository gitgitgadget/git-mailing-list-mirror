From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in summary
Date: Wed, 13 Jan 2010 19:50:36 +0100
Message-ID: <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
References: <20100113173408.GA16652@coredump.intra.peff.net> <20100113173951.GC16786@coredump.intra.peff.net> <1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com> <20100113184510.GA22849@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8SQ-0006cT-HU
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab0AMTAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 14:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769Ab0AMTAh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:00:37 -0500
Received: from outmail136191.authsmtp.com ([62.13.136.191]:63564 "EHLO
	outmail136191.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751068Ab0AMTAg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:00:36 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2010 14:00:36 EST
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt6.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o0DIohE2076411;
	Wed, 13 Jan 2010 18:50:43 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o0DIof7d033566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jan 2010 18:50:42 GMT
Received: from [192.168.1.2] (133.Red-88-5-247.dynamicIP.rima-tde.net [88.5.247.133])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o0DIoaou000742
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 13 Jan 2010 13:50:39 -0500
In-Reply-To: <20100113184510.GA22849@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 8d244d0f-0074-11df-80b9-0022640b883e
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH ax0dDFNVdwdEHAkR Am4BXlReVF8/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwUceENX AUoeURp3cQMIeXpy Y0YsViRZWEAudRBg Qk5TEXAHZDM2dWgf AklFdwNWcgVOfk1N YlMqGhFYa3VsBgsE NC97IWp5ZnIEHWxe RQQILE5ACV0LGSF0 RhYeEC8iBlEEQSp7 LhArLEJUHUAfNV83 OEcgXlRQMhlaERBb GkhXEUcA
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136858>

El 13/01/2010, a las 19:45, Jeff King escribi=F3:

> On Wed, Jan 13, 2010 at 07:39:47PM +0100, Wincent Colaiuta wrote:
>
>>> Your name and email address were configured automatically based
>>> on your username and hostname. Please check that they are accurate.
>>> You can suppress this message by setting them explicitly:
>>>
>>>    git config --global user.name Your Name
>>>    git config --global user.email you@example.com
>>>
>>> If the identity used for this commit is wrong, you can fix it with:
>>>
>>>    git commit --amend --author=3D'Your Name <you@example.com>'
>>>
>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> I'll never see this message myself, but I think you could (and
>> perhaps should) replace almost all of that with:
>>
>>  Your name and email address were configured automatically.
>>  See "git config help" for information on setting them explicitly
>>  or "git commit help" if you wish to amend this commit.
>
> I don't have a huge problem with your wording, except that it needs
> s/(\w+) help/help \1/.

Whoops.

> Mainly I was trying to hand-hold because not having this information =
=20
> set
> up means it may be your first commit, and you are probably a bit
> clueless (the exceptions are people who have been using git, but are
> seeing this new behavior in their new version, and people who have gi=
t
> configured on another machine but are using _this_ machine for the =20
> first
> time).

=46air enough, but I'm sighing here at the thought of people jumping in=
 =20
and using git commands without even having looked at _any_ of the =20
zillions of "your first 10 minutes with Git" tutorials out there, =20
which pretty much _all_ start with how to set up your user.name and =20
user.email...

Cheers,
Wincent
