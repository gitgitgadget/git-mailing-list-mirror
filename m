From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Using doxygen (or something similar) to generate API docs [was
 [PATCH 4/4] Add a function string_list_longest_prefix()]
Date: Tue, 11 Sep 2012 00:09:30 +0200
Message-ID: <504E651A.4030401@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu> <7vbohfser4.fsf@alter.siamese.dyndns.org> <504DBA62.3080001@alum.mit.edu> <7v1ui9q21a.fsf@alter.siamese.dyndns.org> <20120910163310.GE9435@sigill.intra.peff.net> <504E27D7.8010505@op5.se> <504E3DA8.7040906@alum.mit.edu> <20120910215633.GB1537@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 00:09:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBCAq-00015k-IV
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 00:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab2IJWJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 18:09:34 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47002 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751647Ab2IJWJd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 18:09:33 -0400
X-AuditID: 1207440e-b7f036d0000008b5-f3-504e651d85ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id EC.52.02229.D156E405; Mon, 10 Sep 2012 18:09:33 -0400 (EDT)
Received: from [192.168.69.140] (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8AM9U1Y022357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 18:09:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120910215633.GB1537@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqCub6hdg8OkYt0XrmhuMFl1Xupks
	GnqvMFv8aOlhdmDx2Lb5HpPHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdcXRJB0vB
	aY6KFdPuszUwXmHrYuTkkBAwkXjQNIMRwhaTuHBvPVCci0NI4DKjxP5NdxghnNNMEr8+fQPr
	4BXQlpj+9xCYzSKgKtHy9yoTiM0moCuxqKcZzBYVCJGYcXkyM0S9oMTJmU9YQGwRAVmJ74c3
	gm1jFkiSmPppBivIAmGBNkaJbU+ns0Jsa2WW+P7mFHsXIwcHp4CVRG83C4jJLKAusX6eEESv
	vMT2t3OYJzAKzEKyYhZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWm
	lG5ihIQz3w7G9vUyhxgFOBiVeHg1ePwChFgTy4orcw8xSnIwKYny7owGCvEl5adUZiQWZ8QX
	leakFh9ilOBgVhLhjdcEyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWQ1ODgE
	1qxbfYFRiiUvPy9VSYLXNAVoiGBRanpqRVpmTglCKRMHJ8giLimR4tS8lNSixNKSjHhQBMcX
	A2MYJMUDdIMeSDtvcUFiLlAUovUUoy7H3Y8r7jMKge2QEucVAykSACnKKM2DWwFLaq8YxYG+
	F+YVBqniASZEuEmvgJYwAS3x9fABWVKSiJCSamBcdjH+8vr7syyvGT1bcz2mJa5sVtJZa6uA
	lmlu733ip353LjscsEDg69z3R7MN0zJ+WYiU/JBabJKmlZm81thWqdWQ5ULjhs3l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205202>

On 09/10/2012 11:56 PM, Jeff King wrote:
> On Mon, Sep 10, 2012 at 09:21:12PM +0200, Michael Haggerty wrote:
>> My plate is full.  If you are able to work on this, it would be awesome.
>>  As far as I'm concerned, you are the new literate documentation czar :-)
> 
> Lucky me? :)

I was nominating Andreas, who rashly volunteered to help.  But don't
feel left out; there's enough work to go around :-)

> I think I'll leave it for the moment, and next time I start to add some
> api-level documentation I'll take a look at doxygen-ating them and see
> how I like it. And I'd invite anyone else to do the same (in doxygen, or
> whatever system you like -- the best way to evaluate a tool like this is
> to see how your real work would look).

I agree with that.  A very good start would be to mark up a single API
and build the docs (by hand if need be) using a proposed tool.  This
will let people get a feel for (1) what the markup has to look like and
(2) what they get out of it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
