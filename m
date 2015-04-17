From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2]  t0027: Support =?UTF-8?Q?NATIVE=5FCRLF?=
Date: Fri, 17 Apr 2015 21:37:47 +0200
Organization: gmx
Message-ID: <6e6620d53e9378d3c539c3d1f9cdac0d@www.dscho.org>
References: <55312A45.8060008@web.de> <55313C3C.1090504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:37:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjC5M-0001UG-Jh
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 21:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbbDQThv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 15:37:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:56226 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbbDQThu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 15:37:50 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MWk3f-1Ypzbb2RsB-00Xqh7; Fri, 17 Apr 2015 21:37:48
 +0200
In-Reply-To: <55313C3C.1090504@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:vEaHoTcM0BIYp++QnneTcIJg0IagakKWVomjw41ooVy7/PT9e5a
 Hf5faQtTBxcugQI8vqLy5EVCn4SeJZVnWbhVEQiQVLCLUkQKShv9sZeKMY0I7m/dk0j8CjC
 nXgh7z/QXDsd34lgbNi0JhgWeR+b0zwxeuwgLU8dBTIlKSBcaeZO4Sa9NUdbiHktWtOEw0J
 ucM09iaiMwLYiJwDy+7BA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267382>

Hi Torsten,

On 2015-04-17 19:00, Torsten B=C3=B6gershausen wrote:
> On 2015-04-17 17.44, Torsten B=C3=B6gershausen wrote:
>> Without this patch, t0027 expects the native end-of-lines to be a si=
ngle
>> line feed character. On Windows, however, we set it to a carriage re=
turn
>> character followed by a line feed character. Thus, we have to modify
>> t0027 to expect different warnings depending on the end-of-line mark=
ers.
>>
>> Adjust the check of the warnings and use these macros:
>>   WILC:  Warn if LF becomes CRLF
>>   WICL:  Warn if CRLF becomes LF
>>   WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF
>>
>> Improve the information given by check_warning():
>> Use test_cmp to show which warning is missing (or should'n t be ther=
e)
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Originally I wanted to have Dscho as "Author", is that OK with you ?
> (But the "From:" line didn't made it through my email program)

No worries.
Dscho
