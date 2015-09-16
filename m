From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it
 next time
Date: Wed, 16 Sep 2015 11:28:38 +0200
Message-ID: <55F93646.9050709@alum.mit.edu>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>	<1442108202-25746-1-git-send-email-pclouds@gmail.com>	<xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com> <xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:35:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc983-00084T-CV
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 11:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbbIPJfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 05:35:47 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43509 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbbIPJfp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 05:35:45 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2015 05:35:45 EDT
X-AuditID: 12074411-f797e6d000007df3-30-55f93648dbb0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 36.89.32243.84639F55; Wed, 16 Sep 2015 05:28:40 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96A76.dip0.t-ipconnect.de [79.201.106.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t8G9Scnw023661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Sep 2015 05:28:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqOth9jPUYH+/ucXaZ3eYLLqudDNZ
	NPReYbbonvKW0eLMm0ZGB1aPnbPusntcvKTssfiBl8fnTXIBLFHcNkmJJWXBmel5+nYJ3BkN
	F8+zFnRKVCz5Np+1gXGNcBcjJ4eEgInEu6+rGCFsMYkL99azdTFycQgJXGaUuDx3DpRzgUli
	8csWNpAqXgFtield/SwgNouAqsSzqV1gcTYBXYlFPc1MILaoQJDEiuUvGCHqBSVOznzCAjJI
	RKCFUeLtthvsIA6zwExGiYuvjrKCVAkLhEus+n2UBWLdVUaJDWcPA1VxcHAKWEvM3GkEYjIL
	qEusnycEUs4sIC/RvHU28wRGgVlIdsxCqJqFpGoBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzU
	Il1TvdzMEr3UlNJNjJDAFtzBOOOk3CFGAQ5GJR5eh5c/QoVYE8uKK3MPMUpyMCmJ8v42+Rkq
	xJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3UgEox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKa
	nZpakFoEk5Xh4FCS4A03BWoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VqfDEw
	WkFSPEB7uUHaeYsLEnOBohCtpxgVpcR5DUASAiCJjNI8uLGwdPWKURzoS2HefpAqHmCqg+t+
	BTSYCWiwe+o3kMEliQgpqQZGDkmOXwfFlrPwaq5bUGT3VPztPRZF/v2CZ89Na3K8NWHS5SeJ
	0fcfLqy+ebTf5OiOpDbx13Pe/lGubgp9JntlknJYidunl+wvjj+6fqlVNGPlv9gb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278009>

On 09/14/2015 07:37 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Thanks, will queue.
> 
> Ehh, I spoke a bit too early.
> 
>>> diff --git a/builtin/gc.c b/builtin/gc.c
>>> index bcc75d9..2c3aaeb 100644
>>> --- a/builtin/gc.c
>>> +++ b/builtin/gc.c
>>> @@ -43,9 +43,20 @@ static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
>>>  static struct argv_array rerere = ARGV_ARRAY_INIT;
>>>  
>>>  static char *pidfile;
>>> +static struct strbuf log_filename = STRBUF_INIT;
>>> +static int daemonized;
>>>  
>>>  static void remove_pidfile(void)
>>>  {
>>> +	if (daemonized && log_filename.len) {
>>> +		struct stat st;
>>> +
>>> +		close(2);
>>> +		if (stat(log_filename.buf, &st) ||
>>> +		    !st.st_size ||
>>> +		    rename(log_filename.buf, git_path("gc.log")))
>>> +			unlink(log_filename.buf);
>>> +	}
> 
> Unfortuantely we cannot queue this as-is, as we let the tempfile API
> to automatically manage the pidfile since ebebeaea (gc: use tempfile
> module to handle gc.pid file, 2015-08-10), and you cannot piggy-back
> the log file finalization to this function that no longer exists.
> 
> Besides, it is obviously wrong to remove this log file in a function
> whose name is remove_pidfile() ;-)
> 
> Adding a new function to tempfile API that puts the file to a final
> place if it is non-empty and otherwise remove it, and using that to
> create this "gc.log" file, would be the cleanest from the point of
> view of _this_ codepath.  I however do not know if that is too
> specific for the need of this codepath or "leave it if non-empty,
> but otherwise remove as it is uninteresting" is fairly common thing
> we would want and it is a good addition to the API set.
> 
> Michael, what do you think?

I'm not sure what behavior you want. At one point you say "puts the file
to a final place if it is non-empty" but later you say "leave it if
non-empty". Should the file be written directly, or should it be written
to a lockfile and renamed into place only when complete?

Technically I don't see a problem implementing either behavior. POSIX
allows [1] calls to stat() and rename() from a signal handler. There is
a minor technical difficulty that commit_lock_file() allocates memory
via get_locked_file_path(), but this would be surmountable by
pre-allocating the memory for the locked file path and storing it in the
lock_file object.

This doesn't seem like a common thing to want (as in, this might be the
only caller), but it probably makes sense to build it into the
tempfile/lockfile API nevertheless, because implementing it externally
would require a lot of other code to be duplicated.

Another possibility that might work (maybe without requiring changes to
tempfile/lockfile): don't worry about deleting the log file if it is
empty, but make observers treat an empty log file the same as an absent one.

Michael

[1]
http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_04_03

-- 
Michael Haggerty
mhagger@alum.mit.edu
