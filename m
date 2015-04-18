From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2]  t0027: Support =?UTF-8?Q?NATIVE=5FCRLF?=
Date: Sat, 18 Apr 2015 16:54:03 +0200
Organization: gmx
Message-ID: <7216168da473ed5cda5b16bca236a3ec@www.dscho.org>
References: <55312A45.8060008@web.de>
 <1db9b0b7322c3b8b8e7a76b29b020ad8@www.dscho.org>
 <xmqq8udqpius.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 16:54:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjU8T-0001P9-HA
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 16:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbbDROyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 10:54:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:54146 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbbDROyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 10:54:16 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LwJko-1ZPrik0mDO-0182cU; Sat, 18 Apr 2015 16:54:04
 +0200
In-Reply-To: <xmqq8udqpius.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:2h0caC3XdM4u7MfhXx5Cmop29yOk5R4jPs+o4+QGt9PQ2JAT6Xg
 +MEZaiPx71Ap+21hDtqg8XxWaCFlrz8rnFL3fwLGa0H3mXNsMTEXDmDdQUhmIVFjaKwOHtS
 Vjm7bAF9qwY33ORXNv0zKeVs4WNSodbWW/PSvYbuRfwRe8PEVm6tWlb227seRip7lUdJ4x8
 toCKu6HM2C326zoobddPQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267421>

Hi Junio,

On 2015-04-17 23:04, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
>> On 2015-04-17 17:44, Torsten B=C3=B6gershausen wrote:
>>> Without this patch, t0027 expects the native end-of-lines to be a s=
ingle
>>> line feed character. On Windows, however, we set it to a carriage r=
eturn
>>> character followed by a line feed character. Thus, we have to modif=
y
>>> t0027 to expect different warnings depending on the end-of-line mar=
kers.
>>>
>>> Adjust the check of the warnings and use these macros:
>>>   WILC:  Warn if LF becomes CRLF
>>>   WICL:  Warn if CRLF becomes LF
>>>   WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF
>>>
>>> Improve the information given by check_warning():
>>> Use test_cmp to show which warning is missing (or should'n t be the=
re)
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> Thank you so much!
>> Dscho
>=20
> Thanks, is that "Acked-by: Dscho" for both patches?

Oops, yes:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Sorry!
Dscho
