From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/9] fetch doc: update note on '+' in front of the
 refspec
Date: Wed, 18 Jun 2014 09:56:40 +0200
Message-ID: <53A14638.4060403@alum.mit.edu>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com> <1401833792-2486-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 09:56:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxAji-0003Pt-T7
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 09:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934037AbaFRH4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 03:56:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:65526 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934013AbaFRH4m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 03:56:42 -0400
X-AuditID: 12074414-f79f86d000000b9f-b7-53a1463ab0f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 83.94.02975.A3641A35; Wed, 18 Jun 2014 03:56:42 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5I7ueKB027301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 03:56:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1401833792-2486-4-git-send-email-gitster@pobox.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqGvltjDY4Np5DouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE74/CMlUwFxwUr5jV+Zm9gnMzXxcjJISFgIrFj
	YRsjhC0mceHeerYuRi4OIYHLjBI/Nm+Dcs4zSRxsPApWxSugLTHv6CV2EJtFQFXiwrkLTCA2
	m4CuxKKeZjBbVCBIYvbneewQ9YISJ2c+YQGxRQSsJX7//A5WIywQLNHc/Iq5i5EDaEGpRPeW
	PJAwp4CjRGfPCyaQsISAuERPYxBImFlAR+Jd3wNmCFteYvvbOcwTGAVmIVkwC0nZLCRlCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEBKnIDsYjJ+UOMQpwMCrx8O7Y
	syBYiDWxrLgy9xCjJAeTkiiviOvCYCG+pPyUyozE4oz4otKc1OJDjBIczEoivNx6QDnelMTK
	qtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQneFJChgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aA4jS8GRipIigdoLztIO29xQWIuUBSi9RSjLsepO8famIRY8vLz
	UqXEIXYIgBRllObBrYClpFeM4kAfC/PmgVTxANMZ3KRXQEuYgJaoTJwHsqQkESEl1cCo4GS+
	ZvX0J8KsczZYPj3Tb7x8TdWUlNcMy7R2nxKZd7/++bzHrz/Ny9LbIGk54/uH6dNunpI5orrp
	76o57y3WZvLXsn3Q2H9vu0CXgLx60oXz0suKknepzXR+ddN3S82OL5Eb55YxqvKc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251973>

On 06/04/2014 12:16 AM, Junio C Hamano wrote:
> While it is not *wrong* per-se to say that pulling a rewound/rebased
> branch will lead to an unnecessary merge conflict, that is not what
> the leading "+" sign to allow non-fast-forward update of remote-tracking
> branch is at all.
> 
> Helped-by: Marc Branchaud <marcnarc@xiplink.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/pull-fetch-param.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index 18cffc2..41474c5 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -24,15 +24,15 @@ is updated even if it does not result in a fast-forward
>  update.
>  +
>  [NOTE]
> -If the remote branch from which you want to pull is
> -modified in non-linear ways such as being rewound and
> -rebased frequently, then a pull will attempt a merge with
> -an older version of itself, likely conflict, and fail.
> -It is under these conditions that you would want to use
> -the `+` sign to indicate non-fast-forward updates will
> -be needed.  There is currently no easy way to determine
> -or declare that a branch will be made available in a
> -repository with this behavior; the pulling user simply
> +When the remote branch you want to fetch is known to
> +be rewound and rebased regularly, it is expected that
> +its new tip will not be descendant of its previous tip

s/will not be descendant/will not be a descendant/

to fix a typo, and maybe

s/will not be descendant/will sometimes not be a descendant/

because sometimes it *will* be a descendant.

> +(as stored in your remote-tracking branch the last time
> +you fetched).  You would want
> +to use the `+` sign to indicate non-fast-forward updates
> +will be needed for such branches.  There is no way to
> +determine or declare that a branch will be made available
> +in a repository with this behavior; the pulling user simply
>  must know this is the expected usage pattern for a branch.
>  +
>  [NOTE]
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
