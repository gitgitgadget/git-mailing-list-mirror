From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 06:55:38 +0200
Message-ID: <558643CA.6000303@alum.mit.edu>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>	<cover.1434720655.git.johannes.schindelin@gmx.de>	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>	<xmqq1th77829.fsf@gitster.dls.corp.google.com>	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org> <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 21 07:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6XSS-0007wq-9U
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 07:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbbFUEzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 00:55:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56641 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094AbbFUEzr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 00:55:47 -0400
X-AuditID: 1207440f-f79df6d000007c0f-c0-558643cccb18
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 50.AA.31759.CC346855; Sun, 21 Jun 2015 00:55:40 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96857.dip0.t-ipconnect.de [79.201.104.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5L4tcsv020455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 21 Jun 2015 00:55:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqHvGuS3U4G+DrUXXlW4mi4beK8wW
	/cu72Cx+tPQwO7B4fPgY5/Gsdw+jx8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGfsbW9iLrgj
	XDFz1mnWBsa//F2MnBwSAiYS+/ZsZYawxSQu3FvP1sXIxSEkcJlR4u6cA+wQznkmiTMHm5lA
	qngFtCWWX5nLDmKzCKhKXDi2jBHEZhPQlVjUA1LDwSEqECTx+mUuRLmgxMmZT1hAbBGBRInG
	CRtZQWxmATWJ5T9/sYHYwgIOEmeX/WOGWswkcf3GRbBdnALWEvevzGWBaNCT2HH9F1SzvETz
	1tnMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5i
	hIQz/w7GrvUyhxgFOBiVeHhvMLSFCrEmlhVX5h5ilORgUhLl/XevJVSILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO8ykHLelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRv
	kBNQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB2lsF0s5bXJCY
	CxSFaD3FqCglzhsPkhAASWSU5sGNhSWpV4ziQF8K83qAVPEAExxc9yugwUxAgyeUN4EMLklE
	SEk1MHrufSEf2/GuY7FWyn1ec4PerUZsJQZtnNts3iudmrSAJ633vb+M9J0jhctm8kvlPAlu
	u9GdsE/PaxvPqSq5r8WTKvPTnmVLrVWbdnxRR3T6DiaWV3vXf75U4tTdVXdXrkLr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272250>

On 06/19/2015 10:53 PM, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Can you think of a name for the option that is as short as `--quick`
>> but means the same as `--connectivity-only`?
> 
> No I can't.  I think `--connectivity-only` is a very good name that
> is unfortunately a mouthful, I agree that we need a name that is as
> short as `--xxxxx` that means the same as `--connectivity-only`.  I
> do not think `--quick` is that word; it does not mean such a thing.

`--connectivity-only` says that "of all the things that fsck can do,
skip everything except for the connectivity check". But the switch
really affects not the connectivity part of the checks (that part is
done in either case), but the blob part. So, if we ignore the length of
the option name for a moment, it seems like the options should be
something like `--check-blob-integrity`/`--no-check-blob-integrity`. The
default would remain `--check-blob-integrity` of course, but

* Someday there might be a config setting that people can use to change
the default behavior of fsck to `--no-check-blob-integrity`.
* Someday there might be other expensive types of checks [1] that we
want to turn on/off independent of blob integrity checks.

But now that I'm writing this, a silly question occurs to me: Do we need
an overall option like this at all? If I demote all blob-integrity
checks to "ignore" via the mechanism that you have added, then shouldn't
fsck automatically detect that it doesn't have to open the blobs at all
and enable this speedup automatically? So maybe
`--(no-)?check-blob-integrity` is actually a shorthand for turning a few
more specific checks on/off at once.

As for thinking of a shorter name for the option: assuming the blob
integrity checks can be turned on and off independently as described
above, then I think it is reasonable to *also* add a `--quick` option
defined as

--quick: Skip some expensive checks, dramatically reducing the
    runtime of `git fsck`. Currently this is equivalent to
    `--no-check-blob-integrity`.

In the future if we invent other expensive checks we might also add them
to the list of things that are skipped by `--quick`.

Michael

[1] For example, if LFS or something like it every became part of
standard Git, one could imagine a super-expensive
`--check-lfs-object-availability` check that would would default to OFF
but sometimes turn on by hand.

-- 
Michael Haggerty
mhagger@alum.mit.edu
