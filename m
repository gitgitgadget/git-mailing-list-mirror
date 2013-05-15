From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: git cvsimport implications
Date: Wed, 15 May 2013 08:24:26 +0200
Message-ID: <51932A1A.4050606@alum.mit.edu>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com> <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com> <7vfvxpfbli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 08:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcV8c-0000Wr-3x
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 08:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3EOGY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 02:24:29 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:54062 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755081Ab3EOGY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 02:24:29 -0400
X-AuditID: 12074412-b7f216d0000008d4-a6-51932a1cc78a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A5.5C.02260.C1A23915; Wed, 15 May 2013 02:24:28 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4F6OQhI019440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 May 2013 02:24:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vfvxpfbli.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCujNTnQ4MtiEYsNc++yWHRd6Way
	aOi9wuzA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5YceUKe8EmgYqj756zNzB2
	83YxcnJICJhIfLm4lg3CFpO4cG89mC0kcJlRYtr30i5GLiD7OpPErbWbwBK8AtoSr14tZuxi
	5OBgEVCVuPidBSTMJqArsainmQnEFhUIk1i1fhkzRLmgxMmZT8BqRATUJCa2HQKzmQWsJPY8
	7GUGGSMsoCMxb2YoxKr9jBJLrm9mBanhFDCT2NXXywZRryPxru8BM4QtL7H97RzmCYwCs5Cs
	mIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQgJXaAfj+pNy
	hxgFOBiVeHgl/CcFCrEmlhVX5h5ilORgUhLlddKcHCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJ
	hNfwGlA5b0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IEbwjIUMGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUDtPegBlA7b3FBYi5QFKL1FKMu
	x8orT14zCrHk5eelSonzPgQpEgApyijNg1sBS1OvGMWBPhbmPQRSxQNMcXCTXgEtYQJaolkC
	8lxxSSJCSqqBUeCBnu2WgKedt4+71okdjNywL2eyA8+DqXNW5+2MNvkyyU72U+XPI36TdZcu
	vlHx5Y+v8Y8Tlpku5/4eKdtwT060VL1PxGL7AkeLFueJ/lc0rnUF7VaZI3DR/uva 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224383>

On 05/15/2013 12:19 AM, Junio C Hamano wrote:
> Eugene Sajine <euguess@gmail.com> writes:
> 
>> What if there are a lot of branches in the CVS repo? Is it guaranteed
>> to be broken after import?
> 
> Even though CVS repository can record branches in individual ,v
> files, reconstructing per branch history and where the branch
> happened in each "changeset" cannot be determined with any
> certainty.  The best you can get is a heuristic result.
> 
> I do not think anybody can give such a guarantee.  The best you can
> do is to convert it and validate if the result matches what you
> think has happened in the CVS history.

Junio, you are correct that there is no 100% reliable way of inferring
the changesets that were made in CVS.  CVS doesn't record which file
revisions were committed at the same time, unambiguous branch points,
etc.  The best a tool can do is use heuristics.

But it *is* possible for a conversion tool to make some more elementary
guarantees regarding aspects of the history that are recorded
unambiguously in CVS, for example:

* That if you check the tip of same branch out of CVS and out of Git,
you get the same contents.

* That CVS file revisions are committed to Git in the correct order
relative to each other; e.g., that the changes made in CVS revision
1.4.2.2 in a particular file precede those made in revision 1.4.2.3 of
the same file.

git-cvsimport fails to ensure even this minimal level of correctness.
Such errors are demonstrated in its own test suite.

cvs2git, on the other hand, gets the basics 100% correct (if you find a
discrepancy, please file a bug!), in addition to having great heuristics
for inferring the details of the history.

There is no reason ever to use git-cvsimport for one-time conversions
from CVS to Git.  The only reason ever to use it is if you absolutely
require an incremental bridge between CVS and Git, and even then please
use it with great caution.

Michael
the cvs2svn/cvs2git maintainer

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
