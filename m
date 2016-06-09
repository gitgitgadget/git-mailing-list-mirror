From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/5] t1404: document function test_update_rejected
Date: Thu, 9 Jun 2016 17:45:51 +0200
Message-ID: <57598F2F.9050806@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
 <2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
 <5756FCF3.7050509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:46:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB29r-0004DJ-9f
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 17:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbcFIPqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 11:46:05 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53663 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752554AbcFIPqE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 11:46:04 -0400
X-AuditID: 1207440f-8a7ff700000008e4-2b-57598f325e22
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DD.98.02276.23F89575; Thu,  9 Jun 2016 11:45:54 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59FjpRR010700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 11:45:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <5756FCF3.7050509@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqGvUHxlu0LyAy2L+phOMFl1Xupks
	GnqvMFs8mXuX2aJ7yltGix8tPcwObB47Z91l93j4qovd41nvHkaPi5eUPRY8v8/u8XmTXABb
	FLdNUmJJWXBmep6+XQJ3xsG2u6wF61grdt2Yw9LAOJ+li5GTQ0LARGJuVyuQzcUhJLCVUWJz
	80dWCOc8k0TPsj42kCphATeJ5WdusIPYIgIKEgf2LYQqWsYoMeXQUSYQh1ngAaPE6WfTGUGq
	2AR0JRb1NDOB2LwC2hI3d/wA6ubgYBFQkXg+0QskLCoQInF+3VZWiBJBiZMzn4CdxCmgIfH0
	zlpGkHJmoDFta2RAwswC8hLb385hnsDIPwtJxyyEqllIqhYwMq9ilEvMKc3VzU3MzClOTdYt
	Tk7My0st0jXRy80s0UtNKd3ECAlv/h2MXetlDjEKcDAq8fBqpESEC7EmlhVX5h5ilORgUhLl
	FeyJDBfiS8pPqcxILM6ILyrNSS0+xCjBwawkwmvaDZTjTUmsrEotyodJSXOwKInzqi9R9xMS
	SE8sSc1OTS1ILYLJynBwKEnwzu8FahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	RWR8MTAmQVI8QHtngLTzFhck5gJFIVpPMRpzLPhxey0Tx5H999YyCbHk5eelSonzivYBlQqA
	lGaU5sEtgiW2V4ziQH8L8+aAVPEAkyLcvFdAq5iAVi0/Eg6yqiQRISXVwOj/jid7zq7Jz9uT
	ZvLGrTqftuu81B6Ng4pXb/FvOMI/QdIgIb3FvpgnW+aoe7JgQrmLiErWljxn3WPH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296895>

On 06/07/2016 06:57 PM, Johannes Sixt wrote:
> Am 07.06.2016 um 13:50 schrieb Michael Haggerty:
>>   test_update_rejected () {
>> +    local prefix before pack create error &&
> 
> Do we want to add more of unportable 'local' declarations?

Sorry, I forgot that `local` is not in the POSIX standard.

According to [1] it's nevertheless very portable. Do you object to
`local` based only on its absence from POSIX, or because it's known to
cause problems in the real world? I ask because it is a convenient
feature (and its lack is a common cause of mysterious errors), so it
would be nice if we could allow its use.

Michael

[1] http://apenwarr.ca/log/?m=201102#28
