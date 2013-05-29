From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RESEND v2] path: Fix a sparse warning
Date: Thu, 30 May 2013 00:57:56 +0100
Message-ID: <51A69604.20500@ramsay1.demon.co.uk>
References: <51A3B308.6000201@ramsay1.demon.co.uk> <7vhahn2fz2.fsf@alter.siamese.dyndns.org> <51A606A0.5060101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 30 01:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhqH9-0000Ap-BI
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 01:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967270Ab3E2X7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 19:59:25 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41750 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967257Ab3E2X7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 19:59:24 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 2A1D6384081;
	Thu, 30 May 2013 00:59:23 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 9423C384080;
	Thu, 30 May 2013 00:59:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 30 May 2013 00:59:21 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51A606A0.5060101@web.de>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225902>

Torsten B=F6gershausen wrote:
> On 2013-05-28 19.04, Junio C Hamano wrote:
>>
>> Can you tell me what the conclusion on the discussion on your two
>> other patches on 'pu'?
>>
>> * rj/mingw-cygwin (2013-05-08) 2 commits
>>  - cygwin: Remove the CYGWIN_V15_WIN32API build variable
>>  - mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE
>>
>> I stopped keeping track of the discussion and my vague recollection
>> was that it is OK for 1.5 but not verified on 1.7 or something?
>>
>=20
> The tests I did under cygwin 1.7 did not show any regression.

Thank you for testing this.

ATB,
Ramsay Jones
