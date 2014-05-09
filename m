From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Fri, 09 May 2014 18:53:32 +0200
Message-ID: <536D080C.7030402@alum.mit.edu>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com> <20140425231953.GB3855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 18:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wio3I-00055w-6f
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbaEIQxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:53:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58298 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755882AbaEIQxf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 12:53:35 -0400
X-AuditID: 1207440e-f79c76d000003e2c-71-536d080ea4e7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DE.0B.15916.E080D635; Fri,  9 May 2014 12:53:34 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2E4D.dip0.t-ipconnect.de [93.219.46.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s49GrWXh032402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 9 May 2014 12:53:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140425231953.GB3855@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqMvHkRts0L1P2+Lg4zyLrivdTBYN
	vVeYLX609DA7sHjsnHWX3eNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M543vyIueA3
	Z0XTkVVsDYxNHF2MnBwSAiYSH1pmsELYYhIX7q1n62Lk4hASuMwoceveehYI5yyTxKcND5lB
	qngFtCU+Xz/MAmKzCKhKfJ39mA3EZhPQlVjU08zUxcjBISoQJPHnrCJEuaDEyZlPwMpFBBwl
	Lmw5AmYzC7hJPP76gR3EFhawl3i4Zh/YEUICGRJn+p+A2ZwCVhI3Jz1nBRkpISAu0dMYBGIy
	C6hLrJ8nBDFFXmL72znMExgFZyFZNguhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKL
	dI31cjNL9FJTSjcxQsKbbwdj+3qZQ4wCHIxKPLwSr3OChVgTy4orcw8xSnIwKYnyPmfMDRbi
	S8pPqcxILM6ILyrNSS0+xCjBwawkwlvxGaicNyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7
	NbUgtQgmK8PBoSTB+4oNaKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KHbji4HR
	C5LiAdrLyg7UzltckJgLFIVoPcVozPHl1/IWJo4LDStamIRY8vLzUqXEeXeCbBIAKc0ozYNb
	BEtsrxjFgf4W5n0IUsUDTIpw814BrWICWuWrnw2yqiQRISXVwMh/qeSQe5O85t3ZLModBVVl
	/DYTcqY9DbyzWGGC66e1RVxvE2/9Ou5Vki/UkHJPx+3p31Mxp8oX++t+d1zb/Kzq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248586>

On 04/26/2014 01:19 AM, Jeff King wrote:
> On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:
> [...]
>> * fc/publish-vs-upstream (2014-04-21) 8 commits
>>  - sha1_name: add support for @{publish} marks
>>  - sha1_name: simplify track finding
>>  - sha1_name: cleanup interpret_branch_name()
>>  - branch: display publish branch
>>  - push: add --set-publish option
>>  - branch: add --set-publish-to option
>>  - Add concept of 'publish' branch
>>  - t5516 (fetch-push): fix test restoration
>>
>>  Add branch@{publish}; it seems that this is somewhat different from
>>  Ram and Peff started working on.  There were many discussion
>>  messages going back and forth but it does not appear that the
>>  design issues have been worked out among participants yet.
> 
> [...]
> As for the patches themselves, I have not reviewed them carefully, and
> would prefer not to. As I mentioned before, though, I would prefer the
> short "@{p}" not be taken for @{publish} until it has proven itself.

Is it too late and/or impossible to think of a different name for either
"push" or "publish" so that their single-letter abbreviations don't
coincide?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
