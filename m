From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Thu, 13 Aug 2015 22:16:50 +0200
Message-ID: <55CCFB32.30608@alum.mit.edu>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>	 <1439416645-19173-3-git-send-email-dturner@twopensource.com>	 <CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com> <1439487708.8855.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPyw4-0006PZ-OS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 22:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbHMURI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 16:17:08 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49037 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753284AbbHMURH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2015 16:17:07 -0400
X-AuditID: 1207440d-f79136d00000402c-40-55ccfb34d088
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 66.11.16428.43BFCC55; Thu, 13 Aug 2015 16:16:52 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB03E0.dip0.t-ipconnect.de [93.219.3.224])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7DKGoSw001835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 13 Aug 2015 16:16:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1439487708.8855.2.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqGvy+0yoQcdRU4tNzycyW8zfdILR
	outKN5NF95S3jBZn3jQyOrB67Jx1l91j8QMvj+UPXrF7LHh+n93j8ya5ANYobpukxJKy4Mz0
	PH27BO6M+y07WQv+cVWcP/aDuYFxHUcXIyeHhICJRO/ZaYwQtpjEhXvr2boYuTiEBC4zSlw6
	8YIZwjnHJLFk/jP2LkYODl4BTYm2i9ogDSwCqhI7Gu+zgthsAroSi3qamUBsUYEgiRXLX4AN
	5RUQlDg58wkLiC0iECsx7+okRpCZzAJzGSW6vz4CKxIWcJY4Pmk+E8Sy74wS51dtB+vgFDCX
	2H11BTOIzSygLvFn3iUoW15i+9s5zBMYBWYhWTILSdksJGULGJlXMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuka6eVmluilppRuYoSEOe8Oxv/rZA4xCnAwKvHwbnh0OlSINbGsuDL3EKMkB5OS
	KO+Kz2dChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw7voJlONNSaysSi3Kh0lJc7AoifOqLVH3
	ExJITyxJzU5NLUgtgsnKcHAoSfDy/QJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3J
	iAdFa3wxMF5BUjxAe5eDtPMWFyTmAkUhWk8xKkqJ83KDJARAEhmleXBjYcnrFaM40JfCvIwg
	VTzAxAfX/QpoMBPQ4HS5UyCDSxIRUlINjMYXjqx9H6moeILD12RpdfsErgfcvxlzVGTD43ev
	fM/SsW7GlGajfwZuLnfOSbNuEbns2vf/XlyXddTk0sMXj0xQLX55q0SpaOGFbQfs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275891>

On 08/13/2015 07:41 PM, David Turner wrote:
> On Thu, 2015-08-13 at 13:15 -0400, Eric Sunshine wrote:
>> On Wed, Aug 12, 2015 at 5:57 PM, David Turner <dturner@twopensource.com> wrote:
>>> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
>>> index 93605f4..28e6dff 100755
>>> --- a/t/t0060-path-utils.sh
>>> +++ b/t/t0060-path-utils.sh
>>> +test_expect_success 'handle per-worktree refs in refs/worktree' '
>>> +       git commit --allow-empty -m "initial commit" &&
>>> +       git worktree add -b branch worktree &&
>>> +       (
>>> +               cd worktree &&
>>> +               git commit --allow-empty -m "test commit"  &&
>>> +               git for-each-ref | test_must_fail grep refs/worktree &&
>>
>> s/test_must_fail/!/
>>
>> From t/README:
>>
>>    On the other hand, don't use test_must_fail for running regular
>>    platform commands; just use '! cmd'.  We are not in the business
>>    of verifying that the world given to us sanely works.
> 
> When I make that change, my test fails with:
> 
> FATAL: Unexpected exit with code 2
> 
> Apparently, you can't use ! in pipelines like that.  So that's why I
> used test_must_fail.

You would have to negate the whole pipeline, like

    ! git for-each-ref | grep refs/worktree

The result of a pipeline is taken from the last command.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
