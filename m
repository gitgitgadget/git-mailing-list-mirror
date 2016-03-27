From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch 04/33
Date: Sun, 27 Mar 2016 07:22:52 +0200
Message-ID: <56F76E2C.5030700@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
 <1458802034.28595.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 07:27:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak3Ek-0005l2-JL
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 07:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcC0FXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 01:23:12 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54275 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451AbcC0FXM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 01:23:12 -0400
X-AuditID: 1207440f-d9fff70000007e44-11-56f76e318d69
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9D.54.32324.13E67F65; Sun, 27 Mar 2016 01:22:57 -0400 (EDT)
Received: from [192.168.69.130] (p548D6C6C.dip0.t-ipconnect.de [84.141.108.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2R5MrLv029848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 27 Mar 2016 01:22:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1458802034.28595.8.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqGuc9z3M4PsOc4v5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrR3YPHbOusvu8ax3D6PHxUvKHvuXbmPzWPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZizbtZC2YxV9xY/VutgbGWTxdjJwcEgImEhvW3GHqYuTiEBLYyiix
	qvU0I4RzgUlif08zK0iVsICfxPP3z5lBbBGBCIklk/eBxYUEUiX6tm4Ds5kF8iQ+LV0MVsMm
	oCuxqKeZCcTmFdCW6LqwmxHEZhFQlTg6+Rw7iC0qECKxbd03VogaQYmTM5+wgNicAhYS+xes
	Z4eYqS7xZ94lZghbXmL72znMExj5ZyFpmYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz
	8lKLdE30cjNL9FJTSjcxQsKbfwdj13qZQ4wCHIxKPLwMf7+FCbEmlhVX5h5ilORgUhLl7cgH
	CvEl5adUZiQWZ8QXleakFh9ilOBgVhLh7c74HibEm5JYWZValA+TkuZgURLnVV+i7ickkJ5Y
	kpqdmlqQWgSTleHgUJLgZcsFahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWR8
	MTAqQVI8QHv35YDsLS5IzAWKQrSeYlSUEufdD5IQAElklObBjYUlrVeM4kBfCvMuAaniASY8
	uO5XQIOZgAZLWX0DGVySiJCSamCcmJklrhDuUbZ98uLS+0XXetfwWFdZS/GZHbw8bZnRCefa
	R62/P+t9qGU49F3a0+FVln/7H8kd2y32NMzt/P5A8P2Tb7/OPwur3eK1vYHXnv1U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289994>

On 03/24/2016 07:47 AM, David Turner wrote:
> [...]
> I incorporated your changes into the lmdb backend.  To make merging
> later more convenient, I rebased on top of pu -- I think this mainly
> depends on jk/check-repository-format, but I also included some fixes
> for a couple of tests that had been changed by other patches.

I think rebasing changes on top of pu is counterproductive. I believe
that Junio had extra work rebasing your earlier series onto a merge of
the minimum number of topics that it really depended on. There is no way
that he could merge the branch in this form because it would imply
merging all of pu.

See the zeroth section of SubmittingPatches [1] for the guidelines.

> The current version can be found here:
> 
> https://github.com/dturner-tw/git/tree/dturner/pluggable-backends
> 
> I won't resend the full patchset to the list until I hear back on the
> rest of the review.
> 
> It seems like maybe we should now split this into two patchsets:
> everything up to and including "refs: move resolve_ref_unsafe into
> common code" does not depend on the backend structure and could go in
> earlier.  If you agree, we could send that first series and get it in,
> hopefully reducing later merge conflicts.  

That sounds like a good idea. It's always a relief to get work merged
and not have to keep porting it along.

There are three patches later in the series that (I think) also don't
have specifically to do with pluggable backends. These could potentially
also be considered for earlier merge to reduce the size of what remains:

* refs: don't dereference on rename
* refs: on symref reflog expire, lock symref not referrent
* refs: resolve symbolic refs first

But note that I haven't audited those patches yet, so I'm not saying
that they are necessarily ready to be merged.

Michael

[1] https://github.com/git/git/blob/master/Documentation/SubmittingPatches
