From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 5/5] t3910: use the UTF8_NFD_TO_NFC test prereq
Date: Mon, 06 Aug 2012 14:44:26 +0200
Message-ID: <501FBC2A.1070403@drmicha.warpmail.net>
References: <7vboj115as.fsf@alter.siamese.dyndns.org> <de831564718b0d52d6ba6e9cb13020defdbfa359.1343641675.git.git@drmicha.warpmail.net> <501CB52D.6080208@web.de> <7vboiq9uv7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 14:44:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyMfj-00034A-So
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 14:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab2HFMo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 08:44:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33970 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755811Ab2HFMo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2012 08:44:28 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 55AC52079C;
	Mon,  6 Aug 2012 08:44:28 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 06 Aug 2012 08:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=MAGQr2JrwQO6XLUd59CA4m
	U7EgY=; b=scdPLrWSZ2dGMHKuWsxlDoUKVkf6+4iSaCLd46yp/Xnk2huJOxiZYQ
	CVpPSS7HwUHAWqEElDWdMKdhJnGq6NVW+WbNmb+9TOIhCvGH+e0ms/6Lz+9JuzfM
	AfqHhfzxBr6cYhpxD3eDC7XWegx/2YAaYWn2GDMwYvwJcpMvlqgkY=
X-Sasl-enc: RcrmGxdl2DIk8amy3SrQ7exl7ZG79C3uQswBmS6CpJZW 1344257067
Received: from localhost.localdomain (unknown [79.199.79.22])
	by mail.messagingengine.com (Postfix) with ESMTPA id 794C08E01FB;
	Mon,  6 Aug 2012 08:44:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <7vboiq9uv7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202963>

Junio C Hamano venit, vidit, dixit 05.08.2012 00:04:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Am 2012-07-30 11:57, schrieb Michael J Gruber:
>> (Sorry being late)
>>
>> That line:
>>> skip_all=3D"filesystem does not convert utf-8 nfd to nfc"
>>
>> shouldn't it be the other way around?
>> skip_all=3D"filesystem does not convert utf-8 nfc to nfd"
>>
>> (and may be the following may be more easy to read:)
>> skip_all=3D"filesystem does not decompose unicode"
>>
>>
>> Side note: t0050 uses another term:
>> "will test on a unicode corrupting filesystem"
>=20
> I am OK with either of the last two.  Thanks for noticing.

I had taken the test description from t3910. But that referred to Git's
undoing of the conversion done by the filesystem...

It's best to have it analogous to t0050 as in Junio's fixup.

Thanks!
Michael
[resent with cc: list...]
