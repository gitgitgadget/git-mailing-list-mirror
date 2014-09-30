From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Tue, 30 Sep 2014 15:41:55 +0200
Message-ID: <542AB323.4080402@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu> <xmqq8ul6869o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 15:42:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYxgy-0002wE-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 15:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbaI3NmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 09:42:07 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53088 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908AbaI3NmF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 09:42:05 -0400
X-AuditID: 1207440e-f79da6d0000002fc-45-542ab326160d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B8.EC.00764.623BA245; Tue, 30 Sep 2014 09:41:58 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741E.dip0.t-ipconnect.de [79.201.116.30])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8UDftft002534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 30 Sep 2014 09:41:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqq8ul6869o.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqKu2WSvEoH+HuEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBn9Oy+wFbwhb3i6fN+1gbG5WxdjJwcEgImEvNW7WCG
	sMUkLtxbDxTn4hASuMwo8fzKIRYI5zyTxJoN89hBqngFtCWaH00F62ARUJU43f+FEcRmE9CV
	WNTTzARiiwoESHzofMAIUS8ocXLmExYQW0RATWJiG8RQZoEvjBJ3590DO0NYwF/i1Ip9jBDb
	1jBKtB/dD5bgFLCWuHD5PthmZgF1iT/zLjFD2PISzVtnM09gFJiFZMksJGWzkJQtYGRexSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrrJebWaKXmlK6iRESDXw7GNvXyxxiFOBgVOLhTVDUChFi
	TSwrrsw9xCjJwaQkytu1EijEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDd4NlCONyWxsiq1KB8m
	Jc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBK7MJqFGwKDU9tSItM6cEIc3EwQkynEtK
	pDg1LyW1KLG0JCMeFK/xxcCIBUnxAO19vhFkb3FBYi5QFKL1FKMux7rOb/1MQix5+XmpUuK8
	ciBFAiBFGaV5cCtgqe8VozjQx8K86iCX8ADTJtykV0BLmICWpG1QB1lSkoiQkmpgXFgn1ByR
	+2+Kw3Mvo1JeZdtSVoeV/4KDZFqrViv3eyUv+Op/sYtRpei99uY+l9tXk3PPrtHh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257668>

On 09/26/2014 10:40 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +If you need to close the file descriptor you obtained from a
>> +`hold_lock_file_*` function yourself, do so by calling
>> +`close_lock_file`. You should never call `close(2)` yourself!
> 
> This is sometimes untenable, isn't it?  A caller may want to
> freopen(3) a stream on the fd to write into it and then fclose(3);
> which would not know to call close_lock_file() but calls close(2).

You are absolutely correct. I carried this text over from the old
version, where it was just as inaccurate.

I didn't fix it because IMO the correct fix is to add a stdio-oriented
entry point to the lockfile API, and teach the lockfile code to handle
closing the FILE correctly when necessary.

But I didn't want to add even more changes to this patch series, so I am
working on this as a separate patch series. I hope to submit it soon.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
