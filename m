From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 20:42:19 +0200
Message-ID: <553FD48B.1010608@kdbg.org>
References: <553CD3DA.9090700@web.de> <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com> <20150427061115.GB2766@camelia.ucw.cz> <553E86BD.7030401@kdbg.org> <553E91CD.9060205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stepan Kasal <kasal@ucw.cz>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 20:42:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnASi-0002um-AD
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 20:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030834AbbD1SmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 14:42:24 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:22557 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030569AbbD1SmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 14:42:23 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lbsK902Pdz5tlJ;
	Tue, 28 Apr 2015 20:42:20 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B662B5240;
	Tue, 28 Apr 2015 20:42:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <553E91CD.9060205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267932>

Am 27.04.2015 um 21:45 schrieb Torsten B=F6gershausen:
> On 04/27/2015 08:58 PM, Johannes Sixt wrote:
>> Am 27.04.2015 um 08:11 schrieb Stepan Kasal:
>>> Git does not support CRLF as the internal line separator.
>>> If you commit file in binary mode with CRLF, you are on your own.
>>
>> When I commit my C source code files with CRLF into the repository
>> (because I do not set any line ending options or configurations or a=
ny
>> 'text' attributes or similar), do I then commit binary files or text
>> files? Should I expect not to see any diffs?
>>
>> -- Hannes
>>
> You commit files with CRLF in the repo.
> If you have CRLF in the working tree, things are as follows:
>
> core.autocrlf=3Dfalse   : "Same as binary, no changes"
> core.autocrlf=3Dtrue    : "Normalization is suppressed, (CRLF in repo=
), and therefore no changes.
> core.autocrlf=3Dinput   : "Normalization wanted, (CRLF in repo), norm=
alization will be done
>                                                 (and should be commit=
ted as soon as possible)

I set none of these. But I do commit CRLF and expect to get CRLF back.=20
Am I commiting binary files? Am I doing something that "Git does not=20
support"? Am I "on [my] own"?

-- Hannes
