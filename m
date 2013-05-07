From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 07 May 2013 08:47:06 +0200
Message-ID: <5188A36A.8000408@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com> <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com> <518874A5.5050002@alum.mit.edu> <CAMP44s3vGKv-Z6sx0sjAPH7_U1+AiJjFHjKz8ke+EUqW-u2Y=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 08:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZbgC-00010H-VP
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 08:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494Ab3EGGrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 02:47:12 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:47533 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757219Ab3EGGrL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 02:47:11 -0400
X-AuditID: 12074413-b7f226d000000902-23-5188a36eee4e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 97.44.02306.E63A8815; Tue,  7 May 2013 02:47:10 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r476l7Af023184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 May 2013 02:47:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAMP44s3vGKv-Z6sx0sjAPH7_U1+AiJjFHjKz8ke+EUqW-u2Y=A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqJu3uCPQYGs3n8Wvs7tYLA4+zrPo
	utLNZNHQe4XZon95F5vF3cur2B3YPHbOusvu8eFjnMft1/OZPS5eUvb4vEkugDWK2yYpsaQs
	ODM9T98ugTtjf2sPS8Fynopp1y8yNzB+4+xi5OSQEDCROLTsGDuELSZx4d56ti5GLg4hgcuM
	Ejd6LzNBOMeYJNq7mllBqngFtCV6z11nBLFZBFQlblw7zwxiswnoSizqaWYCsUUFwiRWrV/G
	DFEvKHFy5hMWEFtEwFBib/tUFpChzALnGSUOfngCtlpYwF5i15fpYAuEBNpYJL7vsACxOQUC
	JQ7eWgHUwAHUoC6xfp4QSJhZQF5i+9s5zBMYBWYhWTELoWoWkqoFjMyrGOUSc0pzdXMTM3OK
	U5N1i5MT8/JSi3TN9XIzS/RSU0o3MUICXXgH466TcocYBTgYlXh4FU61BwqxJpYVV+YeYpTk
	YFIS5V24sCNQiC8pP6UyI7E4I76oNCe1+BCjBAezkgivtDZQjjclsbIqtSgfJiXNwaIkzqu2
	RN1PSCA9sSQ1OzW1ILUIJivDwaEkwZu2CKhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSix
	tCQjHhSp8cXAWAVJ8QDt9QVp5y0uSMwFikK0nmLU5Vh55clrRiGWvPy8VClx3lSQIgGQoozS
	PLgVsLT2ilEc6GNh3iKQKh5gSoSb9ApoCRPQkgS+dpAlJYkIKakGRuedl2d9lin/brT6pP31
	84tvHbae4HPwgV2ie/69m8umPDSbeszX7MAfDk+zK+WN1lHLjk3UWOJ0OmylStnv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223557>

On 05/07/2013 06:47 AM, Felipe Contreras wrote:
> On Mon, May 6, 2013 at 10:27 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
>> You conjectured earlier that nobody uses blob marks, and I provided a
>> counterexample.  Then you proposed a workaround that would require
>> changes to the cvs2git documentation, and I even explained how your
>> proposed workaround is not as flexible as the status quo.
> 
> cvs2git does *not* need blob marks, it does not need marks at all.
> 
> The use-case that you mentioned has nothing to do with cvs2git, in
> fact. I can be described as this:
> 
> % ./generate-blobs > blobs
> % git fast-import --export-marks=marks < blobs
> % ./generate-commits > commits
> % git fast-import --import-marks=marks < commits
> 
> In this example 'generate-commits' has no notion of marks at all, and
> 'git fast-import' doesn't need marks to process both blobs and
> commits.

The "generate-blobs" program generates a mark for each blob and
remembers the marks in a database.  The "generate-commits" program reads
the marks from the database and incorporates them in the definitions of
the commits that it writes to its output.  So yes, the program pair
*does* rely on marks for blobs being exported correctly.

I've tired of this discussion.  I am quite sure that your change will
not be accepted, so I see no need to participate further.  Please do not
interpret my silence as agreement with your quarrelsome arguments.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
