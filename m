From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 06 Feb 2013 22:50:32 +0100
Message-ID: <5112D028.4050005@alum.mit.edu>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com> <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin> <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com> <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3CtQ-0008OS-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 22:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465Ab3BFVuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 16:50:37 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:44263 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755294Ab3BFVug (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 16:50:36 -0500
X-AuditID: 12074413-b7f786d0000008bb-27-5112d02b06fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 06.AC.02235.B20D2115; Wed,  6 Feb 2013 16:50:35 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r16LoWYd024448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Feb 2013 16:50:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsUixO6iqKt9QSjQoH+7uUXXlW4mi4beK8wW
	b28uYbTonvKW0eJHSw+zxfxDE1kd2Dx2zrrL7vGsdw+jx8VLyh5/zu9h9fi8SS6ANYrbJimx
	pCw4Mz1P3y6BO+PC0cPMBQfMKt48ncnUwNir3cXIySEhYCIxa/F0FghbTOLCvfVsILaQwGVG
	iZ5FdV2MXED2MSaJjTsusYIkeAW0JT59PgFWxCKgKjGj7z0jiM0moCuxqKeZCcQWFQiT6H19
	jhGiXlDi5MwnYAtEBNQkJrYdArOZBdYxSvye7AxiCwuoS+xqP8QOsWwKk8SV87/ABnEKmEls
	+/qfGaJBR+Jd3wMoW15i+9s5zBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn
	5uWlFuma6+VmluilppRuYoSEu/AOxl0n5Q4xCnAwKvHw3l4qFCjEmlhWXJl7iFGSg0lJlFfv
	JFCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/tTqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpi
	SWp2ampBahFMVoaDQ0mCV+Q8UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFbj
	i4HRCpLiAdorDdLOW1yQmAsUhWg9xWjMsf9J+3NGju2/gaQQS15+XqqUOK82SKkASGlGaR7c
	Iliie8UoDvS3MEQVDzBJws17BbSKCWiVUg4/yKqSRISUVAPjDKvtoS+/L7taJ6NplnLL/ofv
	2puV4kxtrxXTZvKrs8Yt/yt819h5zuWl+1bzPdigZFgfkHSp5z7TBzbT30+/2lZz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215645>

On 02/06/2013 08:17 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> On Tue, Feb 5, 2013 at 5:29 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Hiderefs creates a "dark" corner of a remote git repo that can hold
>>> arbitrary content that is impossible for anybody to discover but
>>> nevertheless possible for anybody to download (if they know the name of
>>> a hidden reference).  In earlier versions of the patch series I believe
>>> that it was possible to push to a hidden reference hierarchy, which made
>>> it possible to upload dark content.  The new version appears (from the
>>> code) to prohibit adding references in a hidden hierarchy, which would
>>> close the main loophole that I was worried about.  But the documentation
>>> and the unit tests only explicitly say that updates and deletes are
>>> prohibited; nothing is said about adding references (unless "update" is
>>> understood to include "add").  I think the true behavior should be
>>> clarified and tested.
>>>
>>> I was worried that somehow this "dark" content could be used for
>>> malicious purposes; for example, pushing compromised code then
>>> convincing somebody to download it by SHA1 with the implicit argument
>>> "it's safe since it comes directly from the project's official
>>> repository".  If it is indeed impossible to populate the dark namespace
>>> remotely then I can't think of a way to exploit it.
>>
>> Or you can think hiderefs is the first step to addressing the
>> initial ref advertisment problem.  The series says hidden refs are
>> to be fetched out of band, but that's not the only way.
> 
> Let me help unconfuse this thread.
> 
> I think the series as 8-patch series was poorly presented, and
> separating it into two will help understanding what they are about.
> 
> The first three:
> 
>   upload-pack: share more code
>   upload-pack: simplify request validation
>   upload/receive-pack: allow hiding ref hierarchies
> 
> is _the_ topic of the series.  As far as I am concerned (I am not
> speaking for Gerrit users, but am speaking as the Git maintainer),
> the topic is solely about uncluttering.  There may be refs that the
> server end may need to keep for its operation, but that remote users
> have _no_ business knowing about.  Allowing the server to keep these
> refs in the repository, while not showing these refs over the wire,
> is the problem the series solves.
> 
> In other words, it is not about "these are *usually* not wanted by
> clients, so do not show them by default".  It is about "these are
> not to be shown, ever".
> 
> OK?

Yes, the first three patches sound much more reasonable if this is the
goal.  Do you know of users who want the feature defined by the first
three patches, or is it only a stepping stone towards an actually useful
feature?  (I ask because I have trouble imagining a real-world scenario
where these alone would be useful.)

> Now, there may be some refs that are not *usually* wanted by clients
> but there may be cases where clients want to
> 
>  (1) learn about them via the same protocol; and/or
>  (2) fetch them over the protocol.
> 
> If you want to solve both of these two issues generally, the
> solution has to involve a separate protocol from the today's
> protocol.  It would go like this:
[... omitted clear explanation of how delayed advertisement could be
implemented via a new protocol ...]

> But in the meantime, if there is a niche use case where a solution
> to only the second problem is sufficient (and Gerrit and GitHub pull
> requests could both be such use cases), the remainder of the series
> can help, without waiting the solution to solve "usually not wanted
> but may need to be learned" problem.  That is the latter 4 patches
> (the very last one is a demonstration to illustrate why allowing a
> push to hidden ref hierarchy would not and should not work, and is
> not for application):

Given that some people *do* want to fetch all pull requests, is this a
feature that any hosting service would really turn on?  True, the
majority of users would be spared clutter, but at the cost of completely
preventing other users from fetching all pull requests, mirroring the
repository, etc.

In other words, I wonder whether your two incremental steps are useful
at all, in the real world, without yet-to-be-implemented future changes.
 If not, then it doesn't make sense to merge them without at least
imagining the final goal and gaining confidence that they are not false
starts.


I think that a more useful interim solution would be to make it easy to
have two URLs accessing a single git repository, with different levels
of reference visibility applied to each.  This is something that
providers could turn on without sacrificing any existing functionality.
 And it would solve all three problems: clutter, bandwidth, and provenance.

Your first three patches would allow two-tier access to be implemented,
for example by setting GIT_CONFIG or GIT_CONFIG_PARAMETERS or
command-line parameters differently for the processes serving the two
URLs, like:

    git upload-pack ...

vs.

    GIT_CONFIG=config-with-hidden-refs git upload-pack ...
or
    git -c transfer.hiderefs=refs/pull upload-pack ...

But this is a bit awkward because the admin would either have to
maintain two config files, or maintain the hiderefs configuration in the
script starting upload-pack rather than in the configuration file.

Therefore, I suggest a slight change to how hiderefs are configured to
make two-tier URLs easier to configure, such as

    # Define one or more views:
    [view "uncluttered"]
            hiderefs = refs/pull

    # This would set the default view for all services:
    [transfer]
            view = uncluttered

    # Peff also wanted the possibility to configure each service
    # independently which could be done like this:
    [receive]
            view = uncluttered
    [uploadpack]
            view = full

I also tentatively suggest that we add a git-level option "--view" and
an environment variable GIT_VIEW (similar to "--namespace" and
GIT_NAMESPACE) to override the default setting:

    GIT_VIEW=uncluttered git upload-pack ...

This way whoever starts the process only needs to choose a particular
view name; the actual definition would reside in the config file.

I think these changes would make it easier to support two-tier URLs and
would also leave the way open to use the "view" concept for other things
in the future.


I've said my piece now and am gratified that there has been more
discussion about your proposal, which was my main goal.  Therefore FWIW
I turn my -1 into a -0 and leave it up to the people experiencing more
clutter-induced pain to decide how to proceed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
