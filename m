From: Eugene Letuchy <eletuchy@facebook.com>
Subject: Re: [PATCH] Make git blame date output format configurable, a la
 git log
Date: Fri, 20 Feb 2009 05:57:33 -0800
Organization: Facebook
Message-ID: <499EB6CD.1060800@facebook.com>
References: <1235136252-29649-1-git-send-email-eletuchy@gmail.com> <alpine.DEB.1.00.0902201434460.6302@intel-tinevez-2-302> <499EB647.30606@facebook.com>
Reply-To: "eletuchy@gmail.com" <eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "eletuchy@gmail.com" <eletuchy@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"marius@trolltech.com" <marius@trolltech.com>,
	"gitster@pobox.com" <gitster@pobox.com>,
	Eugene Letuchy <eletuchy@facebook.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Feb 20 17:39:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYPH-0008Tv-0c
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbZBTQhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZBTQhu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:37:50 -0500
Received: from cm.out.snc1.tfbnw.net ([69.63.179.25]:49549 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZBTQht (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:37:49 -0500
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.16] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n1KDvYZZ000828
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 20 Feb 2009 05:57:34 -0800
Received: from eletuchy.local (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.1.340.0; Fri, 20 Feb
 2009 05:57:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1b3pre) Gecko/20090219 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <499EB647.30606@facebook.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-02-20_04:2009-02-10,2009-02-20,2009-02-20 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110861>

Sigh. Make that:
"""
The mailmap test needed to be modified to expect iso formatted blames
rather than the new "default".
"""

- Eugene

On 2/20/09 5:55 AM, Eugene Letuchy wrote:
> Hi Johannes,
>
> Thanks for your feedback. Any comments on the .c changes?
>
> I'll modify the commit message to read as follows:
> """
>
> Add the following:
>    - git config value blame.date that expects one of the git log date
>      formats ({relative,local,default,iso,rfc,short})
>    - git blame command line option --date-format expects one of the git
>      log date formats ({relative,local,default,iso,rfc,short})
>    - documentation in blame-options.txt
>    - git blame uses the appropriate date.c functions and enums to
>      make sense of the date format and provide appropriate data
>
> The tests pass. The mailmap test needed to be modified to expect iso
> formatted blames rather than the new "default".
>
> Signed-off-by: Eugene Letuchy<eugene@facebook.com>
> """
>
> -Eugene
>
> + cc: junio
>
> On 2/20/09 5:40 AM, Johannes Schindelin wrote:
>> Hi,
>>
>> Disclaimer: if you are offended by constructive criticism, or likely to
>> answer with insults to the comments I offer, please stop reading this mail
>> now (and please to not answer my mail, either). :-)
>>
>> Still with me?  Good.  Nice to meet you.
>>
>> Just out of curiosity: why Cc: Marius?  I would have expected Junio, Git's
>> maintainer.
>>
>> May I suggest the commit subject to say "as for git log"?  I mistook "a la
>> git log" for a change in the way git-blame works...
>>
>> On Fri, 20 Feb 2009, eletuchy@gmail.com wrote:
>>
>>> From: Eugene Letuchy<eugene@facebook.com>
>>>
>>> Adds the following:
>> We try to use the imperative form; from my experience it makes for an
>> easier read: "Add the following:"
>>
>>>    - git config value blame.date that expects one of the git log date
>>>      formats ({relative,local,default,iso,rfc,short})
>>>    - git blame command line option --date-format expects one of the git
>>>      log date formats ({relative,local,default,iso,rfc,short})
>>>    - documentation in blame-options.txt
>>>    - git blame uses the appropriate date.c functions and enums to
>>>      make sense of the date format and provide appropriate data
>>>
>>> The tests pass. The mailmap test needed to be modified to expect iso
>>> formatted blames rather than the new "default".
>> IMHO the "The tests pass." should be removed.
>>
>> Other than that, nicely done!
>>
>> Ciao,
>> Dscho
>>
