From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: O_NONBLOCK under Windows (was: git.git as of tonight)
Date: Wed, 4 Nov 2015 20:59:54 +0100
Message-ID: <563A63BA.9020407@web.de>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
 <5637D266.4060904@kdbg.org>
 <CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
 <56385587.1010601@kdbg.org> <xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbAj-tZS3X1EwFw_gGh1=YU8M0OmEX91W8f++fqs6TiBA@mail.gmail.com>
 <56392106.1010401@kdbg.org>
 <CAGZ79kZM-Q2oxVkMO9=v=tAdJkpWWOTVkaSMRDKZSZia2MY5Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:00:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4ER-00078A-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965449AbbKDUAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:00:14 -0500
Received: from mout.web.de ([212.227.15.4]:55974 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965367AbbKDUAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:00:11 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LgYRZ-1aHYza3Htt-00o2Wv; Wed, 04 Nov 2015 20:59:59
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZM-Q2oxVkMO9=v=tAdJkpWWOTVkaSMRDKZSZia2MY5Ng@mail.gmail.com>
X-Provags-ID: V03:K0:5W6qwMDDJDu3Ru1Z9z/e9fcJ9frv3TJd1YctrLStcxWcE7gGfv7
 u5ilPNopTLYXddn1h6R94rDC9HpJWcBHtLlaU/Ar+rYtNXtn8vmHi7Ky5F+l0WKp+P7H2bG
 vZrirrnzUhqyif7cFSjvDtxPIELG1P/hmj6Y8CKIHO3ZdqHMwM3GdGBq3Gfx68wYsS/JsL9
 74M34mccGwO8oyRMtKX1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HyRGEd9wipA=:+GdeYEeszQO+x/DfciNOYg
 7g4ylUnyBE1eZ3bWEn7ECcTx9lHMZIWIN0fFVi8OMHhh89u5EBx9ordQL+FtDbsnzb2Dul9fl
 MSc1SX+a3D+RwMNCk7ahiUvV2igwzzuOn2Y4qKYmrl6UI5XggowRUG2VV4fWX3Ux3pypcLFBP
 YNHBBIydTieSvfuvf07Pydk3YHXhNGRKXQx960S54w8S9YcVYqYBEwVTEWezquu3iDf0sdUdj
 k4CJW31FDQAbcWXY3AWqjL+O1RsLIMbvkWHnoNyteOZ/PsGFGc4gaLo5lO5HVsM6LC8yfunaO
 K+fIijuVHSM8hMWhp28ZV/82pB41kT+Q5DDZ2gkEscz2191pu5AsqaFmX2C4LdaLCdwFkvWoh
 0z/Dbl4XImjjb73ekzwuGYTAvy/hGzP2y2iiTlvVQyhmbbXb8IEKTPGl33smcpU3v5BQVOps3
 XRH/4sBiRMn+j3xJbamDMJYE4kGUjuULTiHvoAmh62Rghd/1EiJfUUWMjKZA3MeUjhQ3k+61f
 vzXX7NFU1Ck0DdP3wZh/cICG/sk/BGZ4leQiz0ZPGCAytCroAd/C8R7Av8+8FryCslrkQBaGU
 ajcVEt7dTkogZaLzCAc7TKILwcGvg2wQgl0+MI7OvB7Cs0GyQAnaNvpJPm7uIbzCGTG49I4e8
 QDp0AZ/YZxhsfVgRW4MoKegPnWaZ5Ioz8ORi0z6oZ08urqonfmXmojSVsv8eXMtM/3mJ1pCnD
 baATUIDsxYjygeC5YP87EXX+5WEPIgTnqsRozxYcyaglNirdoPWGPY2+UUOH+Dv8pywo6cJ8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280875>

On 11/04/2015 12:00 AM, Stefan Beller wrote:
> On Tue, Nov 3, 2015 at 1:03 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>
The #ifdef assumes that Windows never will have O_NONBLOCK/F_GETFL)

Does the following make more sense ?
#if defined (O_NONBLOCK) && defined (F_GETFL)

Or may be:
#ifndef NO_O_NONBLOCK
>> #ifndef GIT_WINDOWS_NATIVE
>>         int flags = fcntl(fd, F_GETFL);
>>         if (flags < 0)
>>                 warning("Could not get file status flags, "
>>                         "output will be degraded");
>>         else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
>> #endif
>>                 warning("Could not set file status flags, "
>>                         "output will be degraded");
>> }
>>
>>
>>
>>   
>>
