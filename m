From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Mon, 21 Sep 2015 11:14:49 +0200
Message-ID: <55FFCA89.601@web.de>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com> <1442766131-45017-2-git-send-email-larsxschneider@gmail.com> <55FFB681.50500@diamand.org> <0BCEFDB9-9042-4D42-8775-AC22C3658F71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de
To: Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 11:15:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdxC5-0004Lf-3y
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 11:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbbIUJPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 05:15:19 -0400
Received: from mout.web.de ([212.227.15.3]:53328 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbbIUJPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 05:15:18 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MF3Nr-1ZNlto05Xf-00GHg1; Mon, 21 Sep 2015 11:15:15
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <0BCEFDB9-9042-4D42-8775-AC22C3658F71@gmail.com>
X-Provags-ID: V03:K0:cfa/4ewHN60uPUtiCjsPywFzZxuH3GWsDJnrB73DnLtMJNbN9r6
 8A9djUb6upIFICll+arQsQrc+8saXghMHTzef9YbOZ820Lp7txWUM80HU4zy6vAeE8DhpvB
 24qcLrMi4jRWlXUAxpkLeFBRlv7OGFmoUnWZHJYUqsZecBBrzo5C5C5om340k+yGUZ0oOLM
 aCOiC13XrBK6NLh5suDgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S/NHkbjTFRk=:LvDF5cfCOrRTATMTWAAO4y
 +Utjdz5JUWJ+AnijGfi5qDGCFI5dKfmluY+lJ8ypsqNPy7mBUgIJ+72rTmJzdRI0DrygOPnMO
 +H837/ZnfO1QUbi5IibxpT+mXfJDXdbmArxsfDSBTUXz3JNE9ZoYtVwgoNDHgchhVuf007Ihq
 hjKu209PVWFlD84mCZg0Tqwuf8TyWG53bRh6qHjaYhqfTaqFE7f8KDIjS3On+9WgjISNaiAgI
 VhsIPk85mg9mbeRkFOAU6hvHpmXZUejtw48k3nedouGRnPg6yREWLV0ynOeM+VAPBuF76Ukzx
 ngBjIaA2g+s0zIW+EXg7cSDw/ZoTTsft6S2JGHlAlD9MPELyrem2pPFKa+Ezb9MleS/XprGJR
 FwkfVbIjUH5ER/2eLmegyWKTVo6wm79j3V2FtT4Zqg9mSxWrTY9PxoirSDkUNSitmAndmxMze
 00D0Ur76Gqf+EI3MYGxF9Wu1pFu7UrvftJYTzTwhgaP5QmdKWxRhSC886MdZL+pw5NPcHwrcR
 z/vfwwGCurghCyaoecip6uZUWvKpBitD80JkLy2KapGgCIyjyxEEvPC4mTcAvILOO2Zr9yOAH
 G+OAXpA1KK7SUzo8mfKF5KkrX4n9KB1NofZimfjBzNSDHuFHpYLPBsXfky7Q4jedGwDlBTtMy
 qbl+O0kpDGLYQvEtA7GA/Xj45FONUdl6ChGYLYG1/w5EuzwL6J590D8mt5rAeUFwktMmAKpli
 +a1WA3AJld3/ArnoRWG1RDQCHclAq40U1F5iWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278291>

On 09/21/2015 11:05 AM, Lars Schneider wrote:
> I tried it on OS X 10.9.5 and on Ubuntu Linux 14.04.1 (sed version 4.=
2.2).
>
> The =93-i=94 option is mentioned in the GNU sed docs here:
> https://www.gnu.org/software/sed/manual/sed.html
>
> The OS X sed man page indeed lists =93-i=94 as non-standard option:
> https://developer.apple.com/library/mac/documentation/Darwin/Referenc=
e/ManPages/man1/sed.1.html
>
> What OS/sed version are you using?
>
> Thanks,
> Lars
>
>
sed -i is not portable.
(I think I missed that in the review :-()

The gnu version of sed supports "-i", but the POSIX doesn't:
<http://pubs.opengroup.org/onlinepubs/007904975/utilities/sed.html>
