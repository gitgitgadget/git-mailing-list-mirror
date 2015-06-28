From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sun, 28 Jun 2015 13:31:05 +0200
Message-ID: <558FDAF9.3010300@alum.mit.edu>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>	<558F8B55.1070708@alum.mit.edu>	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>	<558F9854.5080605@alum.mit.edu> <xmqqwpyoe1aj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 13:31:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9Anx-0004lx-B6
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 13:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF1LbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 07:31:15 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54359 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752082AbbF1LbN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jun 2015 07:31:13 -0400
X-AuditID: 12074413-f79bd6d000007ac2-e3-558fdafc0056
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C4.57.31426.CFADF855; Sun, 28 Jun 2015 07:31:08 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2F50.dip0.t-ipconnect.de [93.219.47.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5SBV5UT013101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 28 Jun 2015 07:31:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqwpyoe1aj.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqPvnVn+owZReWYuZM60tbs9sYbbo
	utLNZNHQe4XZ4v+OBSwWS14/YnZg87jaHOCxc9Zddo9jx1qZPS5eUvb4vEkugDWK2yYpsaQs
	ODM9T98ugTvj099PjAU7eSuWLQptYDzF1cXIySEhYCLReuwIE4QtJnHh3no2EFtI4DKjxJpv
	hl2MXED2OSaJ1f//gCV4BbQlnsy5xdLFyMHBIqAq8fFKNkiYTUBXYlFPMxNIWFQgSOL1y1yI
	akGJkzOfsIDYIgJqEhPbDrGAjGQW+M4o8ejzf3aQhLCAk8SUT9uZIXY9YJboXrePESTBKWAt
	8eP2bFYQm1lAT2LH9V9QtrxE89bZzBMYBWYhWTILSdksJGULGJlXMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuma6+VmluilppRuYoSEufAOxl0n5Q4xCnAwKvHweuj2hwqxJpYVV+YeYpTkYFIS
	5V22ESjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdzK1CONyWxsiq1KB8mJc3BoiTOq7ZE3U9I
	ID2xJDU7NbUgtQgmK8PBoSTB++YmUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KE7ji4GRCpLiAdr7DKSdt7ggMRcoCtF6ilFRSpz3GEhCACSRUZoHNxaWvF4xigN9Kcz7EqSK
	B5j44LpfAQ1mAhq8yrsPZHBJIkJKqoHR+J5O+WZFLf+H4bmcCivOXfg7KdpuYvGvnwvaZt+6
	s3tDnoneip1xd5LtmQ6H/p+2e0b7Kknb238sX5yNEti80GvW/mmOxp9dQsIvFmkX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272875>

On 06/28/2015 09:32 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I understand that the user might make a mistake when marking the initial
>> commits, but as soon as bisect says
>>
>>     Commit <sha1-abbrev> is an ancestor of <sha1-abbrev>, so I
>>     will look for the commit that caused the transition from
>>     "xyzzy" to "plugh".
>>
>> then I hope the user will notice and correct her/his mistake.
>>
>> For example, a session could be started with
>>
>>     git bisect start --mark=broken <committish> --mark=fixed <committish>
> 
> Interesting.
> 
> If we extend that line of thought further, maybe we do not even need
> to add new/old, fixed/broken, or slow/fast.
> 
> You just _always_ say "good" or "bad".  If something is slow, you
> say "bad" and if something is fast, you say "good".

Yes, I think "good" and "bad" would usually be perfectly intuitive and
would almost always be usable.

> [...]
> No need for "bisect new", "bisect old", or "bisect terms", let alone
> "bisect terms --new=fast --old=slow".  The tool just does the right
> thing because it already has the information necessary to infer what
> the user means by 'good' and 'bad', and the initial topology determines
> which transition, either from 'good' to 'bad' or from 'bad' to 'good',
> the user is hunting for.

Correct. The only caveat is if the initial "good" and "bad" commits are
not ancestrally related to each other. But in this case, I think
"bisect" asks the user to test a merge base anyway, and once that one
has been tested it will be clear which of the labels comes "before" the
other.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
