From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Thu, 30 Apr 2015 10:21:35 +0200
Message-ID: <5541E60F.1070403@alum.mit.edu>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com> <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Koosha Khajehmoogahi <koosha@posteo.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	=?UTF-8?B?Tmd1?= =?UTF-8?B?eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:21:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnjjA-0006Ad-4N
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 10:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbD3IVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 04:21:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48932 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225AbbD3IVl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 04:21:41 -0400
X-AuditID: 1207440c-f79376d00000680a-3c-5541e61282dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 14.17.26634.216E1455; Thu, 30 Apr 2015 04:21:38 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A01.dip0.t-ipconnect.de [79.201.122.1])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3U8LZbc027020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 30 Apr 2015 04:21:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsUixO6iqCv0zDHUYFG3rsWaF6eZLbqudDNZ
	NPReYbZYcXUOs0X/8i42i7c3lzBabJuzitWie8pbRosfLT3MFq0f7jA5cHm0Tp7E7LFz1l12
	jw8f4zye9e5h9Lh4Sdnj12FRj8+b5ALYo7htkhJLyoIz0/P07RK4M5a8fMlW8Jer4tL/DvYG
	xpccXYycHBICJhKTO3rZIGwxiQv31gPZXBxCApcZJRo+f2WBcM4xSWzd2cAIUsUroC2xdtE3
	sA4WAVWJhz2fWEFsNgFdiUU9zUwgtqhAkETrtalQ9YISJ2c+YQGxRQSyJJp3vGIGGcos8JtJ
	4u/RbewgCWEBe4m/33+DDRISyJR4fGQSWDOngLVE195+oGYOoAZ1ifXzhEDCzALyEtvfzmGe
	wCgwC8mKWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREiU8
	Oxi/rZM5xCjAwajEwzuj1TFUiDWxrLgy9xCjJAeTkiivwlOgEF9SfkplRmJxRnxRaU5q8SFG
	CQ5mJRHew4+AcrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd4TT4Aa
	BYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRGl8MjFWQFA/QXkOQm3iLCxJzgaIQ
	racYdTnm3Py9iEmIJS8/L1VKnLcDZIcASFFGaR7cClhKfMUoDvSxMK8ayCgeYDqFm/QKaAkT
	0JLztxxAlpQkIqSkGhhtuLb7GgU/jzy7S+n4zsXPww+wBu1h/lTyNMb7iHnZzQ3H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268064>

On 04/30/2015 12:42 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>> ...
> 
> There are a handful of topics that are almost there but not
> finished.  Could the topic owners and area submaintainers who are
> involved in them report their current status soonish, please, to
> help me decide to keep or discard them?
> 
> [...]
>> * mh/fdopen-with-retry (2015-03-06) 6 commits
>>  - buffer_fdinit(): use fdopen_with_retry()
>>  - update_info_file(): use fdopen_with_retry()
>>  - copy_to_log(): use fdopen_with_retry()
>>  - fdopen_lock_file(): use fdopen_with_retry()
>>  - SQUASH??? $gmane/264889
>>  - xfdopen(): if first attempt fails, free memory and try again
>>
>>  Various parts of the code where they call fdopen() can fail when
>>  they run out of memory; attempt to proceed by retrying the
>>  operation after freeing some resource.

Since we haven't heard anything from Jonathan (who originally suggested
this change) and since nobody else seems to be able to muster much
enthusiasm for it, let's discard this one. It's probably too much code
to invest in a theoretical problem that AFAIK has never been observed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
