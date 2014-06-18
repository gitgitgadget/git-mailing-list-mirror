From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Wed, 18 Jun 2014 13:33:47 +0200
Message-ID: <53A1791B.5010301@alum.mit.edu>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>	<CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com> <xmqqfvj81oym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 13:33:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxE7n-0006Fi-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 13:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966142AbaFRLdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 07:33:51 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42775 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933182AbaFRLdu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 07:33:50 -0400
X-AuditID: 12074414-f79f86d000000b9f-bf-53a1791d5d41
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BC.88.02975.D1971A35; Wed, 18 Jun 2014 07:33:49 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IBXlCp003243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 07:33:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqqfvj81oym.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqCtbuTDY4MFBWYv5m04wWnRd6Way
	aOi9wmzx9uYSRot/E2ocWD12zrrL7rFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7Y8+c36wFc2Urfs+Ma2BcId7FyMkhIWAi8eJ3JzOELSZx4d56ti5GLg4hgcuMEnvPPGeB
	cM4zSTzuvM8IUsUroC1x9M1nJhCbRUBV4t6KNawgNpuArsSinmawuKhAkMTsz/PYIeoFJU7O
	fMICYosI+Ep8u9/HDjKUWWACo8Thf0vAVgsLeEo0PXkMte0Zo8Tqfc1gCU4Ba4lbp0Fu4gC6
	T1yipzEIJMwsoCPxru8BM4QtL7H97RzmCYyCs5Dsm4WkbBaSsgWMzKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdC30cjNL9FJTSjcxQgJfZAfjkZNyhxgFOBiVeHh37FkQLMSaWFZcmXuIUZKD
	SUmUV6hgYbAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5jxUA53pTEyqrUonyYlDQHi5I477fF
	6n5CAumJJanZqakFqUUwWRkODiUJXo0KoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTS
	kox4UAzHFwOjGCTFA7TXHaSdt7ggMRcoCtF6ilGX49SdY21MQix5+XmpUuK8l8qAigRAijJK
	8+BWwNLcK0ZxoI+FeXlBRvEAUyTcpFdAS5iAlqhMnAeypCQRISXVwDgx6tx9YVmBBTHLrl1e
	YmDYML9/goJmugz7N8PXHzq5zsruaN3mWNO6Tfe49xWDOXYzOfdFp3BuFt3P1OAf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251978>

On 06/13/2014 11:25 PM, Junio C Hamano wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
> 
>> It gets even more hairy :
>> If the server has A/a and a/b and you clone it it becomes A/a and A/b
>> locally. Then you push back to the server and you end up with three
>> refs on the server:  A/a A/b and a/b.
> 
> That is part of the transition in deployment.  David who wants to
> forbid A/a and a/b mixed in his project will surely correct the
> situation at the server end so "somebody fetches A/a and a/b and
> ends up with A/a and A/b" will not happen.  They will fetch A/a and
> A/b.
> 
> If a user is with an older Git and he has his own a/c, fetching A/a
> and A/b from a corrected central repository will still give the user
> a/a and a/b, but then pushing it back will be forbidden.  The user's
> repository needs to be fixed and installation of Git needs to be
> updated to the version with an equivalent of David's "optionally
> deny" feature implemented for the fetching side, so that the user
> notices the local a/c is bad and not allowed within the context of
> his project, deletes it and recreates it as A/c before he can fetch
> A/a and A/b from the central repository.
> 
> I agree that the transition may be painful, but as long as the
> desired semantics is "If you have A/a, you are not allowed to have
> a/a or a/b", it cannot be avoided---in that sense, I view it as a
> lower priority issue.
> 
> Having said that, it may indicate that the desired semantics above
> may not be the optimal one.  Perhaps the flag might want to be "on
> this platform, we cannot do case sensitive refs, so pretend as if
> all refs are lowercase" instead.  I suspect that such a flag may
> allow smoother transition than what has been proposed.
> 
> Underlying refs "A/a" and "a/b" can stay as they are in David's
> central repository, but ref enumeration with the flag enabled will
> return a/a and a/b, and these are the names that will be fetched by
> the users.  If the user had an existing A/c, then fetching these
> will still create A/a and A/b locally, but pushing them back will,
> under that flag enabled, be turned into updates to a/a, a/b, and a/c
> on the central server side with updated Git.

The discussion here has made it pretty clear that, given our current
loose reference and reflog storage schemes, it is not possible to
implement case-sensitive references or even case-insensitive but
case-preserving references correctly on a non-case-sensitive filesystem.
 We would always have spooky non-local conflicts like A/a vs. a/b.

I think we *could* correctly implement

* case-folded reference names (e.g., all lower-case; I wonder if
  that would also apply to HEAD etc.?)

* case-folded reference names except for the last component, which
  could be case-insensitive but case-preserving:
  refs/heads/MyCrazyBranch.  I suppose that many mixed-OS projects
  effectively use this policy nowadays and that is why we don't hear
  more complaints about this Git deficiency.

If we had an option to use only packed references in a repository, I
think we could also implement case-insensitive but case-preserving
references on a non-case-preserving filesystem.  The packed-refs file
would be authoritative WRT case, and the case of the reflog directories
and files would be ignored.  But I would be nervous about promoting this
style, because it will likely cause performance problems for repos that
have a lot of refs.

To support arbitrary refname policies on arbitrary filesystems, we of
course need a different way of storing references and reflogs.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
