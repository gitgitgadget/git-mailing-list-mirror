From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Sun, 13 Apr 2014 22:18:32 +0200
Message-ID: <534AF118.5040501@alum.mit.edu>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 22:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZQrT-0003tY-RU
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 22:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbaDMUSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2014 16:18:37 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:44749 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755174AbaDMUSf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2014 16:18:35 -0400
X-AuditID: 1207440e-f79c76d000003e2c-03-534af11abbb9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E5.90.15916.A11FA435; Sun, 13 Apr 2014 16:18:34 -0400 (EDT)
Received: from [192.168.69.130] (p4FC961C4.dip0.t-ipconnect.de [79.201.97.196])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3DKIWfb027194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 13 Apr 2014 16:18:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqCv10SvYYMt1douuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7Y9b/9WwFnwQqVh0+wNLAeIO3i5GTQ0LAROJu
	9zp2CFtM4sK99WxdjFwcQgKXGSXOTfzBCOGcZ5JYdGomC0gVr4C2xK+Xs8E6WARUJT62XGUC
	sdkEdCUW9TQD2RwcogJBEn/OKkKUC0qcnPkErFVEwFri98/vYOXCAvYS009cZgWxhQSsJJ4e
	ecEIYnMC1fR9PQo2RkJAXKKnMQgkzCygI/Gu7wEzhC0vsf3tHOYJjAKzkGyYhaRsFpKyBYzM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCgpRvB2P7eplDjAIcjEo8vInb
	PYOFWBPLiitzDzFKcjApifKKvvUKFuJLyk+pzEgszogvKs1JLT7EKMHBrCTCuy0DKMebklhZ
	lVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuDN+wDUKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+K0/hiYKSCpHiA9m55D7K3uCAxFygK0XqK0Zjj1oY1jUwcG7YB
	SSGWvPy8VClxXg+QTQIgpRmleXCLYOnpFaM40N/CvJYgVTzA1AY37xXQKiagVZcmu4OsKklE
	SEk1MDbOSXea8rGWk2nFxUendiV4bqll26SyRVCyiv9XwebEF12fTqxeIZy5cipHx5OtJszb
	5uo4qyQv0M6P+furZEfbsSKFlQqBb//md2bZ351y2eLCjySZXW6fnrzwqt1x4lL2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246212>

On 04/12/2014 12:22 AM, Junio C Hamano wrote:
> [...]
> * mh/ref-transaction (2014-04-07) 27 commits
>  - ref_transaction_commit(): work with transaction->updates in place
>  - struct ref_update: add a type field
>  - struct ref_update: add a lock field
>  - ref_transaction_commit(): simplify code using temporary variables
>  - struct ref_update: store refname as a FLEX_ARRAY
>  - struct ref_update: rename field "ref_name" to "refname"
>  - refs: remove API function update_refs()
>  - update-ref --stdin: reimplement using reference transactions
>  - refs: add a concept of a reference transaction
>  - update-ref --stdin: harmonize error messages
>  - update-ref --stdin: improve the error message for unexpected EOF
>  - t1400: test one mistake at a time
>  - update-ref --stdin -z: deprecate interpreting the empty string as zeros
>  - update-ref.c: extract a new function, parse_next_sha1()
>  - t1400: test that stdin -z update treats empty <newvalue> as zeros
>  - update-ref --stdin: simplify error messages for missing oldvalues
>  - update-ref --stdin: make error messages more consistent
>  - update-ref --stdin: improve error messages for invalid values
>  - update-ref.c: extract a new function, parse_refname()
>  - parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
>  - update-ref --stdin: read the whole input at once
>  - update_refs(): fix constness
>  - refs.h: rename the action_on_err constants
>  - t1400: add some more tests involving quoted arguments
>  - parse_arg(): really test that argument is properly terminated
>  - t1400: provide more usual input to the command
>  - t1400: fix name and expected result of one test
>  (this branch is used by rs/ref-closer-to-atomic.)
> 
>  Update "update-ref --stdin [-z]" and then introduce a transactional
>  support for (multi-)reference updates.
> 
>  Is this ready to be merged to 'next' for wider exposure?

Yes, as far as I know there are no outstanding objections to this
version (v3) of this series and it is ready for 'next'.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
