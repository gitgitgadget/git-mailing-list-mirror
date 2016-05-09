From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Mon, 9 May 2016 23:50:35 +0200
Message-ID: <5731062B.6080909@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <1462824758.24478.37.camel@twopensource.com>
 <xmqqinynt01r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:51:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azt4w-0004th-IF
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbcEIVux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:50:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60225 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908AbcEIVux (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 17:50:53 -0400
X-AuditID: 12074411-e3fff70000000955-ad-5731062f9f2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F1.71.02389.F2601375; Mon,  9 May 2016 17:50:40 -0400 (EDT)
Received: from [192.168.69.130] (p548D683E.dip0.t-ipconnect.de [84.141.104.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u49LoarP023370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 9 May 2016 17:50:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqinynt01r.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqGvAZhhucPE3k8X8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1g5sHjtn3WX3eNa7h9Hj4iVlj/1Lt7F5LHh+n93j8ya5ALYo
	bpukxJKy4Mz0PH27BO6M70tPMxXs5Kn4/Nm3gfEdZxcjJ4eEgInEpBPnmbsYuTiEBLYySuxb
	2QHlnGOSmH16JRtIlbCAp8SNxlesILaIQIREw6sWRoii6YwSrzbcZQJxmAWOMEocaPrEAlLF
	JqArsainmQnE5hXQlvg7aS7YJBYBFYk/n1eAxUUFQiS2rfvGClEjKHFy5hOwXk4Ba4mzL7eC
	2cwCehI7rv9ihbDlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEv
	L7VI11QvN7NELzWldBMjJMAFdzDOOCl3iFGAg1GJh5fhsn64EGtiWXFl7iFGSQ4mJVFeV0a9
	cCG+pPyUyozE4oz4otKc1OJDjBIczEoivPkshuFCvCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJ
	JanZqakFqUUwWRkODiUJXg1WoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UFTG
	FwPjEiTFA7RXH6Sdt7ggMRcoCtF6ilFRSpyXAyQhAJLIKM2DGwtLW68YxYG+FOb1BaniAaY8
	uO5XQIOZgAbLsemDDC5JREhJNTBmPv9RuYxl0xfZWWsi87WMT0V4z0097XTjd+4Mi0MFjTw6
	KxU+pWafebvoS/qumXs6W114Xz/+dj48XFiVXSnn781ybYeTewL31q93nN/hr33H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294076>

On 05/09/2016 11:05 PM, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>> [...]
>> I generally like to put the bug fixes before the tests for those fixes
>> (so that bisect on the complete suite works).  But maybe the git policy
>> is different.
> 
> The Git policy only asks not to break bisection.
> 
> As long as patch that adds a new test that comes before a patch that
> fixes the issue marks the new test with test_expect_failure, and a
> later patch that fixes the issue turns it into test_expect_success,
> bisection would not break.
> 
> The "demonstrate an existing breakage first" order makes it slightly
> easier to review and follow a long series, as it forces the reviewer
> to see the issue first and think about possible avenues to solve it
> for themselves, before seeing a paticular solution.  For a trivial
> single-issue fix, it is not necessary (including a fix and a test to
> protect the fix from future breakage in the same patch is a norm).

I find it useful to add the broken test in a separate patch, because it
is then easy to cherry pick that patch to other versions of Git to
discover which ones are also affected by the problem. If the addition of
the test is combined with the fix, then the patch would more often fail
to apply to other versions due to conflicts at the locations of the fix,
and even if it applied, you wouldn't learn whether that version of git
was broken but the breakage was fixed by the same fix, or whether it
wasn't broken in the first place and the fix was unnecessary.

Michael
