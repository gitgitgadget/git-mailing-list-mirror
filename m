From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/23] expire_reflog(): remove unused parameter
Date: Fri, 05 Dec 2014 13:43:54 +0100
Message-ID: <5481A88A.7050509@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> <1417734515-11812-5-git-send-email-mhagger@alum.mit.edu> <20141204232853.GD16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 13:44:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwsF3-0003BJ-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 13:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaLEMoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 07:44:08 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59896 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbaLEMoH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 07:44:07 -0500
X-AuditID: 1207440c-f79376d00000680a-44-5481a88ca5f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.2C.26634.C88A1845; Fri,  5 Dec 2014 07:43:56 -0500 (EST)
Received: from [192.168.69.130] (p5DDB07F3.dip0.t-ipconnect.de [93.219.7.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB5ChsbX029064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 5 Dec 2014 07:43:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141204232853.GD16345@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqNuzojHE4MNeY4uuK91MFg29V5gt
	3t5cwmjR2/eJ1WLz5nYWB1aPnbPusnss2FTqcfGSssfnTXIBLFHcNkmJJWXBmel5+nYJ3Bl7
	X79jL9jFWbHm5Sm2BsYL7F2MnBwSAiYSRy+vgrLFJC7cW8/WxcjFISRwmVFibs9/dgjnLJPE
	tvOHwKp4BbQlLs38yAhiswioSvyb/gYsziagK7Gop5kJxBYVCJI4uec6VL2gxMmZT1hAbBEB
	DYnnn76BbWAWmMIocfDbPzaQhLCAs8TxlgaobQsZJQ4dvQq0gYODU8BAovOiLEgNs4CexI7r
	v1ghbHmJ7W/nME9gFJiFZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJeb
	WaKXmlK6iRES2jw7GL+tkznEKMDBqMTDu0KiMUSINbGsuDL3EKMkB5OSKC/PIqAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd7k2UA53pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IEb+xyoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4ULTGFwPjFSTFA7Q3
	AaSdt7ggMRcoCtF6ilFRSpy3CiQhAJLIKM2DGwtLWK8YxYG+FOb9BlLFA0x2cN2vgAYzAQ2+
	Www2uCQRISXVwKhZuDNy2pl/hpUX9xfMy4xZkuHIOV/O/XbSsnud2R96Nkee3nzOu9ym/vjO
	nxtevDX7UTTLyn+3gPftU7P2+WxU5AnJmPY+e6LZqR9TXy/UfBT9vebV8Z2P6uX4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260868>

On 12/05/2014 12:28 AM, Jonathan Nieder wrote:> Michael Haggerty wrote:
>> It was called "unused", so at least it was self-consistent.
>
> The missing context is that this was a callback function that had to
> match the each_ref_fn signature [...]
>
> With or without a note in the commit message explaining that,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]

>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -349,7 +349,7 @@ static int push_tip_to_list(const char *refname,
const unsigned char *sha1, int
>>  	return 0;
>>  }
>>
>> -static int expire_reflog(const char *ref, const unsigned char *sha1,
int unused, void *cb_data)
>> +static int expire_reflog(const char *ref, const unsigned char *sha1,
void *cb_data)
>>  {
>>  	struct cmd_reflog_expire_cb *cmd = cb_data;
>
> On second thought: why not update the last parameter to be a 'struct
> cmd_reflog_expire_cb *' instead of 'void *' while at it, like this?
> [...]

Thanks for the explanation, the review, and the suggestion. I will
expand the commit to be "don't implement each_ref_fn anymore" and
incorporate all of your suggestions.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
