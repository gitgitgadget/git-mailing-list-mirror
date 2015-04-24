From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/5] status: document the -v/--verbose option
Date: Fri, 24 Apr 2015 18:46:49 +0200
Message-ID: <553A7379.6030408@alum.mit.edu>
References: <CAM=ud8zLDTYUp12BsVjWH5=8rg=HxbtdBxL2L9x=3+FQVJBqrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Pete Harlan <pchpublic88@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 18:47:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylgkn-0004xR-BK
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 18:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757142AbbDXQq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 12:46:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55189 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965348AbbDXQq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 12:46:56 -0400
X-AuditID: 1207440c-f79376d00000680a-5d-553a737ce7f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id CE.26.26634.C737A355; Fri, 24 Apr 2015 12:46:52 -0400 (EDT)
Received: from [192.168.69.130] (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OGkoOp023274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 12:46:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAM=ud8zLDTYUp12BsVjWH5=8rg=HxbtdBxL2L9x=3+FQVJBqrQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqFtTbBVq8OCBqMWaF6eZLbqudDNZ
	NPReYbZ42HuE1YHFo3XyJGaPnbPusntcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xvtZ91kL
	DnBU7Ho5iamB8R5bFyMnh4SAicT7u79YIGwxiQv31gPFuTiEBC4zSky6upoFwrnAJHH/bgtY
	Fa+AtsSRTUuYQWwWAVWJLy+eMYLYbAK6Eot6mplAbFGBIInWa1MZIeoFJU7OfALUy8EhIuAt
	sWhjJEiYWcBFYsq3vawgtrCAo8Sul3/ByoUEAiRu/n4DFucUCJR4v+o5G0S9usSfeZeYIWx5
	ie1v5zBPYBSYhWTDLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pS
	uokREs48Oxi/rZM5xCjAwajEw+swyzJUiDWxrLgy9xCjJAeTkiivd4pVqBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiURXvN0oBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoND
	SYL3ZiFQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoUuOLgbEKkuIB2jsTpJ23
	uCAxFygK0XqKUVFKnDelCCghAJLIKM2DGwtLUq8YxYG+FObdBtLOA0xwcN2vgAYzgQxeagEy
	uCQRISXVwJgX/y1nkeiW69/5NB0jvS/b/Yrp/cCeypWpHDd5TVzU+7mlO7qW3eR64y/33Hfr
	1+xIuxrHPyJ2J859/toSyutpWXJ+qkvET5EnXe1P9haVMv9TSbu2Ynahsr/1H8t/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267743>

On 04/24/2015 02:27 AM, Pete Harlan wrote:
> Junio writes:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Document `git status -v`, including its new doubled `-vv` form.
>>>
>>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>> ---
>>
>> Will queue on mg/status-v-v series, which did add description for
>> "commit -v", but "status -v" did not have the description to begin
>> with and we missed it.
> [...]
>>> +-v::
>>> +--verbose::
>>> + In addition to the names of files that have been changed, also
>>> + show the textual changes that are staged to be committed
>>> + (i.e., like the output of `git diff`). If `-v` is specified
> 
> Should this be `git diff --cached`?
> 
>>> + twice, then also show the changes in the working tree that
>>> + have not yet been staged (i.e., like the output of `git diff
>>> + --cached`).
> 
> ...and should this just be `git diff`?

Yes, you're right. Thanks for catching this, Pete. The shorter the
patch, the higher the error density :-(

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
