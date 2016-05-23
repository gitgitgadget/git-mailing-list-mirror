From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Mon, 23 May 2016 06:31:53 +0200
Message-ID: <574287B9.4090307@web.de>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
 <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
 <20160522080316.GA19790@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 23 06:32:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hXY-0004HZ-Io
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbcEWEcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 00:32:19 -0400
Received: from mout.web.de ([212.227.17.11]:53072 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbcEWEcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 00:32:18 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Mg7Dt-1asxR33yxp-00NRtB; Mon, 23 May 2016 06:31:57
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160522080316.GA19790@glandium.org>
X-Provags-ID: V03:K0:K3WqqQZAfQiypfZXQ4D3xsB3C5gB+XLZ6Ee18M4qNB1MgA7AlrX
 B7+MiZQEjjNw+0oUb0T6R4DGkbNY2hGLuLdhgML4n2sa6qy+R0fmn20UkdN5GXkrnYcIPLp
 4cDsEeU36xyVjAOP6Ax2HIR2oXoBg2P6iVrmE4585JZVhxcfpFF8FcllEod9BL3IRYMh6du
 z0BoWLT1EFK/tkRoM7ggg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ftFIKrqIALE=:0c8sLxrp+YzrcDG+rJfAon
 x3mJGBoPZJJdZIbFjcHhm/h9mVy0BLF1wJ+w9tiPCpgOmvIaymMAluILUAbApNMp+qjegxbmZ
 Gr+UgA/2EFWHPBlXs37XAeklLuqEv8xfiwi/YO+Jc1tsgktuSyAR/9zomeELsoeOTRpDTP+gB
 hD6pGdJ6GWbrZRFiGxfZJdjCtKb3gLNrSqSESymOz9VoJBepde7VG2/o3+dEmqPQ6F5UVK5lA
 uvoiaiV8srFYSjzLkIPrFWUYqrgx3Bmd/2iVbZ4Nt30of/aCdnm1AxZ603UkZlzk6ycfXBAMz
 d1VHSw+RnUeFQu85TaNp8ZDk4But3XpV1ge8HOvevODFGE0hlb8n4iMgg/iwQYPpJbxZ5y/aP
 UGUZyhInxviIruTB7tZwU8OB6UXC2Udhxt5NnmhVcN1OdIT7ekwJxtwFb4UXuGBU7j6BbkEyq
 zujm3jMl5PIY32yu14+c2CCE4B4Xb1c0YR09XWjimGxg8Na5loTQNGNfqWKxy9t2XlyDv/4X5
 6bC8zVwlEHOsXO9GLMYyo0H6Kax2VB2ioDUbowH5K7bNJuRflkEC77oVa06eOv4SzPUQP9l3P
 wqKLP6m+RT5epmwpbIsT3RCPb++ZpWggIM9FKqKo3hX7kiJ1B8zJFqiJMu5svT1abKD2b5fZh
 Gm/6ClbHbmDHCfamOv0lZDhs+GMlWeL2NcLZf42oYcFeWganwbUqSe6K2y8oICvqKqdSkG+Nz
 RM2e9PIV3wegJl8bPxwzU9pllhTprW3CronxvbbwZ9VF3U4jF1liUbI29EHtt+x9WdBGGcoI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295305>

On 05/22/2016 10:03 AM, Mike Hommey wrote:
> On Sun, May 22, 2016 at 08:07:05AM +0200, Torsten B=F6gershausen wrot=
e:
>> On 22.05.16 01:17, Mike Hommey wrote:
>>> Signed-off-by: Mike Hommey <mh@glandium.org>
>>> ---
>>>   connect.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/connect.c b/connect.c
>>> index c53f3f1..caa2a3c 100644
>>> --- a/connect.c
>>> +++ b/connect.c
>>> @@ -742,6 +742,12 @@ struct child_process *git_connect(int fd[2], c=
onst char *url,
>>>   			transport_check_allowed("ssh");
>>>   			get_host_and_port(&ssh_host, &port);
>>>  =20
>>> +			/* get_host_and_port may not return a port even when
>>> +			 * there is one: In the [host:port]:path case,
>>> +			 * get_host_and_port is called with "[host:port]" and
>>> +			 * returns "host:port" and NULL.
>>> +			 * In that specific case, we still need to split the
>>> +			 * port. */
>> Is it worth to mention that this case is "still supported legacy" ?
> If it's worth mentioning anywhere, it seems to me it would start with
> urls.txt?
>
> Mike
>
I don't know.
urls.txt is for Git users, and connect.c is for Git developers.
urls.txt does not mention that Git follows any RFC when parsing the
URLS', it doesn't claim to be 100% compliant.
Even if it makes sense to do so, as many user simply expect Git to acce=
pt
RFC compliant URL's, and it makes the development easier, if there is a=
n=20
already
written specification, that describes all the details.
The parser is not 100% RFC compliant, one example:
- old-style usgage like "git clone [host:222]:~/path/to/repo are suppor=
ted
To easy the live for developers, it could make sense why the code is as=
=20
it is,
simply to avoid that people around the world suddenly run into problems=
,
when they upgrade the Git version.
So if there is a comment in the code, it could help new developers to=20
understand
things easier.
