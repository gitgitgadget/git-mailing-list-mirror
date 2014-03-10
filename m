From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Potential GSOC microproject idea
Date: Mon, 10 Mar 2014 09:35:21 +0100
Message-ID: <531D7949.3000308@alum.mit.edu>
References: <73E9BCA0-D55C-4751-A3C0-1CD21F296758@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvgg-0005ZY-06
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbaCJIf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 04:35:27 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56291 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096AbaCJIfY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 04:35:24 -0400
X-AuditID: 1207440f-f79326d000003c9f-91-531d794b28a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id CE.24.15519.B497D135; Mon, 10 Mar 2014 04:35:23 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2A8ZLoi015317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 04:35:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <73E9BCA0-D55C-4751-A3C0-1CD21F296758@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqOtdKRtsMO2mvkXXlW4mi8t7l7M4
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7ozz0/tZC1pEKyb972ZqYJwt0MXIySEhYCKx
	cft/VghbTOLCvfVsXYxcHEIClxklutdPZIJwzjNJdPVsZQap4hXQlmiY8ZUJxGYRUJV49K4B
	rJtNQFdiUU8zWFxUIFhi9eUHLBD1ghInZz4Bs0UE1CU6jj9mBLGZBbQkVtyfDrSNg0MYqLdz
	ryxIWEjARqLnQjs7iM0pYCsxbcliVpASCQFxiZ7GIIhOHYl3fQ+YIWx5ie1v5zBPYBSchWTZ
	LCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokREr78Oxi71ssc
	YhTgYFTi4T3wViZYiDWxrLgy9xCjJAeTkijvkTLZYCG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vBlxQDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvRwVQo2BRanpq
	RVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwofuOLgREMkuIB2usC0s5bXJCYCxSFaD3FqMtx
	u+3XJ0Yhlrz8vFQpcd68cqAiAZCijNI8uBWwZPWKURzoY2HeCJBRPMBEBzfpFdASJqAlzcel
	QJaUJCKkpBoYt32e4/DWaELbx4K0pYsSutKdTxbp2nCdu8nsnh51aLvzXpv16dm6gY7OC+9F
	/DvIfj2gV1X79Jaf81ikE1P25kXuPve18BRbdKH8oVndjNXP91gncZWyCD74J7zJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243713>

On 03/09/2014 02:54 AM, Kyle J. McKay wrote:
> On Mar 3, 2014, at 23:58, Michael Haggerty wrote:
>> list
>> regulars should FEEL ENCOURAGED to submit microprojects to add to the
>> list.  (Either submit them as a pull request to the GitHub repository
>> that contains the text [1] or to the mailing list with CC to me.)
> 
> Potential idea for a microproject:
> 
> Add a new config setting:
> 
>   user.allowImplicitIdentity
>     Defaults to true.
>     If user.name and GIT_COMMITTER_NAME are unset or user.email and
>     GIT_COMMITTER_EMAIL and EMAIL are unset, an implicit value is
>     substituted for one or both of user.name and user.email.  If
>     an automatically generated value is used for both name and email
>     a warning "Your name and email address were configured
> automatically..."
>     is displayed.  If set to false, no or never, instead of a warning,
>     an error is generated and the operation fails:
> 
>         *** Please tell me who you are.
> 
>         Run
> 
>           git config --global user.email "you@example.com"
>           git config --global user.name "Your Name"
> 
>         to set your account's default identity.
>         Omit --global to set the identity only in this repository.
> 
>         fatal: implicit user identity not allowed
> 
>     the advice portion can be suppressed by setting
> advice.implicitIdentity to false,
>     but not the "fatal: implicit user identity not allowed" part.
> 
> Note that if "git config --system --bool user.allowImplicitIdentity
> false" is in effect, it should still be possible to clone (ref logs may
> be updated, but they should be allowed to use an implicit identity).  In
> other words user.allowImplicitIdentity=false should only inhibit writing
> any new commit/tag objects that need the current user's name and email
> when it has not been explicitly provided.
> 
> I'm not sure how micro this is.  :)  I do think the amount of code
> involved is rather small though.  Support for something like this has
> popped up on the list before.  Perhaps "user.allowAutomaticIdentity" and
> "advice.automaticIdentity" would be better config names.

This would be much more work than the other microprojects.  The ones
that I wrote were mostly one- or few-line changes that didn't require
the student to learn a lot of context.  (And most students struggled
mightily with even those.)  So I'm not sure this task is suitable.

Other feedback welcome.  We're pretty much out of microprojects, which
is possibly even worse than having difficult ones.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
